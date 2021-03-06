Prediction of incident major depressive disorder in cardiovascular patients using beta blockers
=============

<img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started">

- Analytics use case(s): **Patient-Level Prediction**
- Study type: **Clinical Application**
- Tags: **-**
- Study lead: **Suho Jin, Seng Chan You**
- Study lead forums tag: **[Suho_Jin](https://forums.ohdsi.org/u/Suho_Jin), [SCYou](https://forums.ohdsi.org/u/SCYou)**
- Study start date: **Sep 28, 2020**
- Study end date: **-**
- Protocol: **[Protocol](https://github.com/ohdsi-studies/MddAfterBbValidation/blob/master/documents/MddAfterBbProtocol.docx)**
- Publications: **-**
- Results explorer: **-**

Introduction
============
This package contains code to externally validate machine learning model predicting newly diagnosed MDD patients within 1 year after initiation of beta-blocker for cardiovascular disease. The algorithm was developed on the Korean National Health Insurance Service - National Sample Cohort.

If you would like to participate, please let us by November 14, 2020. We hope to have all of the data analysis performed by the end of October 2020, and then will submit a manuscript with participants as co-authors. 


You may contact us at the following emails:

Suho Jin: spa7652@gmail.com

Seng Chan You: seng.chan.you@ohdsi.org

System Requirements
===================
  * Requires: OMOP CDM database and connection details
  * Requires: Java runtime enviroment (for the database connection)
  * Requires: R (version 3.3.0 or higher).

Dependencies
============
  * PatientLevelPrediction

A1. Installing the package from GitHub
===============
```r
# To install the package from github:
install.packages("devtools")
devtools::install_github("ohdsi-studies/MddAfterBbValidation")
```

A2. Building the package inside RStudio
===============
  1. Open the validation package project file (file ending in .Rproj) 
  2. Build the package in RStudio by selecting the 'Build' option in the top right (the tabs contain  'Environment', 'History', 'Connections', 'Build', 'Git') and then clicking on the 'Install and Restart'

B. Getting Started
===============
  1. Make sure to have either: installed (A1) or built (A2) the package 
  2. In R, run the code in 'extras/codeToRun.R' (see [Skeleton Validation Study guide](https://github.com/OHDSI/StudyProtocolSandbox/tree/master/MddAfterBbValidation/inst/doc/UsingSkeletonValidationPackage.pdf) for guideance)


C. Example Code
===============
```r
library(MddAfterBbValidation)

# add details of your database setting:
databaseName <- 'add a shareable name for the database you are currently validating on'

# add the cdm database schema with the data
cdmDatabaseSchema <- 'your cdm database schema for the validation'

# add the work database schema this requires read/write privileges 
cohortDatabaseSchema <- 'your work database schema'

# if using oracle please set the location of your temp schema
oracleTempSchema <- NULL

# the name of the table that will be created in cohortDatabaseSchema to hold the cohorts
cohortTable <- 'MddAfterBbValidationCohortTable'

# the location to save the prediction models results to:
# NOTE: if you set the outputFolder to the 'Validation' directory in the 
#       prediction study outputFolder then the external validation will be
#       saved in a format that can be used by the shiny app 
outputFolder <- '../Validation'

# add connection details:
options(fftempdir = 'T:/fftemp')
dbms <- "pdw"
user <- NULL
pw <- NULL
server <- Sys.getenv('server')
port <- Sys.getenv('port')
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = pw,
                                                                port = port)

# Now run the study:
MddAfterBbValidation::execute(connectionDetails = connectionDetails,
                 databaseName = databaseName,
                 cdmDatabaseSchema = cdmDatabaseSchema,
                 cohortDatabaseSchema = cohortDatabaseSchema,
                 oracleTempSchema = oracleTempSchema,
                 cohortTable = cohortTable,
                 outputFolder = outputFolder,
                 createCohorts = T,
                 runValidation = T,
                 packageResults = F,
                 minCellCount = 5,
                 sampleSize = NULL)
                 
# If the validation study runs to completion and returns results, package it up ready to share with the study owner (but remove counts less than 10) by running:
MddAfterBbValidation::execute(connectionDetails = connectionDetails,
                 databaseName = databaseName,
                 cdmDatabaseSchema = cdmDatabaseSchema,
                 cohortDatabaseSchema = cohortDatabaseSchema,
                 oracleTempSchema = oracleTempSchema,
                 cohortTable = cohortTable,
                 outputFolder = outputFolder,
                 createCohorts = F,
                 runValidation = F,
                 packageResults = T,
                 minCellCount = 10,
                 sampleSize = NULL)
                 
                 
# If your target cohort is large use the sampleSize setting to sample from the cohort:
MddAfterBbValidation::execute(connectionDetails = connectionDetails,
                 databaseName = databaseName,
                 cdmDatabaseSchema = cdmDatabaseSchema,
                 cohortDatabaseSchema = cohortDatabaseSchema,
                 oracleTempSchema = oracleTempSchema,
                 cohortTable = cohortTable,
                 outputFolder = outputFolder,
                 createCohorts = T,
                 runValidation = T,
                 packageResults = F,
                 minCellCount = 10,
                 sampleSize = 1000000)
                 
```

License
=======
  MddAfterBbValidation is licensed under Apache License 2.0

Development
===========
  MddAfterBbValidation is being developed in R Studio.
