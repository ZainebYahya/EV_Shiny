library(shiny)
library(semantic.dashboard)
library(ggplot2)
library(plotly)
library(DT)

ui <- dashboardPage(
  dashboardHeader(
    color = "blue",
    title = "Electric Vehicles",
    inverted = TRUE
  ),
  dashboardSidebar(
    size = "thin",
    color = "teal",
    sidebarMenu(
      menuItem(tabName = "main", "Main", icon = icon("car")),
      menuItem(tabName = "ev", "Compare", icon = icon("table")),
      menuItem(tabName = "corr", "Correlation", icon = icon("table")),
      menuItem(tabName = "extra", "EV_Dataset", icon = icon(icon("user-chart")))
    )
  ),
  dashboardBody(tabItems(
    selected = 1,
    tabItem(tabName = "main",
            fluidRow(
              p(
                "Impact of charging occurrence on battery charge transformation Smart charging may affect the decomposition of charging patterns
up into multiple units, the cars and charging stations considered could not interrupt and restart charging sequences.
"
              ),

box(
  width = 16,
  title = "Graph ",
  color = "blue",
  ribbon = TRUE,
  title_side = "top right",
  column(width = 16,
         plotlyOutput("dotplot1"))
)
            )),
tabItem(tabName = "corr",
        fluidRow(
          h4("Relationship Between the Variables"),
          p(
            "We used Correlation to measure degree
of association between two numerical variables, and here by using a
correlation matrix is used to measure multicollinearity between all
the quantitative variables that ew want to test in the chart below .
"
          ),

plotOutput("corplotall"),
p(
  "our main goal is to study the how improving the charging efficiency
  The value of 0.01 shows that there is a weak but positive relationship between the two variable. Let's validate this with the correlation test. "
)
        )),
tabItem(tabName = "extra",
        fluidRow(dataTableOutput("searchtable"))),
tabItem(tabName = "ev",
        fluidRow(
          box(
            width = 16,
            title = "Graph ",
            color = "blue",
            ribbon = TRUE,
            title_side = "top right",
            column(width = 16,
                   plotOutput("dotplot1"))
          )
        ))
  )),
theme = "cerulean"
)
