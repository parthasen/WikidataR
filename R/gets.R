#'@title Retrieve specific Wikidata items or properties
#'@description \code{get_item} and \code{get_property} allow you to retrieve the data associated
#'with individual Wikidata items and properties, respectively.
#'
#'@param id the ID number of the item or property you're looking for. This can be in
#'various formats; either a numeric value ("200"), the full name ("Q200") or
#'even with an included namespace ("Property:P10") - the function will format
#'it appropriately.
#'
#'@param ... further arguments to pass to httr's GET.
#'
#'@seealso \code{\link{get_random}} for selecting a random item or property,
#'or \code{\link{find_item}} for using search functionality to pull out
#'item or property IDs where the descriptions or aliases match a particular
#'search term.
#'
#'@aliases get_item get_property
#'@rdname get_item
#'@export
get_item <- function(id, ...){
  id <- check_input(id, "Q")
  return(wd_query(id, ...))
}

#'@rdname get_item
#'@export
get_property <- function(id, ...){
  if(grepl("^P(?!r)",id, perl = TRUE)){
    id <- paste0("Property:",id)
  }
  id <- check_input(id, "Property:P")
  return(wd_query(id, ...))
}

#'@title Retrieve randomly-selected Wikidata items or properties
#'@description \code{get_random_item} and \code{get_random_property} allow you to retrieve the data
#'associated with randomly-selected Wikidata items and properties, respectively.
#'
#'@param ... arguments to pass to httr's GET.
#'
#'@seealso \code{\link{get_item}} for selecting a specific item or property,
#'or \code{\link{find_item}} for using search functionality to pull out
#'item or property IDs where the descriptions or aliases match a particular
#'search term.
#'
#'@aliases get_random get_random_item get_random_property
#'@rdname get_random
#'@export
get_random_item <- function(...){
  return(wd_rand_query(0, ...))
}

#'@rdname get_random
#'@export
get_random_property <- function(...){
  return(wd_rand_query(120, ...))
}

#'@title Search for Wikidata items or properties that match a search term
#'@description \code{find_item} and \code{find_property} allow you to retrieve a set
#'of Wikidata items or properties where the aliase or descriptions match a particular
#'search term.
#'
#'@param search_term a term to search for.
#'
#'@param language the language to return the labels and descriptions in; this should
#'consist of an ISO language code. Set to "en" by default.
#'
#'@param limit the number of results to return; set to 10 by default.
#'
#'@param ... further arguments to pass to httr's GET.
#'
#'@seealso \code{\link{get_random}} for selecting a random item or property,
#'or \code{\link{get_item}} for selecting a specific item or property.
#'
#'@aliases find_item find_property
#'@rdname find_item
#'@export
find_item <- function(search_term, language = "en", limit = 10, ...){
  return(searcher(search_term, language, limit, "item"))
}

#'@rdname find_item
#'@export
find_property <- function(search_term, language = "en", limit = 10){
  return(searcher(search_term, language, limit, "property"))
}