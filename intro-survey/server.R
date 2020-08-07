library(shiny)
library(shinyjs)

shinyServer(function(input, output, session){


  # it should be sufficient to store the session token.
  # cookies auth is a more sophisticated alternative, but
  # let's not dive into js to deep for now.
  # session$token

  store_record <- function(response, db_path = "data/h4sci.sqlite3"){
    con <- dbConnect(RSQLite::SQLite(), db_path)
    dbAppendTable(con, dbQuoteIdentifier(con,"responses"), response)
  }

  submitted <- reactiveVal(FALSE)

  response <- reactive({
    dt <- data.frame(
      id = session$token,
      general = paste(input$general,collapse=","),
      r = input$r,
      python = input$python,
      matlab = input$matlab,
      sql = input$sql,
      cpp = input$cpp,
      js = input$js
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


  output$general <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("General")),
                   div(class = "panel-body",
                       "Please select all terms that you feel familiar with, i.e.,
              you're able to explain a rough idea of it to others",
                       checkboxGroupInput("general","Technology",
                                          c("R","Python","Matlab",
                                            "Julia","Javascript","C++",
                                            "STATA","SQL","docker",
                                            "Kubernetes","Cloud Computing")
                       )
                   )
               )
        )
      )
    }
  )

  output$lang <- renderUI(
    if(!submitted()){

      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Programming Languages")),
                   div(class = "panel-body",
                       "Please indicate your familiarity with the following languages. 1 = never heard about it, 2 = seen it but never got beyond playing around, 3 = capable of doing a project in this lang, 4 = several years of experience, 5 = extension developer and beyond.",
                       sliderInput("r","R",min = 1, max = 5, value = 3),
                       sliderInput("python","Python",min = 1, max = 5, value = 3),
                       sliderInput("julia","Julia",min = 1, max = 5, value = 3),
                       sliderInput("matlab","Matlab",min = 1, max = 5, value = 3),
                       sliderInput("sql","SQL",min = 1, max = 5, value = 3),
                       sliderInput("cpp","Cpp",min = 1, max = 5, value = 3),
                       sliderInput("js","Javascript",min = 1, max = 5, value = 3),
                   )

               )

        )
      )
    }

  )

  output$workflow <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Developer Workflow")),
                   div(class = "panel-body",
                       "Software development is a team sport. The field has developed industry standard workflows that allow developers who never met to efficiently create software together. Please indicate your familiarity with the following tools and techniques. 1 = never heard of it, 2 = trying out status, 3 = working with it in real life projects,
              4 = several years of experience, 5 = leading groups to use it.",
                       sliderInput("git","Git Version Control",min = 1, max = 5, value = 3),
                       sliderInput("scrum","SCRUM",min = 1, max = 5, value = 3),
                       sliderInput("kanban","KANBAN",min = 1, max = 5, value = 3)
                   ),

               )
        )
      )
    }
  )

  output$infrastructure <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Infrastructure")),
                   div(class = "panel-body",
                       "The ability to run computations in the cloud or re-surrect an ugly
              research setup from the old they days in an isolated environment can be
              very valuable. Please indicate your familiarity with the following infrastructure. 1 = never heard of it, 2 = trying out status, 3 = working with it in real life projects, 4 = several years of experience, 5 = expert",
                       sliderInput("docker","Docker", min = 1, max = 5, value = 3),
                       sliderInput("k8","Kubernetes", min = 1, max = 5, value = 3),
                       sliderInput("azure","Azure", min = 1, max = 5, value = 3),
                       sliderInput("gpc","Google Cloud Computing", min = 1, max = 5, value = 3),
                       sliderInput("aws","AWS (Amazon)", min = 1, max = 5, value = 3),
                       sliderInput("eth","ETH Cloud", min = 1, max = 5, value = 3),
                   )
               )))
    }
  )

  output$expect <- renderUI(
    if(!submitted()){
      fluidRow(
        column(width = 6,
               div(class = "panel panel-primary",
                   div(class = "panel-heading",
                       h3("Expectations")),
                   div(class = "panel-body",
                       "What do you expect from this course?",
                       textAreaInput("expect","", width = "100%",  cols = 120, rows = 15)
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








