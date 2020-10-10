library(MddAfterBbValidation)

# add details of your database setting:
databaseName <- 'CDMPv531'

# add the cdm database schema with the data
cdmDatabaseSchema <- 'CDMPv531.dbo'

# add the work database schema this requires read/write privileges
cohortDatabaseSchema <- 'cohortDb.dbo'

# if using oracle please set the location of your temp schema
oracleTempSchema <- NULL

# the name of the table that will be created in cohortDatabaseSchema to hold the cohorts
cohortTable <- 'SHJin_MddAfterBbValidation'

# the location to save the prediction models results to:
outputFolder <- '/home/jshsh7553/output/MddAfterBb/Validation'

# add connection details:
options(fftempdir = '/home/jshsh7553/temp')
dbms <- "sql server"
user <- 'jshsh7553'
pw <- 'wlstn!4852gh'
server <- '128.1.99.58'
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = pw)

# Now run the study
MddAfterBbValidation::execute(connectionDetails = connectionDetails,
                              databaseName = databaseName,
                              cdmDatabaseSchema = cdmDatabaseSchema,
                              cohortDatabaseSchema = cohortDatabaseSchema,
                              oracleTempSchema = oracleTempSchema,
                              cohortTable = cohortTable,
                              outputFolder = outputFolder,
                              createCohorts = F,
                              runValidation = T,
                              packageResults = F,
                              minCellCount = 5,
                              sampleSize = NULL)
# the results will be saved to outputFolder.  If you set this to the
# predictionStudyResults/Validation package then the validation results
# will be accessible to the shiny viewer

# to package the results run (run after the validation results are complete):
# NOTE: the minCellCount = N will remove any result with N patients or less
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
                              minCellCount = 5,
                              sampleSize = NULL)
