# Jeremy Roth
rm(list=ls())
library(dplyr)
memory.limit(size=56000) 

# ddm-ready dataset with 5-year age groups: Ecuador (shared by Andres Peralta and created by publicly available data)
example_data_ecuador_initial <- read.csv("data/data_for_ddm_ecuador.csv", 
                         header=TRUE, stringsAsFactors=FALSE)
cod_names <- read.csv("data/cod_to_names.csv",
                      header=TRUE, stringsAsFactors=FALSE)
example_data_ecuador <- left_join(example_data_ecuador_initial,
                                  cod_names,
                                  by="cod")
rm(example_data_ecuador_initial)
example_data_ecuador <- example_data_ecuador %>% 
                        filter(cod != 90) %>% 
                        rename("province"="cod",
                                "province_name"="cod_name",
                                "province_name_short"="cod_name_short") %>%
                        select(province_name,
                               province_name_short,
                               sex,
                               age,
                               pop1,
                               pop2,
                               deaths,
                               date1,
                               date2)

save(example_data_ecuador, file="../SubnationalCRVS/data/example_data_ecuador.rda")

# ddm-ready dataset with 5-year age groups: Rabat
example_data_rabat <- read.csv("data/data_for_ddm_rabat.csv", 
                                 header=TRUE, stringsAsFactors=FALSE)
example_data_rabat <- example_data_rabat %>%
                      rename("residence_type"="cod")
save(example_data_rabat, file="../SubnationalCRVS/src/example_data_rabat.rda")


# load raw province-specific Census files from Ecuador that show single-year ages
# source: https://www.ecuadorencifras.gob.ec/base-de-datos-censo-de-poblacion-y-vivienda-2010/
# I will just share the tabulations that give me the age counts, though
create_single_year_ecuador <- FALSE

if (create_single_year_ecuador == TRUE) {
library(haven)
# 2010
### create shell to store single-year tabulations
ecuador_2010_age_tabulation <- as.data.frame(matrix(NA, nrow=23*2*91, ncol=4))
names(ecuador_2010_age_tabulation) <- c("province", "sex", "age", "pop2")
ecuador_2010_age_tabulation$province <- rep(c(1:21, 23:24), each=2*91)
ecuador_2010_age_tabulation$sex <- rep(c(rep(1, times=91),
                                         rep(2, times=91)), 
                                       times=23)
ecuador_2010_age_tabulation$age <- rep(rep(0:90, times=2), 
                                       times=23)

## Province 1: Azuay
SPSS_Azuay_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Azuay_Poblacion.sav")
census_2010_Azuay <- SPSS_Azuay_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Azuay_Poblacion)
### store tabulations for province 1
t <- table(census_2010_Azuay$sex,
           census_2010_Azuay$age)
stopifnot(length(unique(census_2010_Azuay$province)) == 1)
(one.province <- as.numeric(census_2010_Azuay$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Azuay)

## Province 2: Bolivar
SPSS_Bolivar_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Bolivar_Poblacion.sav")
census_2010_Bolivar <- SPSS_Bolivar_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Bolivar_Poblacion)
### store tabulations for province 2
t <- table(census_2010_Bolivar$sex,
           census_2010_Bolivar$age)
stopifnot(length(unique(census_2010_Bolivar$province)) == 1)
(one.province <- as.numeric(census_2010_Bolivar$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Bolivar)

## Province 3: Cañar
SPSS_Canar_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Canar_Poblacion.sav")
census_2010_Canar <- SPSS_Canar_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Canar_Poblacion)
### store tabulations for province 3
t <- table(census_2010_Canar$sex,
           census_2010_Canar$age)
stopifnot(length(unique(census_2010_Canar$province)) == 1)
(one.province <- as.numeric(census_2010_Canar$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Canar)

## Province 4: Carchi
SPSS_Carchi_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Carchi_Poblacion.sav")
census_2010_Carchi <- SPSS_Carchi_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Carchi_Poblacion)
### store tabulations for province 4
t <- table(census_2010_Carchi$sex,
           census_2010_Carchi$age)
stopifnot(length(unique(census_2010_Carchi$province)) == 1)
(one.province <- as.numeric(census_2010_Carchi$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Carchi)

## Province 5: Chimborazo
SPSS_Chimborazo_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Chimborazo_Poblacion.sav")
census_2010_Chimborazo <- SPSS_Chimborazo_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Chimborazo_Poblacion)
### store tabulations for province 5
t <- table(census_2010_Chimborazo$sex,
           census_2010_Chimborazo$age)
