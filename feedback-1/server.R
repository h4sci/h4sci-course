library(shiny)
library(shinyjs)
library(DBI)
library(RPostgres)

shinyServer(function(input, output, session){


  # it should be sufficient to store the session token.
  # cookies auth is a more sophisticated alternative, but
  # let's not dive into js to deep for now.
  # session$token

  store_record <- function(response){
    fcon <- file(".pgpass","r")
    con <-  dbConnect(drv = Postgres(), dbname = "postgres", user = "postgres",
                      host = "34.65.173.162",
                      password = readLines(fcon, warn = FALSE))
    dbExecute(con,"SET SEARCH_PATH=h4sci")
    dbAppendTable(con, dbQuoteIdentifier(con,"feedback_1"), response)
    dbDisconnect(con)
  }

  submitted <- reactiveVal(FALSE)


  response <- reactive({
    dt <- data.frame(
      id = session$token,
      basic = input$basic,
      detached = input$detached,
      thoughts = input$thoughts,
      team = input$team,
      stringsAsFactors = FALSE
    )
  })

  observeEvent(input$submit, {
    store_record(response())
    submitted(TRUE)
    # has_participated(TRUE)
    # js$setcookie("HAS_PARTICIPATED_IN_SPOSM_INTRO_SURVEY")
  })

  output$test <- renderText({
    as.character(submitted())
  })


  output$basic <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("General")),
                   div(class = "panel-body",
                       "Please let me know how you, personally, assess the first basic git task.",
                       radioButtons("basic",label = NULL,
                                    choices =
                                      list("Never used git before, not too easy." = 1,
                                           "Not much prev. experience, nevertheless it was easy" = 2,
                                           "I knew git before, but mostly with a GUI. Easy though" = 3,
                                           "Peace of cake." = 4)
                       )
                   )
               )
        )
      )
    }
  )




  output$detached <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Expectations")),
                   div(class = "panel-body",
                       "Describe the 'detached head situation'. When does occur? Evaluate it. Why can't one simply go back to some previous commit? ",
                       textAreaInput("detached","", width = "100%",  cols = 120, rows = 15),
                   )
               ))
      )
    }
  )


  output$thoughts <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Personal Git Experience")),
                   div(class = "panel-body",
                       "What are your thoughts on git?",
                       textAreaInput("thoughts","", width = "100%",  cols = 120, rows = 15),
                   )
               ))
      )
    }
  )


  output$team <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Personal Git Experience")),
                   div(class = "panel-body",
                       "How do you assess your team's git confidence. 1 = One person who is somewhat confident.
                       2 = more than one person is comfortable. 3 = most people on our team are confident,
                       4 = we are some git rockstars.",
                       sliderInput("team",NULL,1,4,value = 2)
                   )
               ))
      )
    }
  )


  output$submit <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Submit Your Answers!")),
                   div(class = "panel-body", align = "right",
                       actionButton('submit',"submit")
                   )
               )
        )
      )
    }
  )

  output$thanks <- renderUI(
    if(submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-info",
                   div(class = "panel-heading",
                       h3("Thank You")),
                   div(class = "panel-body", align = "right",
                       "Thank you for your participation. Please take only part once."
                   )
               ))
      )
    }
  )






})








