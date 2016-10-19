#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        output$plotPoints <- renderPlot({
                # draw the dataset
                library(ggplot2)
                ggplot(mtcars, aes(x=wt, y=mpg)) +
                        geom_point() +
                        ggtitle("mtcars dataset") +
                        labs(x="weight of the car", y="miles per gallon")
                })
        output$plotLm <- renderPlot({
                # fit a linear regression model
                featsLm <- rep(FALSE, 11)
                for(feat in input$feats) featsLm <- featsLm + grepl(feat, names(mtcars))
                featsLm <- which(featsLm==1)
                if(is.null(input$feats)) {
                        form <- mpg ~ wt
                        } else {
                        form <- as.formula(paste("mpg ~ wt+", paste(names(mtcars)[featsLm], collapse= "+")))
                        }
                
                fit <- lm(form, mtcars)
                
                # plot residuals
                titlePlot <- paste("using wt", paste(names(mtcars)[featsLm], collapse = " & "), collapse = " ")
                plot(mtcars$wt, resid(fit), ylim=c(-7, 7), main = titlePlot)
                abline(h=0)
                })
        
        output$distance <- renderText({
                # fit a linear regression model
                featsLm <- rep(FALSE, 11)
                for(feat in input$feats) featsLm <- featsLm + grepl(feat, names(mtcars))
                featsLm <- which(featsLm==1)
                if(is.null(input$feats)) {
                        form <- mpg ~ wt
                } else {
                        form <- as.formula(paste("mpg ~ wt+", paste(names(mtcars)[featsLm], collapse= "+")))
                }
                
                fit <- lm(form, mtcars)
                a <- signif(1 - summary(fit)$r.squared, 3)
                paste("Residual variance", a, collapse = " ")
                
        })
        
  
})