stopifnot(length(unique(census_2010_Chimborazo$province)) == 1)
(one.province <- as.numeric(census_2010_Chimborazo$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Chimborazo)


## Province 6: Cotopaxi
SPSS_Cotopaxi_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Cotopaxi_Poblacion.sav")
census_2010_Cotopaxi <- SPSS_Cotopaxi_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Cotopaxi_Poblacion)
### store tabulations for province 6
t <- table(census_2010_Cotopaxi$sex,
           census_2010_Cotopaxi$age)
stopifnot(length(unique(census_2010_Cotopaxi$province)) == 1)
(one.province <- as.numeric(census_2010_Cotopaxi$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Cotopaxi)


## Province 7: El Oro
SPSS_ElOro_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_ElOro_Poblacion.sav")
census_2010_ElOro <- SPSS_ElOro_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_ElOro_Poblacion)
### store tabulations for province 7
t <- table(census_2010_ElOro$sex,
           census_2010_ElOro$age)
stopifnot(length(unique(census_2010_ElOro$province)) == 1)
(one.province <- as.numeric(census_2010_ElOro$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_ElOro)


## Province 8: Esmeraldas
SPSS_Esmeraldas_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Esmeraldas_Poblacion.sav")
census_2010_Esmeraldas <- SPSS_Esmeraldas_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Esmeraldas_Poblacion)
### store tabulations for province 8
t <- table(census_2010_Esmeraldas$sex,
           census_2010_Esmeraldas$age)
stopifnot(length(unique(census_2010_Esmeraldas$province)) == 1)
(one.province <- as.numeric(census_2010_Esmeraldas$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Esmeraldas)

## Province 9: Guayas
SPSS_Guayas_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Guayas_Poblacion.sav")
census_2010_Guayas <- SPSS_Guayas_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Guayas_Poblacion)
### store tabulations for province 9
t <- table(census_2010_Guayas$sex,
           census_2010_Guayas$age)
stopifnot(length(unique(census_2010_Guayas$province)) == 1)
(one.province <- as.numeric(census_2010_Guayas$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Guayas)


## Province 10: Imbabura
SPSS_Imbabura_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Imbabura_Poblacion.sav")
census_2010_Imbabura <- SPSS_Imbabura_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Imbabura_Poblacion)
### store tabulations for province 10
t <- table(census_2010_Imbabura$sex,
           census_2010_Imbabura$age)
stopifnot(length(unique(census_2010_Imbaburas$province)) == 1)
(one.province <- as.numeric(census_2010_Imbabura$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Imbabura)


## Province 11: Loja
SPSS_Loja_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Loja_Poblacion.sav")
census_2010_Loja <- SPSS_Loja_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Loja_Poblacion)
### store tabulations for province 11
t <- table(census_2010_Loja$sex,
           census_2010_Loja$age)
stopifnot(length(unique(census_2010_Loja$province)) == 1)
(one.province <- as.numeric(census_2010_Loja$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Loja)

## Province 12: Los Rios
SPSS_LosRios_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_LosRios_Poblacion.sav")
census_2010_LosRios <- SPSS_LosRios_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_LosRios_Poblacion)
stopifnot(length(unique(census_2010_LosRios$province)) == 1)
(one.province <- as.numeric(census_2010_LosRios$province[1]))
### store tabulations for province 1
t <- table(census_2010_LosRios$sex,
           census_2010_LosRios$age)
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &                             
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_LosRios)


## Province 13: Manabi
SPSS_Manabi_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Manabi_Poblacion.sav")
census_2010_Manabi <- SPSS_Manabi_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Manabi_Poblacion)
### store tabulations for province 13
t <- table(census_2010_Manabi$sex,
           census_2010_Manabi$age)
stopifnot(length(unique(census_2010_Manabi$province)) == 1)
(one.province <- as.numeric(census_2010_Manabi$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Manabi)

## Province 14: Morona Santiago
SPSS_Morona_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Morona_Poblacion.sav")
census_2010_Morona <- SPSS_Morona_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Morona_Poblacion)
### store tabulations for province 14
t <- table(census_2010_Morona$sex,
           census_2010_Morona$age)
stopifnot(length(unique(census_2010_Morona$province)) == 1)
(one.province <- as.numeric(census_2010_Morona$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Morona)


## Province 15: Napo
SPSS_Napo_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Napo_Poblacion.sav")
census_2010_Napo <- SPSS_Napo_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Napo_Poblacion)

