server <- shinyServer(function(input, output, session) {
  reactable(df,
            defaultPageSize = 5,
            bordered = TRUE,
            defaultColDef = colDef(footer = function(values) {
              if (!is.numeric(values)) return()
              sparkline(values, type = "box", width = 100, height = 30)
            })
  )
  
  

  output$boxplot1 <- renderPlot({
    ggplot(df, aes(x = no_passengers, y = battery_charg)) +
      geom_boxplot(fill = semantic_palette[["green"]]) +
      xlab("No of passenger") + ylab("Battery Charging Status")
  })
  
  
  output$corplotall <- renderPlot({
    ggcorrplot(
      corr,
      hc.order = TRUE,
      type = "lower",
      lab = TRUE,
      lab_size = 3,
      method = "circle",
      colors = c("blue", "white", "red"),
      outline.color = "gray",
      show.legend = TRUE,
      show.diag = FALSE,
      title="Correlogram of Efficiency variables"
    )
    
  })
  
  output$dotplot2 <- renderPlot({
    p <- df %>% 
      filter(fullcharge_efficiency>=0 & fullcharge_efficiency <=750) %>%
      ggplot( aes(x=fullcharge_efficiency, y=charging_occurrences, group=1)) +
      geom_point(color="#69b3a2", size=2, alpha=0.01) +
      theme(
        legend.position="none"
      )
    
    
    
    # add marginal histograms
    ggExtra::ggMarginal(p, type = "histogram")
 
    
  })
  

  
  # Compute kde2d
  kd <- with(data, MASS::kde2d(x, y, n = 50))
  
  # Plot with plotly
  plot_ly(x = kd$x, y = kd$y, z = kd$z) %>% add_surface()
  
  
  output$dotplot1 <- renderPlotly({
    plot_ly(x=colnames(df_map), y=rownames(df_map), z = df_map, type = "heatmap") %>%
      layout(margin = list(l=120))
  })
  
  output$dotplot <- renderPlotly({
    ggplotly(
      ggplot(df, aes(x = trip_distance, y = battery_charg))
      + geom_point(aes(
        colour = factor(no_passengers)
      ))
      + geom_smooth(method = "lm") +
        coord_cartesian(ylim = c(-12, 12))
      
    )
  })
  output$searchtable <- renderDataTable(df)
  output$evtable <- renderReactable({reactable(df)})
})



