rm(list=ls())

library(openxlsx)
library(tidyverse)
library(gtsummary)

setwd("~/Workspace/CosmosMedic/")

df = read.xlsx("data/raw_stomach_dataset.xlsx")
df = df %>% 
  filter(!is.na(target)) %>% 
  mutate(
    BMI = weight / (height * height / 10000),
    gender = ifelse(gender == "M", 1, 0),
    is_operation = ifelse(is_operation == "유", 1, 0),
    is_pain = ifelse(is_pain == "유", 1, 0),
    pain_NRS = as.integer(pain_NRS),
    is_medical_history = ifelse(is_medical_history == "유", 1, 0),
    is_alertness = ifelse(alertness_entering == "Alert", 1, 0),
    target = ifelse(target == "입원", 1, 
                    ifelse(target == "수술", 2, 0)),
    is_temperature = ifelse(temperature >= 38 | temperature < 36, 1, 0),
    is_pulse = ifelse(pulse <= 100, 1, 0),
    is_respiration = ifelse(respiration >= 20, 1, 0), 
    is_digestive = ifelse(소화기계이상없음 == "N", 1, 0),
    is_hemoptysis = ifelse(is_hemoptysis == "Y", 1, 0),
    is_bloody_excrement = ifelse(is_bloody_excrement == "Y", 1, 0)
    ) %>% 
  mutate(
    center = as.factor(center),
    gender = as.factor(gender),
    BMI_group = as.factor(ifelse(BMI < 25, 1, ifelse(BMI < 30, 2, 3))),
    is_operation = as.factor(is_operation),
    is_pain = as.factor(is_pain),
    is_medical_history = as.factor(is_medical_history),
    is_alertness = as.factor(is_alertness),
    is_temperature = as.factor(is_temperature),
    is_pulse = as.factor(is_pulse),
    is_respiration = as.factor(is_respiration),
    is_digestive = as.factor(is_digestive),
    is_hemoptysis = as.factor(is_hemoptysis),
    is_bloody_excrement = as.factor(is_bloody_excrement),
    target = as.factor(target)
  ) %>% 
  select(center, age, gender, height, weight, BMI, BMI_group, is_operation, 
         is_pain, pain_NRS, is_medical_history, is_alertness, is_temperature, 
         is_pulse, is_respiration, is_digestive, is_hemoptysis, is_bloody_excrement, 
         target, operation_title, main_symtom_1, main_symtom_2, 
         pulse, temperature, respiration) 

df %>% 
  select(-c(operation_title, main_symtom_1, main_symtom_2)) %>% 
  drop_na() %>% 
  tbl_summary(
    by = target,
    statistic = list(all_continuous() ~ "{mean} ({sd})",
                     all_categorical() ~ "{n} ({p}%)"),
    digits = all_continuous() ~ 2,
    missing_text = "(Missing)"
  ) %>% 
  add_p(pvalue_fun = ~style_pvalue(.x, digits = 2)) %>%
  add_overall()

write.xlsx(df, "data/prepared_dataset.xlsx")
