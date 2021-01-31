library(shiny)

fluidPage(
  titlePanel("Electric Veh"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "car_load",
                     label = "Accessories",
                     choices = car_load)
      
    ),
    mainPanel(
      fluidRow(
        column(6, plotOutput("full")),
        column(6, plotOutput("end"))
      )
    )
  )
)
