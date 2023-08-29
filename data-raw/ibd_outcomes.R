## code to prepare `ibd_outcomes` dataset

ibd_outcomes <- structure(list(outcome = structure(c(1L, 3L, 2L, 4L, 1L, 3L, 2L, 4L),
                                                   levels = c("Clinical response", "Steroid-free clinical response",
                                                              "Clinical remission", "Steroid-free clinical remission"),
                                                   class = "factor"),
                               timepoint = structure(c(1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L),
                                                     levels = c("Week 24", "Week 52"),
                                                     class = "factor"),
                               achieved = c(36L, 10L, 34L, 10L, 33L, 15L, 32L, 15L),
                               total = c(55L, 55L, 55L, 55L, 55L, 55L, 55L, 55L),
                               proportion = c(0.655, 0.182, 0.618, 0.182, 0.6, 0.273, 0.582, 0.273),
                               percentage = c(65.5, 18.2, 61.8, 18.2, 60, 27.3, 58.2, 27.3),
                               percentage_labelled = c("65.5%", "18.2%", "61.8%", "18.2%", "60.0%", "27.3%", "58.2%", "27.3%")),
                               row.names = c(NA, -8L), class = c("tbl_df", "tbl", "data.frame" ))

usethis::use_data(ibd_outcomes, overwrite = TRUE)
