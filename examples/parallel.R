library(kofdata)
library(seasonal)
library(tstools)

tsl <- get_time_series(c("ch.kof.barometer",
                         "ch.kof.indicator_surprise"))
tsl$ch.kof.indicator_surprise <- tstools::m_to_q(tsl$ch.kof.indicator_surprise)

tstools::tsplot(m_baro$series$s12)
tstools::tsplot(m_sur$series$s12)

microbenchmark::microbenchmark({
  m_baro <- seas(tsl$ch.kof.barometer)
  m_sur <- seas(tsl$ch.kof.indicator_surprise)

},times = 10


)

library(parallel)

nr_cores <- detectCores()
cat("mem_used in sa_parallel, before parLapply:", capture.output(print(pryr::mem_used())), "\n")
cluster <- parallel::makeCluster(nr_cores, type = if (Sys.info()["sysname"] == "Windows") "PSOCK" else "PSOCK")
parallel::clusterExport(cluster,
                        varlist = "tsl",
                        envir = environment())
worker_mems <- parallel::clusterEvalQ(cluster, capture.output(pryr::mem_used()))
cat(paste0("Initial mem_used worker thread ", seq_along(worker_mems), ": ", unlist(worker_mems), "\n"), sep = "")
sa_res <- parallel::parLapply(cluster, tsl, seas)
parallel::stopCluster(cluster)


microbenchmark::microbenchmark({
  sa_res <- parallel::parLapply(cluster, tsl, seas)

},times = 10
)



many <- list()
for(i in 1:20){
  many[[i]] <- tsl$ch.kof.indicator_surprise
}

microbenchmark::microbenchmark({
  lapply(many, seas)
},times = 1)


microbenchmark::microbenchmark({
  sa_res <- parallel::parLapply(cluster, many, seas)

},times = 1
)











