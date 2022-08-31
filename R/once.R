#' Execute Expensive Operations Only Once
#'
#' The `once()` function allows you to easily execute expensive compute operations only once, and save the resulting object to disk.
#'
#' @param expr The expensive expression to evaluate
#' @param file_path File path for saving the output object as an Rds file. Note that if no file name is provided it will not save!
#' @param rerun Rerun the expression anyway and save the result? Defaults to false.
#'
#' @return the results of expr
#' @export
#'
#' @examples
#' save_file <- tempfile(fileext = ".Rds")
#'  # temporary file path - replace with your preferred saved file path
#' my_out <-
#'   runif(1e8) %>% # some expensive operation
#'   mean() %>%
#'   once(file_path = save_file)
#'   # only do it once, save output to this file.
once <- function(expr,
                 file_path = NULL,
                 rerun = FALSE){

  #if there's no file path, don't save.
  if (is.null(file_path)) {

    # # Default file path behavior not allowed by CRAN.
    # datetime_string <- as.character(format(Sys.time(),
    #                                        "%Y_%m_%d_T_%H_%M_%S"))
    # file_path <- here::here("saved_objects",
    #                         paste0("once_",
    #                                datetime_string,
    #                                ".Rds"))

    # So just return the expression without saving.
    output <-
      eval(expr = expr)

  }

  if (file.exists(file_path) & !rerun){
    # if the file exists and we don't want to re-run the code,
    # load the object from the file.

    output <- readRDS(file = file_path)

  } else {

    # Create the directory if it doesn't exist
    output_dir <- dirname(file_path)

    if (!dir.exists(output_dir)) {
      dir.create(output_dir,
                 recursive = T)
    }

    # Run the expensive operation
    output <-
      eval(expr = expr)

    #Save the output to disk
    saveRDS(output, file = file_path)

  }
  # Return the object
  return(output)
}
