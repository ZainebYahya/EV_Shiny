library(shiny)
library(semantic.dashboard)
library(ggplot2)
library(plotly)
library(DT)

ui <- dashboardPage(
  dashboardHeader(color = "blue",title = "Electric Vehicles", inverted = TRUE),
  dashboardSidebar(
    size = "thin", color = "teal",
    sidebarMenu(
      menuItem(tabName = "main", "Main", icon = icon("car")),
      menuItem(tabName = "extra", "Extra", icon = icon("table")),
      menuItem(tabName = "ev", "EV", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      selected = 1,
      tabItem(
        tabName = "main",
        fluidRow(
          box(width = 8,
              title = "Graph 1",
              color = "blue", ribbon = TRUE, title_side = "top right",
              column(width = 8,
                     plotOutput("boxplot1")
              )
          ),
          box(width = 8,
              title = "Graph 2",
              color = "blue", ribbon = TRUE, title_side = "top right",
              column(width = 8,
                     plotlyOutput("dotplot1")
              )
          )
        )
      ),
      tabItem(
        tabName = "extra",
        fluidRow(
          dataTableOutput("searchtable")
        )
      ),
      tabItem(
        tabName = "ev",
        fluidRow(
          reactableOutput("evtable",width = "auto", height = "auto", inline = FALSE)
        )
      )
    )
  ), theme = "cerulean"
)
