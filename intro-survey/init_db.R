# https://db.rstudio.com/best-practices/run-queries-safely/
#
library(RPostgres)
con <-  dbConnect(drv = Postgres(), dbname = "postgres", user = "postgres",
                  host = "34.65.173.162", password = "pglogc@@AA13!$" )
dbExecute(con,
          "CREATE TABLE h4sci.responses(
           id text PRIMARY KEY,
           general text,
           l_r integer,
           l_python integer,
           l_julia integer,
           l_matlab integer,
           l_sql integer,
           l_cpp integer,
           l_js integer,
           l_web integer,
           w_git integer,
           w_markdown integer,
           w_scrum integer,
           w_kanban integer,
           i_docker integer,
           i_kubernetes integer,
           i_azure integer,
           i_gpc integer,
           i_aws integer,
           i_eth integer,
           expect text,
           cgroup text
          );"
          )


dbGetQuery(con,"SELECT * FROM responses")

# dbExecute(con,"SET SEARCH_PATH=h4sci")
# dbExecute(con,"DROP TABLE responses")

dbDisconnect(con)

# might need those for checking results / behavior
# dbExecute(con, "DROP TABLE responses")
# dbListTables(con)
#
#
# dbGetQuery(con, "SELECT * FROM responses")