### store tabulations for province 15
t <- table(census_2010_Napo$sex,
           census_2010_Napo$age)
stopifnot(length(unique(census_2010_Napo$province)) == 1)
(one.province <- as.numeric(census_2010_Napo$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Napo)


## Province 16: Pastaza
SPSS_Pastaza_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Pastaza_Poblacion.sav")
census_2010_Pastaza <- SPSS_Pastaza_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Pastaza_Poblacion)
### store tabulations for province 16
t <- table(census_2010_Pastaza$sex,
           census_2010_Pastaza$age)
stopifnot(length(unique(census_2010_Pastaza$province)) == 1)
(one.province <- as.numeric(census_2010_Pastaza$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Pastaza)


## Province 17: Pichincha
SPSS_Pichincha_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Pichincha_Poblacion.sav")
census_2010_Pichincha <- SPSS_Pichincha_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Pichincha_Poblacion)
### store tabulations for province 17
t <- table(census_2010_Pichincha$sex,
           census_2010_Pichincha$age)
stopifnot(length(unique(census_2010_Pichincha$province)) == 1)
(one.province <- as.numeric(census_2010_Pichincha$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Pichincha)


## Province 24: SantaElena
SPSS_SantaElena_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_SantaElena_Poblacion.sav")
census_2010_SantaElena <- SPSS_SantaElena_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_SantaElena_Poblacion)
### store tabulations for province 18
t <- table(census_2010_SantaElena$sex,
           census_2010_SantaElena$age)
stopifnot(length(unique(census_2010_SantaElena$province)) == 1)
(one.province <- as.numeric(census_2010_SantaElena$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_SantaElena)


## Province 19: Zamora
SPSS_Zamora_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Zamora_Poblacion.sav")
census_2010_Zamora <- SPSS_Zamora_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Zamora_Poblacion)
### store tabulations for province 19
t <- table(census_2010_Zamora$sex,
           census_2010_Zamora$age)
stopifnot(length(unique(census_2010_Zamora$province)) == 1)
(one.province <- as.numeric(census_2010_Zamora$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Zamora)

## Province 20: Galapagos
SPSS_Galapagos_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Galapagos_Poblacion.sav")
census_2010_Galapagos <- SPSS_Galapagos_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Galapagos_Poblacion)
### store tabulations for province 20
t <- table(census_2010_Galapagos$sex,
           census_2010_Galapagos$age)
stopifnot(length(unique(census_2010_Galapagos$province)) == 1)
(one.province <- as.numeric(census_2010_Galapagos$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Galapagos)


## Province 21: Sucumbios
SPSS_Sucumbios_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Sucumbios_Poblacion.sav")
census_2010_Sucumbios <- SPSS_Sucumbios_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Sucumbios_Poblacion)
### store tabulations for province 21
t <- table(census_2010_Sucumbios$sex,
           census_2010_Sucumbios$age)
stopifnot(length(unique(census_2010_Sucumbios$province)) == 1)
(one.province <- as.numeric(census_2010_Sucumbios$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Sucumbios)

## Province 18: Tungurahua
SPSS_Tungurahua_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_Tungurahua_Poblacion.sav")
census_2010_Tungurahua <- SPSS_Tungurahua_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_Tungurahua_Poblacion)
### store tabulations for province 22
t <- table(census_2010_Tungurahua$sex,
           census_2010_Tungurahua$age)
stopifnot(length(unique(census_2010_Tungurahua$province)) == 1)
(one.province <- as.numeric(census_2010_Tungurahua$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 1 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_Tungurahua)


## Province 23: SantoDomingo
SPSS_SantoDomingo_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2010/SPSS_SantoDomingo_Poblacion.sav")
census_2010_SantoDomingo <- SPSS_SantoDomingo_Poblacion %>%
  select(I01, URP, P01, P03) %>%
  rename(province=I01, Rural=URP, sex=P01, age=P03)
rm(SPSS_SantoDomingo_Poblacion)
### store tabulations for province 23
t <- table(census_2010_SantoDomingo$sex,
           census_2010_SantoDomingo$age)
stopifnot(length(unique(census_2010_SantoDomingo$province)) == 1)
(one.province <- as.numeric(census_2010_SantoDomingo$province[1]))
#### sex==1 (men)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                            ecuador_2010_age_tabulation$sex == 1,
                            "pop2"] <- t[1, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                            ecuador_2010_age_tabulation$sex == 1 &
                            ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2,
                            "pop2"] <- t[2, as.character(0:90)]
