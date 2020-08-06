# https://trr266.wiwi.hu-berlin.de/shiny/sposm_survey/
# https://github.com/joachim-gassen/sposm/tree/master/code/intro_survey

library(shiny)
library(shinythemes)

fluidPage(theme = shinytheme("superhero"),
          title = "dafuq",
          div(class = "jumbotron",
              h1("Hacking for Social Sciences"),
              p("Introductory Survey. This course is about you. It is important to know your starting point as well as your individual pain points and needs in programming with data. Please use this opportunity to help shape this course!")),
          fluidRow(
            column(width = 5,
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
                           ),

                   ),
                   div(class = "panel panel-primary",
                       div(class = "panel-heading",
                           h3("Programming Languages")),
                       div(class = "panel-body",
                           "Please indicate your familiarity with the following languages. 1 = never heard about it, 2 = seen it but never got beyond playing around, 3 = capable of doing a project in this lang, 4 = several years of experience, 5 = extention developer and beyond.",
                           sliderInput("r","R",min = 1, max = 5, value = 3),
                           sliderInput("python","Python",min = 1, max = 5, value = 3),
                           sliderInput("julia","Julia",min = 1, max = 5, value = 3),
                           sliderInput("go","Go",min = 1, max = 5, value = 3),
                           sliderInput("cpp","C++",min = 1, max = 5, value = 3),
                           sliderInput("js","Javascript",min = 1, max = 5, value = 3),
                           ),

                   ),
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

                   ),
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
                       ),

                   ),
                   div(class = "panel panel-primary",
                       div(class = "panel-heading",
                           h3("Expectations")),
                       div(class = "panel-body",
                           "What do you expect from this course?",
                           textInput("expect","")
                       )
                       )
          ))




)
