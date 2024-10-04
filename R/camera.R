#' @export
initCam <- function(cams) {
  for (i in 1:length(cams)) {
    RCurl::getURL(paste0("http://", cams[i], "/cam.cgi?mode=camcmd&value=recmode"))
  }
}

#' @export
grabPicture <- function(cams) {
  for (i in 1:length(cams)) {
    RCurl::getURL(paste0("http://", cams[i], "/cam.cgi?mode=camcmd&value=capture"))
  }
}