ecuador_2010_age_tabulation[ecuador_2010_age_tabulation$province == one.province &
                              ecuador_2010_age_tabulation$sex == 2 &
                              ecuador_2010_age_tabulation$age == 90,
                            "pop2"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2010_SantoDomingo)

# save combined table
table(ecuador_2010_age_tabulation %>% filter(is.na(pop2)) %>% select(province))
stopifnot(sum(is.na(ecuador_2010_age_tabulation)) == 0)
save(ecuador_2010_age_tabulation, 
     file="SubnationalCRVS/src/ecuador_2010_age_tabulation.rda")


# 2001
library(haven)
library(dplyr)
### create shell to store single-year tabulations
ecuador_2001_age_tabulation <- as.data.frame(matrix(NA, nrow=22*2*91, ncol=4))
names(ecuador_2001_age_tabulation) <- c("province", "sex", "age", "pop1")
ecuador_2001_age_tabulation$province <- rep(1:22, each=2*91)
ecuador_2001_age_tabulation$sex <- rep(c(rep(1, times=91),
                                         rep(2, times=91)), 
                                       times=22)
ecuador_2001_age_tabulation$age <- rep(rep(0:90, times=2), 
                                       times=22)

## Province 1: Azuay
SPSS_Azuay_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_azuay.sav")
census_2001_Azuay <- SPSS_Azuay_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Azuay_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Azuay$sex,
           census_2001_Azuay$age)
(one.province <- census_2001_Azuay$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Azuay)

## Province 2: Bolivar
SPSS_Bolivar_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Bolivar.sav")
census_2001_Bolivar <- SPSS_Bolivar_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Bolivar_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Bolivar$sex,
           census_2001_Bolivar$age)
(one.province <- census_2001_Bolivar$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Bolivar)


## Province 3: Cañar
SPSS_Canar_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Canar.sav")
census_2001_Canar <- SPSS_Canar_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Canar_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Canar$sex,
           census_2001_Canar$age)
(one.province <- census_2001_Canar$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Canar)

## Province 4: Carchi
SPSS_Carchi_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Carchi.sav")
census_2001_Carchi <- SPSS_Carchi_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Carchi_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Carchi$sex,
           census_2001_Carchi$age)
(one.province <- census_2001_Carchi$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Carchi)


## Province 6: Chimborazo
SPSS_Chimborazo_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Chimborazo.sav")
census_2001_Chimborazo <- SPSS_Chimborazo_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Chimborazo_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Chimborazo$sex,
           census_2001_Chimborazo$age)
(one.province <- census_2001_Chimborazo$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Chimborazo)


## Province 5: Cotopaxi
SPSS_Cotopaxi_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Cotopaxi.sav")
census_2001_Cotopaxi <- SPSS_Cotopaxi_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Cotopaxi_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Cotopaxi$sex,
           census_2001_Cotopaxi$age)
(one.province <- census_2001_Cotopaxi$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Cotopaxi)


## Province 7: El Oro
SPSS_ElOro_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_ElOro.sav")
census_2001_ElOro <- SPSS_ElOro_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_ElOro_Poblacion)
### store tabulations for province 1
t <- table(census_2001_ElOro$sex,
           census_2001_ElOro$age)
(one.province <- census_2001_ElOro$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_ElOro)


## Province 8: Esmeraldas
SPSS_Esmeraldas_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Esmeraldas.sav")
census_2001_Esmeraldas <- SPSS_Esmeraldas_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Esmeraldas_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Esmeraldas$sex,
           census_2001_Esmeraldas$age)
(one.province <- census_2001_Esmeraldas$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Esmeraldas)



## Province 9: Guayas
SPSS_Guayas_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Guayas.sav")
census_2001_Guayas <- SPSS_Guayas_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Guayas_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Guayas$sex,
           census_2001_Guayas$age)
(one.province <- census_2001_Guayas$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Guayas)


## Province 10: Imbabura
SPSS_Imbabura_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Imbabura.sav")
census_2001_Imbabura <- SPSS_Imbabura_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Imbabura_Poblacion)
### store tabulations for province 1
t <- table(census_2001_Imbabura$sex,
           census_2001_Imbabura$age)
(one.province <- census_2001_Imbabura$province[1])
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Imbabura)


