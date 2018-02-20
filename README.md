# RoogleVideo
R interface to the Google Cloud Video Intelligence API


![overview](https://i.imgur.com/lLeEG2R.png)

### Example Workflow

```r
client_id <- ""
client_secret <- ""
path_to_service_account_json <- ""

token <- service_auth(client_id, client_secret, path_to_service_account_json)

data_endpoint <- annotation_request('~/path/to/asset.mp4')

data <- get_annotations(data_endpoint)

# Returns Tibble of all labels identified in video
terms_in_video <- get_term_descriptions(data)
```
