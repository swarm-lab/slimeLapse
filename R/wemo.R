#' @export
lightON <- function(wemo) {
  script <- paste0(find.package("slimeLapse"), "/wemo_control.sh")
  system(paste0(script, " ", wemo, " ON"), ignore.stdout = TRUE, ignore.stderr = TRUE)
}

#' @export
lightOFF <- function(wemo) {
  script <- paste0(find.package("slimeLapse"), "/wemo_control.sh")
  system(paste0(script, " ", wemo, " OFF"), ignore.stdout = TRUE, ignore.stderr = TRUE)
}
