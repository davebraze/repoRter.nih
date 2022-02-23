#' @title get_nih_data
#'
#' @description Easily send a pre-made json request to NIH RePORTER Project API, retrieve and process the results
#'
#' @param query A valid json request formatted for the RePORTER Project API, as returned by the \code{make_req()} method
#' @param max_pages numeric(1); default: NULL; An integer specifying to only fetch (up to) the first \code{max_pages} number of pages from the result set.
#'     Useful for testing your query/obtaining schema information. Default behavior is to fetch all pages.
#' @param flatten_result (placeholder, non-functional) (default: FALSE) If TRUE, flatten nested dataframes and
#'     collapse nested vectors to a single character column with elements delimited by ";"
#' 
#' @return A tibble containing your result set up to 100,000 records
#' 
#' @details A request to the RePORTER Project API requires retrieving paginated results, combining them, and often
#'     flattening the combined ragged data.frame to a familiar flat format which we can use in analyses. This
#'     method handles all of that for you.
#' 
#' @keywords covid-19, coronavirus, NIH, research, grant, funding, federal, api
#' 
#' @examples
#' library(repoRter.nih)
#' 
#' ## make the usual request
#' req <- make_req(criteria = 
#'                     list(advanced_text_search = 
#'                         list(operator = "Or",
#'                              search_field = "all",
#'                              search_text = "sarcoidosis lupus") ),
#'                  message = FALSE)
#' 
#' ## get the data ragged
#' res <- get_nih_data(req,
#'                     max_pages = 1)
#' 
#' ## get the data flattened
#' res_flattened <- get_nih_data(req,
#'                               flatten_result = TRUE,
#'                               max_pages = 1)
#' 
#' @rawNamespace import(tibble, except = "has_name")
#' @import dplyr
#' @import httr
#' @import jsonlite
#' @import crayon
#' @import magrittr
#' @importFrom janitor "clean_names"
#' @export
get_nih_data <- function(query, max_pages = NULL, flatten_result = FALSE) {
  
  assert_that(validate(query),
              is.numeric(max_pages) | is.null(max_pages),
              is.logical(flatten_result) )
  
  endpoint <- "https://api.reporter.nih.gov/v2/projects/Search"
  query_lst <- fromJSON(query)
  
  pages <- list()
  offset <- as.numeric(query_lst$offset)
  limit <- as.numeric(query_lst$limit)
  
  message("Retrieving first page of results (up to ", limit, " records)")
  
  res <- tryCatch(
    {
      RETRY("POST",
            url = endpoint,
            accept("text/plain"),
            content_type_json(),
            body = query)
    },
    error = function(msg) {
      message(paste0("Failed unexpectedly on initial connect to API. Here is the error message from POST call:\n",
                     red(msg)) )
      stop("Exiting from get_nih_data()")
    }
  )
  
  if (res$status_code != 200) {
    stop("API Error: received non-200 response")
  }
  
  res %<>% content(as = "text") %>%
    fromJSON()
  meta <- res$meta
  
  if (meta$total == 0) {
    message(green("Done - 0 records returned. Try a different search criteria."))
    return(NA)
  } 
  
  pages[[1]] <-  res %>%
    extract2("results")
  
  page_count <- ceiling(meta$total / limit)
  
  if (!is.null(max_pages)) {
    if (max_pages >= page_count) {
      message(paste0("max_pages set to ", max_pages, " by user, but result set only contains ", page_count, " pages.  Retrieving the full result set..."))
    } else if (max_pages < page_count) {
      message(paste0("max_pages set to ", max_pages, " by user. Result set contains ", page_count, " pages. Only partial results will be retrieved."))
    }
    iters <- min(page_count, max_pages)
  } else {
    iters <- page_count
  }
  
  if (iters > 1) {
    Sys.sleep(1)
    for (i in 2:iters) {
      new_offset <- (i-1)*limit
      query <- gsub(paste0("\"offset\":", (new_offset/limit)-i+1), paste0("\"offset\":", new_offset), query)
      
      message("Retrieving results ", (i-1)*limit+1, " to ", min((i)*limit, meta$total), " of ", meta$total)
      res <- RETRY("POST",
                   url = endpoint,
                   accept("text/plain"),
                   content_type_json(),
                   body = query)
      
      if (res$status_code != 200) {
        message(paste0("API request failed for page #", i, ". Skipping to next page."))
        next
      }
      
      res %<>% content(as = "text") %>%
        fromJSON()
      
      pages[[i]] <- res$results
      Sys.sleep(1)
    }
  }
  
  ## fails during devtools::check() with an error
  ## message about installing plyr
  # ret <- bind_rows(pages) %>%
  #   as_tibble()
  
  df <- bind_rows(pages)
  ret <- as_tibble(df)
  
  if (flatten_result) {
    # flatten nested data frames (not lists of data frames)
    ret %<>% 
      flatten() %>%
      clean_names() %>%
      as_tibble()
    
    # flatten lists of vectors
    ret %<>% 
      mutate(across(, function(x) {
        if (is.list(x) && is.vector(x[[1]]) && is.atomic(x[[1]])) {
          sapply(x, function(y) paste0(y, collapse = ";")) %>%
            return()
        } else { return(x) }
      }))
  }
  
  ret %>%
    return()
}
