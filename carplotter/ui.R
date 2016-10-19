#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
        # Application title
        titlePanel("Fuel consumption of cars"),
        
        # Sidebar with a slider input for number of bins 
        sidebarLayout(
                sidebarPanel(
                        checkboxGroupInput("feats",
                                           "features to consider",
                                           choices = names(mtcars)[-c(1, 6)])
                        ),
                # Show a plot of the generated distribution
                mainPanel(fluidRow(
                        plotOutput("plotLm"),
                        textOutput("distance"),
                        plotOutput("plotPoints")
                        ))
                )
        ))
