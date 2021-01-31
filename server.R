
function(input, output, session) {
  
  observe({
    loads <- 
      df %>%
      filter(ev$fullchargeflag == 1 ) 
    updateSelectizeInput(
      session, "car_load",
      choices = car_load,
      selected = car_load[1])
  })
  
  full_charge <- reactive({
    df %>%
      filter(df $fullchargeflag == 1)  %>%
      group_by(trip_distance,fullcharge_efficiency)
  })
  
  output$end <- renderPlot(
    full_charge() %>%
      ggplot(aes(x = trip_distance, y = fullcharge_efficiency, fill = accessories)) +
      geom_col(position = "dodge") +
      ggtitle("Full Charge")
  )
  
  
}