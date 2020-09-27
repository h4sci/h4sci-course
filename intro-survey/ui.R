# Inspired by https://trr266.wiwi.hu-berlin.de/shiny/sposm_survey/
# https://github.com/joachim-gassen/sposm/tree/master/code/intro_survey

library(shiny)
library(shinythemes)

fluidPage(theme = shinytheme("superhero"),
          title = "Hacking for Social Sciences - Introductory Survey",
          fluidRow(
            column(width = 6,
                   div(class = "jumbotron",
                       h1("Hacking for Social Sciences"),
                       p("Introductory Survey. This course is about you. It is important to know your starting point as well as your individual pain points and needs in programming with data. Please use this opportunity to help shape this course!"))
            )
          ),
          uiOutput("general"),
          uiOutput("lang"),
          uiOutput("workflow"),
          uiOutput("infrastructure"),
          uiOutput("expect"),
          uiOutput("submit"),
          uiOutput("thanks")
          )

