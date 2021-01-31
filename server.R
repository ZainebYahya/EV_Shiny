server <- shinyServer(function(input, output, session) {
  reactable(
    df,
    defaultPageSize = 5,
    bordered = TRUE,
    defaultColDef = colDef(
      footer = function(values) {
        if (!is.numeric(values))
          return()
        sparkline(values,
                  type = "box",
                  width = 100,
                  height = 30)
      }
    )
  )
  

  output$boxplot1 <- renderPlot({
    ggplot(df, aes(x = no_passengers, y = battery_charg)) +
      geom_boxplot(fill = semantic_palette[["green"]]) +
      xlab("No of passenger") + ylab("Battery Charging Status")
  })
  
  output$dotplot1 <- renderPlotly({
    ggplotly(
      ggplot(df, aes(x = trip_distance, y = battery_charg))
      + geom_point(aes(
        colour = factor(accessories), size = no_passengers
      ))
      + geom_smooth(method = "lm") +
        coord_cartesian(ylim = c(-12, 12))
      
    )
  })
  output$searchtable <- renderDataTable(df)
  output$evtable <- renderReactable(df)
})
