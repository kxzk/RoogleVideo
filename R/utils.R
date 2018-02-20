#' Convert To Base64 Encoded String
#'
#' @param asset_path A string consisting of a file path
#' to the asset to convert (.mp4, .gif, etc..).
#'
#' @return A base64 encoded string.
#' @export
to_b64 <- function(asset_path) {

  if(!is.character(asset_path))
    stop("WRONG TYPE: asset_path must be a STRING")

  b64 <- base64enc::base64encode(asset_path)
  return(b64)

}
