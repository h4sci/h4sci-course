# https://db.rstudio.com/best-practices/run-queries-safely/
#
library(DBI)
library(RSQLite)
DB_PATH <- "data/h4sci.sqlite3"
con <- dbConnect(RSQLite::SQLite(), DB_PATH)
dbExecute(con,
          "CREATE TABLE responses(
           id text PRIMARY KEY,
           general text,
           r integer,
           python integer,
           matlab integer,
           sql integer,
           cpp integer,
           js integer)"
          )


dbDisconnect(con)

# might need those for checking results / behavior
# dbExecute(con, "DROP TABLE responses")
# dbListTables(con)
#
#
# dbGetQuery(con, "SELECT * FROM responses")


