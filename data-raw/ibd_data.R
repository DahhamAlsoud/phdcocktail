## code to prepare `ibd_data` datasets

#ibd_data1
ibd_data1 <- data.frame(
  patientid = 1:30,
  gender = sample(c("F", "M"), 30, replace = TRUE),
  disease_location = sample(c("L1", "L2", "L3"), 30, replace = TRUE),
  disease_behaviour = sample(c("B1", "B2", "B3"), 30, replace = TRUE),
  crp_mg_l = round(c(rgamma(15, shape = 5, rate = 2), rgamma(15, shape = 2, rate = 0.5) * 10), 1),
  calprotectin_ug_g = round(c(runif(15, min = 30, max = 150), runif(15, min = 300, max = 1800)), 1)
)

usethis::use_data(ibd_data1, overwrite = TRUE)

#ibd_data2
ibd_data2 <- ibd_data1

ibd_data2$disease_location[sample(1:15, 3)] <- NA

ibd_data2$disease_location[sample(15:30, 2)] <- "L11"

usethis::use_data(ibd_data2, overwrite = TRUE)
