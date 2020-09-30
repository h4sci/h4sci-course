# Inspired by https://trr266.wiwi.hu-berlin.de/shiny/sposm_survey/
# https://github.com/joachim-gassen/sposm/tree/master/code/intro_survey

library(shiny)
library(shinythemes)

fluidPage(theme = shinytheme("superhero"),
          title = "Hacking for Social Sciences - Git Basics",
          fluidRow(
            column(width = 6,
                   div(class = "jumbotron",
                       h1("Feedback"),
                       p("Let's see were we are at after the first stop."))
            )
          ),
          uiOutput("basic"),
          uiOutput("detached"),
          uiOutput("thoughts"),
          uiOutput("team"),
          uiOutput("submit"),
          uiOutput("thanks")
          )

