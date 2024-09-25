
library(RPostgres)
library(DBI)
library(tidyr)
library(dplyr)
library(ggplot2)
library(data.table)
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)

preprocess <- function(df, pattern){
  pattern_id <- paste0("id|", pattern)
  subs <- df[ ,grepl(pattern_id, names(df))]
  names(subs) <- gsub(pattern,"",names(subs))
  dt <- as.data.table(subs)
  m <- melt(dt, id.vars = c("id"))
  m
}


con <- dbConnect(
  drv = Postgres(),
  dbname = "postgres",
  port = 1111,
  user = "postgres",
  password = "postgres",
  host = "localhost"
  )

res <- dbGetQuery(con, "SELECT * FROM rseed.h4sci_intro")
dbDisconnect(con)

words_ice <- gsub(" vs. |,,|\\(|\\)", "", paste(res$icebreaker, collapse = ","))
words_ice <- gsub("\\/", " ", words_ice)
words_ice <- unlist(strsplit(words_ice, ","))

ice_tok <- tokens(words_ice)
ice_comp <- tokens_compound(ice_tok, pattern = phrase(words_ice))

ice_comp |> 
  dfm() |> 
  textstat_frequency() |> 
  ggplot(aes(x = reorder(feature, frequency), y = frequency)) +
  geom_point() +
  coord_flip() +
  labs(x = NULL, y = "Frequency") +
  theme_minimal()


words_reporting <- gsub(" vs. |,,|\\(|\\)", "", paste(res$reporting, collapse = ","))
words_reporting <- gsub("\\/", " ", words_reporting)
words_reporting <- unlist(strsplit(words_reporting, ","))

reporting_tok <- tokens(words_reporting)
reporting_comp <- tokens_compound(reporting_tok, pattern = phrase(words_reporting))

ice_tok |> 
  dfm() |> 
  textplot_wordcloud(
    color = rev(viridis::viridis_pal()(6)),
    min_count = 1)

quanteda::textplot_wordcloud(dfm(words,remove = ","),
                             color = rev(viridis::viridis_pal()(6)),
                             min_count = 1)





lang <- preprocess(res, "l_")
gg_lang <- ggplot(data = lang)
gg_lang +
  geom_bar(aes(x = value, fill = variable)) +
  facet_wrap("variable", nrow = 2) +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.spacing = unit(4, "lines")) +
  scale_x_discrete(name ="Language",
                   limits=factor(1:5)) +
  scale_fill_viridis_d() +
  coord_flip()

infra <- preprocess(res, "i_")
gg_lang <- ggplot(data = infra)
gg_lang +
  geom_bar(aes(x = value, fill = variable)) +
  facet_wrap("variable", nrow = 2) +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.spacing = unit(4, "lines")) +
  scale_x_discrete(name ="Technology",
                   limits=factor(1:5)) +
  scale_fill_viridis_d() +
  coord_flip()


set.seed(123)
sample(substr(res$id,1,8),1)