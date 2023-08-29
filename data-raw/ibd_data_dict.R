## code to prepare `ibd_data_dict`

ibd_data_dict <- rbind(
  data.frame(
    variable = "gender",
    variable_label = "Gender",
    value = c("M", "F"),
    value_label = c("Male", "Female")
  ),
  data.frame(
    variable = "smoking",
    variable_label = "Smoking status",
    value = c("0", "1", "2"),
    value_label = c("Never smoked", "Smoker currently", "Ex-smoker")
  ),
  data.frame(
    variable = "age_montreal",
    variable_label = "Age at diagnosis (year)",
    value = c("A1", "A2", "A3"),
    value_label = c("< 17 years", "17-40 years", "> 40 years")
  ),
  data.frame(
    variable = "age_at_diagnosis_yrs",
    variable_label = "Age at diagnosis (year)",
    value = c("A1", "A2", "A3"),
    value_label = c("< 17 years", "17-40 years", "> 40 years")
  ),
  data.frame(
    variable = "disease_extent",
    variable_label = "Disease extent",
    value = c("E1", "E2", "E3"),
    value_label = c("Proctitis", "Left-sided colitis", "Extensive colitis")
  ),
  data.frame(
    variable = "disease_location",
    variable_label = "Disease location",
    value = c("L1", "L2", "L3"),
    value_label = c("Ileal", "Colonic", "Ileocolonic")
  ),
  data.frame(
    variable = "disease_behaviour",
    variable_label = "Disease behaviour",
    value = c("B1", "B2", "B3", "B2-B3"),
    value_label = c("Inflammatory", "Fibrostenotic", "Penetrating", "Penetrating")
  ),
  data.frame(
    variable = "reason_stop_ust",
    variable_label = "Reason for ustekinumab discontinuation",
    value = c("lor", "pnr", "ae"),
    value_label = c("Loss of response", "Primary non-response", "Adverse events")
  ),
  data.frame(
    variable = "concomitant_cs",
    variable_label = "Concomitant corticosteroids",
    value = c("no", "top", "sys"),
    value_label = c("None", "Topical", "Systemic")
  ),
  data.frame(
    variable = c(
      "age_yrs", "age", "disease_duration_yrs", "bmi_kg_m2", "calprotectin_ug_g",
      "albumin_g_l", "crp_mg_l", "ses_cd", "uceis", "pmayo", "mes",
      "current_smoker", "female_gender", "family_history", "peri_anal_disease",
      "upper_gi_disease", "concomitant_imm", "concomitant_5asa", "concomitant_advanced",
      "current_fibrostenosing", "current_penetrating", "any_resection_before",
      "three_advanced", "four_advanced", "five_advanced", "previous_ustekinumab"
    ),
    variable_label = c(
      "Age (year)", "Age (year)", "Disease duration (year)", "Body mass index (kg/m²)",
      "Faecal calprotectin (ug/g)", "Serum albumin (g/L)", "C-reactive protein (mg/L)",
      "Simple endoscopic score for Crohn's disease", "Ulcerative colitis endoscopic index of severity",
      "Partial Mayo score", "Mayo endoscopic subscore", "Current smoking", "Female",
      "Family history of IBD", "Perianal modifier", "Upper GI modifier", "Concomitant immunomodulators",
      "Concomitant 5-aminosalicylates", "Concomitant advanced therapies",
      "Current fibrostenosing complications", "Current penetrating complications",
      "Previous CD-related intestinal resection", "≥ 3", "≥ 4", "≥ 5",
      "Previous ustekinumab"
    ),
    value = NA,
    value_label = NA
  )
)

usethis::use_data(ibd_data_dict, overwrite = TRUE)
