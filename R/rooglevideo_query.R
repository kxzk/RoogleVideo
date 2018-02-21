#' Generate Annotations For A Video
#'
#' @param asset_path A string with the path to the asset to annotate.
#' @param feature A string containing one of the following options:
#' 'LABEL_DETECTION', 'SHOT_CHANGE_DETECTION', 'EXPLICIT_CONTENT_DETECTION'
#'
#' @return An endpoint containing the location of the operation.
#' @export
#'
#' @examples
#' \dontrun{
#' annotation_request('~/Desktop/test_video.mp4', 'LABEL_DETECTION')
#' }
annotation_request <- function(asset_path, feature) {

  if(!is.character(asset_path))
    stop("WRONG TYPE: asset_path must be a STRING")
  if(!is.character(feature))
    stop("WRONG TYPE: feature must be a STRING")

  features <- feature
  base64_asset <- to_b64(asset_path)
  body  <- paste0('{ "inputContent": "',base64_asset,'", "features": "',features,'"}')

  api_request  <- googleAuthR::gar_api_generator(baseURI = "https://videointelligence.googleapis.com/v1/videos:annotate", http_header = "POST")
  api_response  <- api_request(the_body = body)

  return(api_response$content$name)
}

#' Get Data From Annotation Request
#'
#' @param name A string containing the endpoint returned from annotation_request().
#'
#' @return A list of DataFrames with data pertaining to the annotations.
#' @export
#'
#' @examples
get_annotations <- function(name) {

  if(!is.character(name))
    stop("WRONG TYPE: name must be a STRING")

  annotation_url <- glue::glue("https://videointelligence.googleapis.com/v1/operations/{name}")
  annotation_get <- googleAuthR::gar_api_generator(baseURI = annotation_url, http_header = "GET")
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
