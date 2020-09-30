# https://db.rstudio.com/best-practices/run-queries-safely/
#
library(RPostgres)
con <-  dbConnect(drv = Postgres(), dbname = "postgres", user = "postgres",
                  host = "34.65.173.162", password = "pglogc@@AA13!$" )
dbExecute(con,
          "CREATE TABLE h4sci.feedback_1(
           id text PRIMARY KEY,
           basic integer,
           detached text,
           thoughts text,
           team integer
          );"
          )


dbGetQuery(con,"SELECT * FROM feedback_1")

# dbExecute(con,"SET SEARCH_PATH=h4sci")
# dbExecute(con,"DROP TABLE feedback_1")

dbDisconnect(con)




