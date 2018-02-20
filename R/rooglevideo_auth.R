#' Web Browser Auth For Google Video Intelligence API
#'
#' This method is best for interactive sessions. You
#' will need to register a project with Google and
#' obtain OAuth credentials.
#'
#' @param client_id A string containing the client_id given from Google.
#' @param client_secret A string containing the client_secret give from Google.
#'
#' @return An access token for use within the session.
#' @export
web_auth <- function(client_id, client_secret) {

  if(!is.character(client_id))
    stop("WRONG TYPE: client_id must be a STRING")
  if(!is.character(client_secret))
    stop("WRONG TYPE: client_secret must be a STRING")

  options("googleAuthR.client_id" = client_id)
  options("googleAuthR.client_secret" = client_secret)
  options("googleAuthR.scopes.selected" = c("https://www.googleapis.com/auth/cloud-platform"))

  googleAuthR::gar_auth()
}

#' Service Account Auth For Google Video Intelligence API
#'
#' Ideal for use in automated scripts or Shiny apps. No
#' browser will pop up during this method. Instead, you will
#' need to receive a service account `.json` file from
#' Google. This file will contain your private key, which
#' should be kept secret. Additionally, you will need
#' OAuth creds to obtain the client id and secret.
#'
#' @param client_id A string containing the client_id given from Google.
#' @param client_secret A string containin the client secret given from Google.
#' @param service_json A string path to your service account .json file.
#'
#' @return A service token for use within the session.
#' @export
service_auth <- function(client_id, client_secret, service_json) {

  if(!is.character(client_id))
    stop("WRONG TYPE: client_id must be a STRING")
  if(!is.character(client_secret))
    stop("WRONG TYPE: client_secret must be a STRING")
  if(!is.character(service_json))
    stop("WRONG TYPE: service_json must be a STRING")

  options("googleAuthR.webapp.client_id" = client_id)
  options("googleAuthR.webapp.client_secret" = client_secret)
  options("googleAuthR.scopes.selected" = c("https://www.googleapis.com/auth/cloud-platform"))

  service_token  <- googleAuthR::gar_auth_service(json_file = service_json)
}