## Province 11: Loja
SPSS_Loja_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Loja.sav")
census_2001_Loja <- SPSS_Loja_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Loja_Poblacion)
stopifnot(length(unique(census_2001_Loja$province)) == 1)
(one.province <- census_2001_Loja$province[1])
### store tabulations for province 1
t <- table(census_2001_Loja$sex,
           census_2001_Loja$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Loja)


## Province 12: Los Rios
SPSS_LosRios_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_LosRios.sav")
census_2001_LosRios <- SPSS_LosRios_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_LosRios_Poblacion)
stopifnot(length(unique(census_2001_LosRios$province)) == 1)
(one.province <- census_2001_LosRios$province[1])
### store tabulations for province 1
t <- table(census_2001_LosRios$sex,
           census_2001_LosRios$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_LosRios)


## Province 13: Manabi
SPSS_Manabi_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Manabi.sav")
census_2001_Manabi <- SPSS_Manabi_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Manabi_Poblacion)
stopifnot(length(unique(census_2001_Manabi$province)) == 1)
(one.province <- census_2001_Manabi$province[1])
### store tabulations for province 1
t <- table(census_2001_Manabi$sex,
           census_2001_Manabi$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Manabi)

## Province 14: Morona Santiago
SPSS_MoronaSantiago_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_MoronaSantiago.sav")
census_2001_MoronaSantiago <- SPSS_MoronaSantiago_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_MoronaSantiago_Poblacion)
stopifnot(length(unique(census_2001_MoronaSantiago$province)) == 1)
(one.province <- census_2001_MoronaSantiago$province[1])
### store tabulations for province 1
t <- table(census_2001_MoronaSantiago$sex,
           census_2001_MoronaSantiago$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_MoronaSantiago)


## Province 15: Napo
SPSS_Napo_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Napo.sav")
census_2001_Napo <- SPSS_Napo_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Napo_Poblacion)
stopifnot(length(unique(census_2001_Napo$province)) == 1)
(one.province <- census_2001_Napo$province[1])
### store tabulations for province 1
t <- table(census_2001_Napo$sex,
           census_2001_Napo$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Napo)


## Province 22: Orellana
SPSS_Orellana_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Orellana.sav")
census_2001_Orellana <- SPSS_Orellana_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Orellana_Poblacion)
stopifnot(length(unique(census_2001_Orellana$province)) == 1)
(one.province <- census_2001_Orellana$province[1])
### store tabulations for province 1
t <- table(census_2001_Orellana$sex,
           census_2001_Orellana$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Orellana)


## Province 16: Pastaza
SPSS_Pastaza_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Pastaza.sav")
census_2001_Pastaza <- SPSS_Pastaza_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Pastaza_Poblacion)
stopifnot(length(unique(census_2001_Pastaza$province)) == 1)
(one.province <- census_2001_Pastaza$province[1])
### store tabulations for province 1
t <- table(census_2001_Pastaza$sex,
           census_2001_Pastaza$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Pastaza)


## Province 22: Orellana
SPSS_Orellana_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Orellana.sav")
census_2001_Orellana <- SPSS_Orellana_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Orellana_Poblacion)
stopifnot(length(unique(census_2001_Orellana$province)) == 1)
(one.province <- census_2001_Orellana$province[1])
### store tabulations for province 1
t <- table(census_2001_Orellana$sex,
           census_2001_Orellana$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Orellana)


## Province 16: Pastaza
SPSS_Pastaza_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Pastaza.sav")
census_2001_Pastaza <- SPSS_Pastaza_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Pastaza_Poblacion)
stopifnot(length(unique(census_2001_Pastaza$province)) == 1)
(one.province <- census_2001_Pastaza$province[1])
### store tabulations for province 1
t <- table(census_2001_Pastaza$sex,
           census_2001_Pastaza$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Pastaza)


## Province 17: Pichincha
SPSS_Pichincha_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Pichincha.sav")
census_2001_Pichincha <- SPSS_Pichincha_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Pichincha_Poblacion)
stopifnot(length(unique(census_2001_Pichincha$province)) == 1)
(one.province <- census_2001_Pichincha$province[1])
### store tabulations for province 1
t <- table(census_2001_Pichincha$sex,
           census_2001_Pichincha$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Pichincha)


