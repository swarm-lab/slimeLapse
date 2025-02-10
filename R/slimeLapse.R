#' @export
slimeLapse <- function(cams, wemo) {
  initCam(cams)

  ui <- svDialogs::dlgInput(message = "Duration of the experiment in seconds")
  duration <- as.numeric(gsub("[^0-9]", "", ui$res))

  ui <- svDialogs::dlgInput(message = "Interval between 2 pictures in seconds")
  interval <- as.numeric(gsub("[^0-9]", "", ui$res))

  times <- now() + seq(0, duration, interval) * 1000

  pb <- progress::progress_bar$new(total = length(times), format = "Progress [:bar] :percent")

  for (i in 1:length(times)) {
    check <- tryCatch(magicLamp::wemo_STATE(wemo)$state == "OFF", error = function(e) NA)
    while(check | is.na(check)) {
      check <- tryCatch(magicLamp::wemo_ON(wemo)$success, error = function(e) NA)

      if (check | is.na(check)) {
        check <- tryCatch(magicLamp::wemo_STATE(wemo)$state == "OFF", error = function(e) NA)
      }
      
      Sys.sleep(0.1)
    }

    Sys.sleep(2)

    grabPicture(cams)
    print(paste0("Last picture taken at: ", Sys.time()))

    Sys.sleep(2)

    check <- tryCatch(magicLamp::wemo_STATE(wemo)$state == "ON", error = function(e) NA)
    while(check | is.na(check)) {
      check <- tryCatch(magicLamp::wemo_OFF(wemo)$success, error = function(e) NA)
      
      if (check | is.na(check)) {
        check <- tryCatch(magicLamp::wemo_STATE(wemo)$state == "ON", error = function(e) NA)
      }

      Sys.sleep(0.1)
    }

    if (i < length(times)) {
      Sys.sleep((times[i + 1] - now()) / 1000)
    }

    pb$tick()
  }

  NULL
}
