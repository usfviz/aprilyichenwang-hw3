require(GGally)
require(ggplot2)



# Define a server for the Shiny app
function(input, output) {

  diabetics<-read.csv('diabetic_data.csv',na.strings=c("?"),nrows=5000)
  
  # Fill in the spot we created for a plot
  output$PCPlot <- renderPlot({
    
    # Render a Parallel Coordinates Plot
    
    diabetics_sub<-diabetics[,c('age','gender','insulin','race','number_diagnoses')]
    diabetics_sub<-diabetics_sub[complete.cases(diabetics_sub),]
    # filter for age
    diabetics_sub<-diabetics_sub[diabetics_sub$age==input$age,]
  
    # filter for age    

    ggparcoord(data = diabetics_sub, columns = c(1,3,4,5), 
               groupColumn = 'gender',missing = "random",
               title='Parallel Coordinates Plot for diabetic patients') }
    )

  output$SMPlot<-renderPlot({
    diabetics_SM_sub<-diabetics[diabetics$age==input$age,
                                    c('time_in_hospital','num_procedures',
                                      'num_lab_procedures','num_medications')]
    pairs(~.,data=diabetics_SM_sub,
         main="Simple Scatterplot Matrix")
  })
  
  ##################################

  output$Heatmap<-renderPlot({
    feature_selected<-input$group
    make_heatmap_plot(feature_selected)
  })
  }