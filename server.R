library(shiny)
library(quantmod)


 shinyServer(function(input, output) {  
   dataInput <- reactive({
     validate(
       need(input$stock != "", "Please enter a valid stock name")
     )
     getSymbols(input$stock, src = "yahoo", auto.assign = FALSE)
   })
   
   output$title <- renderText({ 
     paste(paste("Data For Last", as.character(input$time_num), as.character(input$time_unit)), "s", sep="")
   })
   
   output$null <- renderPlot({
     chartSeries(dataInput(), theme = chartTheme("white"), name = input$stock1,
                 type = input$chart_type, subset = paste("last", input$time_num, input$time_unit), 
                 log.scale = FALSE, TA = NULL)
   })
   
   output$macd <- renderPlot({
     chartSeries(dataInput(), theme = chartTheme("white"), name = input$stock1,
                 type = input$chart_type, subset = paste("last", input$time_num, input$time_unit), 
                 log.scale = FALSE, TA = "addMACD()")
   })
   
   output$bbands <- renderPlot({
     chartSeries(dataInput(), theme = chartTheme("white"), name = input$stock1,
                 type = input$chart_type, subset = paste("last", input$time_num, input$time_unit), 
                 log.scale = FALSE, TA = "addBBands()")
   })
   
   output$macd_bbands <- renderPlot({
     chartSeries(dataInput(), theme = chartTheme("white"), name = input$stock1,
                 type = input$chart_type, subset = paste("last", input$time_num, input$time_unit), 
                 log.scale = FALSE, TA = c(addMACD(), "addBBands()"))
   })
   
 })