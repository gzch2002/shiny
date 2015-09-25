library(shiny)

shinyUI(navbarPage("StokIt",
                   tabPanel("Main",
                            titlePanel("Stock Analysis Tools"),
                                sidebarLayout(
                                    sidebarPanel(
                                      wellPanel(
                                        p(strong("Stocks")),
                                        textInput("stock", "Stock", "SPY"),
                                        selectInput(inputId = "chart_type",label = "Chart Type", choices = c("Candle Sticks" = "candlesticks", 
                                                                                                             "Match Sticks" = "matchsticks",
                                                                                                             "Barchart" = "bars",
                                                                                                             "Line Chart" = "line")),    
                                        
                                        checkboxInput("macd", "MACD"),
                                        checkboxInput("bbands", label = "BBands")
                                      ),
                                      
                                      wellPanel(
                                        p(strong("Date For Last")),
                                        sliderInput(inputId = "time_num", label = "Number of Time Units", min = 1, max = 24, step = 1, value = 6),       
                                        selectInput(inputId = "time_unit",label = "Time Unit", choices = c("Day" = "day", "Week" = "week",
                                                                                                           "Month" = "month", "Year" = "year"), selected = "month")
                                      )
                                    ),    #End sidebar panel
                                    mainPanel(
                                      h5("Enter ONE stock name, and choose a chart type. The chart will display last few days, weeks, months or 
                                   years of data based on your choice."),
                                      textOutput("title"), 
                                      conditionalPanel(
                                        condition = "input.macd == false && input.bbands == false", 
                                        plotOutput("null")
                                      ),
                                      conditionalPanel(
                                        condition = "input.macd == true && input.bbands == false",
                                        plotOutput("macd"),
                                        h5("Moving Average Convergence Divergence (or MACD) is a trend-following momentum indicator that shows the relationship between two moving averages of prices. 
                                           The MACD is calculated by subtracting the 26-day exponential moving average (EMA) from the 12-day EMA.")
                                        ),
                                      
                                      conditionalPanel(
                                        condition = "input.macd == false && input.bbands == true",
                                        plotOutput("bbands"),
                                        h5("Bollinger Band is a band plotted two standard deviations away from a simple moving average.When 
                                           the markets become more volatile, the bands widen, and during less volatile periods, the bands contract. The 
                                           tightening of the bands is often used by technical traders as an early indication that the volatility
                                           is about to increase sharply.")
                                        ),
                                      
                                      conditionalPanel(
                                        condition = "input.macd == true && input.bbands == true",
                                        plotOutput("macd_bbands")
                                      )
                                    )   #End main panel

                                )  #End sidebar layout
                            
                   ),  #End navbar for Main
                   tabPanel("About",
                            h2("What is StokIt?"),
                            p("StokIt is a stock learning and trading tool that provides more interaction that commercial ones."),
                            h2("How was it implemented?"),
                            p("StokIt was implemented with Shiny and used the R quantcom packege for stocks."),
                            h2("What is not implemented yet?"),
                            p("Forcast and prediction is not yet implemented.")
                            
                   )
))

