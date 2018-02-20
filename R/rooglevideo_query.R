#' Title
#'
#' @param asset_path
#'
#' @return
#' @export
#'
#' @examples
annotation_request <- function(asset_path) {

  if(!is.character(asset_path))
    stop("WRONG TYPE: asset_path must be a STRING")

  feature <- "LABEL_DETECTION"
  base64_asset <- to_b64(asset_path)
  body  <- paste0('{ "inputContent": "',base64_asset,'", "features": "',feature,'"}')

  api_request  <- gar_api_generator(baseURI = "https://videointelligence.googleapis.com/v1/videos:annotate", http_header = "POST")
  api_response  <- api_request(the_body = body)

  return(api_response$content$name)
}

#' Title
#'
#' @param name
#'
#' @return
#' @export
#'
#' @examples
get_annotations <- function(name) {

  if(!is.character(name))
    stop("WRONG TYPE: name must be a STRING")

  annotation_url <- glue::glue("https://videointelligence.googleapis.com/v1/operations/{name}")
  annotation_get <- gar_api_generator(baseURI = annotation_url, http_header = "GET")
  annotation_response <- annotation_get(the_body = NULL)

  return(annotation_response$content)
}

#' Title
#'
#' @param request_content
#'
#' @return
#' @export
#'
#' @examples
get_segments <- function(request_content) {
  return(as.data.frame(request_content$response$annotationResults$segmentLabelAnnotations))
}

#' Title
#'
#' @param request_content
#'
#' @return
#' @export
#'
#' @examples
get_shot_labels <- function(request_content) {
  return(as.data.frame(request_content$response$annotationResults$shotLabelAnnotations))
}

#' Title
#'
#' @param request_content
#'
#' @return
#' @export
#'
#' @examples
get_term_descriptions <- function(request_content) {
  term_df <- as.data.frame(request_content$response$annotationResults$shotLabelAnnotations)
  return(tibble::as_tibble(term_df$entity$description))
}

#' Title
#'
#' @param request_content
#'
#' @return
#' @export
#'
#' @examples
get_term_timestamps <- function(request_content) {
  term_df <- as.data.frame(request_content$response$annotationResults$shotLabelAnnotations)
  term_timestamps <- term_df[, c("segments")]
  return(term_timestamps)
}
