# Step 1: RTFM https://metmuseum.github.io/

# Step 2: Playing Around Manually

# visit some links, get ids
# https://collectionapi.metmuseum.org/public/collection/v1/search?q=
# https://collectionapi.metmuseum.org/public/collection/v1/search?q=umbrella


# Step 3: Write a Wrapper

# Read the Manual? Yup? You must know it's a JSON API
# So our wrappers might wanna use this library and
# let a pro like Jeroen do the job rather than write
# all this JSON stuff from scratch.
library(jsonlite)


#' Search MET
#'
#' This function searches the MET's archive for keywords and
#' returns object ids of search hits. It is a simple wrapper
#' around the MET's Application Programming interface (API).
#' The function is designed to work with other API wrappers
#' and use object ids as an input.
#' @param character search term
#' @return list containing the totoal number of objects found
#' and a vector of object ids.
#'
# Note these declaration are not relevant when code is not
# part of a package, hence you need to call library(jsonlite)
# in order to make this function work if you are not building
# a package.
#' @examples
#' search_met("umbrella")
#' @importFrom jsonlite formJSON
#' @export
search_met <- function(keyword){
  # note how URLencode improves this function
  # because spaces are common in searches
  # but are not allowed in URLs
  url <- sprintf("https://collectionapi.metmuseum.org/public/collection/v1/search?q=%s", URLencode(keyword))
  fromJSON(url)
}




download_met_images_by_id <- function(ids,
                                      download = "primaryImage") {
  # Obtain meta description objects from MET API
  obj_list <- lapply(ids, function(x) {
    req <- download.file(sprintf("https://collectionapi.metmuseum.org/public/collection/v1/objects/%d",
                   x),destfile = "temp.json")
    fromJSON("temp.json")
  })

  # Extract the list elements that contains
  # img URLs in order to pass it to the download function
  img_urls <- lapply(obj_list, "[[", download)
  # Note the implicit return, no return statement needed
  # last un-assigned statement is returned from the function
  lapply(seq_along(img_urls), function(x) {
    download.file(img_urls[[x]],
                  destfile = sprintf("data/image_%d.jpg", x)
    )
  })
}


# Step 4: Use the Wrapper
umbrella_ids <- search_met("umbrella")
umbrella_ids
download_met_images_by_id(umbrella_ids$objectIDs[2:4])

