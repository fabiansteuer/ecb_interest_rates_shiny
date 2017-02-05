# ui.R

shinyUI(fluidPage(
  titlePanel("ECB Key Interest Rates"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Plot the European Central Bank's key interest rates. Just select the interest rates and the date range you are interested in and click on the plot button."), 
      
      checkboxGroupInput("variables", 
                         label = "Interest rates",
                         choices = c("Marginal lending facility",
                                     "Main refinancing operations",
                                     "Deposit facility"),
                         selected = c("Marginal lending facility",
                                      "Main refinancing operations",
                                      "Deposit facility")),
      
      dateRangeInput("dates", 
                     label = "Date range",
                     start = as.Date("1999-01-01"),
                     end = Sys.Date()),
      
      actionButton("plot", "Plot")
      
      ),
    
    mainPanel(plotOutput("plot"))
  )
))