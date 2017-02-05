# server.R

library("Quandl")
library("ggplot2")

# Load datasets from Quandl
MRO = Quandl("ECB/FM_B_U2_EUR_4F_KR_MRR_FR_LEV", api_key="z7GG-scyoWzrj5a1xWsa")
MRO$Date = as.Date(MRO$Date)
MLF = Quandl("ECB/FM_B_U2_EUR_4F_KR_MLFR_LEV", api_key="z7GG-scyoWzrj5a1xWsa")
MLF$Date = as.Date(MLF$Date)
DFR = Quandl("ECB/FM_B_U2_EUR_4F_KR_DFR_LEV", api_key="z7GG-scyoWzrj5a1xWsa")
DFR$Date = as.Date(DFR$Date)

shinyServer(
  function(input, output) {
    
    observeEvent(input$plot, {
      output$plot <- renderPlot({
     
      start = as.Date(input$dates[1])
      end = as.Date(input$dates[2])
      
      p = ggplot(NULL)
      
      if ("Marginal lending facility" %in% input$variables) {
        p = p + geom_step(data=MLF[MLF$Date > start & MLF$Date < end, ], aes(x=Date, y=`Percent per annum`, color="Marginal lending facility"))
      }
      if ("Main refinancing operations" %in% input$variables) {
        p = p + geom_step(data=MRO[MRO$Date > start & MRO$Date < end, ], aes(x=Date, y=`Percent per annum`, color="Main refinancing operations"))
      }
      if ("Deposit facility" %in% input$variables) {
        p = p + geom_step(data=DFR[DFR$Date > start & DFR$Date < end, ], aes(x=Date, y=`Percent per annum`, color="Deposit facility")) 
      }
      
      p = p + scale_colour_manual(values=c("red", "blue", "green"), name="Interest rate", guide=guide_legend(reverse = TRUE))
      
      p
      
    })
    })
    
  }
)