## Province 21: Sucumbios
SPSS_Sucumbios_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Sucumbios.sav")
census_2001_Sucumbios <- SPSS_Sucumbios_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Sucumbios_Poblacion)
stopifnot(length(unique(census_2001_Sucumbios$province)) == 1)
(one.province <- census_2001_Sucumbios$province[1])
### store tabulations for province 1
t <- table(census_2001_Sucumbios$sex,
           census_2001_Sucumbios$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Sucumbios)


## Province 18: Tungurahua
SPSS_Tungurahua_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Tungurahua.sav")
census_2001_Tungurahua <- SPSS_Tungurahua_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Tungurahua_Poblacion)
stopifnot(length(unique(census_2001_Tungurahua$province)) == 1)
(one.province <- census_2001_Tungurahua$province[1])
### store tabulations for province 1
t <- table(census_2001_Tungurahua$sex,
           census_2001_Tungurahua$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Tungurahua)


## Province 19: Zamora
SPSS_Zamora_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Zamora.sav")
census_2001_Zamora <- SPSS_Zamora_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Zamora_Poblacion)
stopifnot(length(unique(census_2001_Zamora$province)) == 1)
(one.province <- census_2001_Zamora$province[1])
### store tabulations for province 1
t <- table(census_2001_Zamora$sex,
           census_2001_Zamora$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Zamora)


## Province 20: Galápagos
SPSS_Galapagos_Poblacion <- read_sav("G:/My Drive/UNFPA/DDM_and_DemoTools_Ecuador/Data/census_2001/poblac_Galapagos.sav")
census_2001_Galapagos <- SPSS_Galapagos_Poblacion %>%
  select(PROVIN, SEXO, EDAD) %>%
  rename(province=PROVIN, sex=SEXO, age=EDAD)
rm(SPSS_Galapagos_Poblacion)
stopifnot(length(unique(census_2001_Galapagos$province)) == 1)
(one.province <- census_2001_Galapagos$province[1])
### store tabulations for province 1
t <- table(census_2001_Galapagos$sex,
           census_2001_Galapagos$age)
#### sex==1 (men)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1,
                            "pop1"] <- t[1, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 1 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[1, 90:length(colnames(t))])
#### sex==2 (women)
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &                              ecuador_2001_age_tabulation$sex == 2,
                            "pop1"] <- t[2, as.character(0:90)]
ecuador_2001_age_tabulation[ecuador_2001_age_tabulation$province == one.province &
                              ecuador_2001_age_tabulation$sex == 2 &
                              ecuador_2001_age_tabulation$age == 90,
                            "pop1"] <- sum(t[2, 90:length(colnames(t))])
rm(census_2001_Galapagos)


# save combined table
table(ecuador_2001_age_tabulation %>% filter(is.na(pop1)) %>% select(province))
stopifnot(sum(is.na(ecuador_2001_age_tabulation)) == 0)
save(ecuador_2001_age_tabulation, 
     file="SubnationalCRVS/src/ecuador_2001_age_tabulation.rda")


# merge pop1 and pop2
ecuador_age_tabulation <- left_join(x=ecuador_2010_age_tabulation,
                                    y=ecuador_2001_age_tabulation,
                                    by=c("province", "sex", "age"))
## check counts of missing values (should only occur for pop1 in provinces 23 and 24)
apply(ecuador_age_tabulation, 2, function(x) sum(is.na(x)))
ecuador_age_tabulation %>% filter(is.na(pop1)) %>% select(province) %>% table()
ecuador_age_tabulation %>% filter(is.na(pop1)) %>% group_by(province) %>% tally()
## add date variables 
ecuador_age_tabulation$date1 <- "2001-11-25"
ecuador_age_tabulation$date2 <- "2010-11-28"
## any other formatting
ecuador_age_tabulation <- ecuador_age_tabulation %>%
                          mutate(sex=recode(sex,
                                            `1`="m",
                                            `2`="f"))

ecuador_age_tabulation <- left_join(ecuador_age_tabulation,
                                    cod_names,
                                    by=c("province"="cod")) %>%
  rename("province_name"="cod_name",
         "province_name_short"="cod_name_short")
ecuador_age_tabulation <- ecuador_age_tabulation %>% filter(is.na(province_name_short) == FALSE)
ecuador_age_tabulation <- ecuador_age_tabulation %>%
  select(province_name,
       province_name_short,
       sex,
       age,
       pop1,
       pop2,
       date1,
       date2)

save(ecuador_age_tabulation, 
     file="../SubnationalCRVS/data/ecuador_age_tabulation.rda")

} else {
  load("../SubnationalCRVS/data/ecuador_age_tabulation.rda")
}

