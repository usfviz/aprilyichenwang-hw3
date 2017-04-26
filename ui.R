
# Use a fluid Bootstrap layout
fluidPage(    
  
  # Give the page a title
  titlePanel("April's Diabetic Patients Data Analysis"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("age", "Age:", 
                  choices= c('[0-10)' ,  '[10-20)',  '[20-30)',  '[30-40)',  '[40-50)',  '[50-60)',  
                             '[60-70)' , '[70-80)',  '[80-90)',  '[90-100)'), selected = '[50-60)'),
      hr(),
      helpText("Parallel Coordinates Plot  & Scatterplot Matrix: Select Age Group"),
  
    
    radioButtons("group", "HeatMap- Group By :",
                 c("Age" = "age",
                   "Race" = "race",
                   "Admission Type" = "admission_type_id"))
    ),
    
    
    # Create a spot for the barplot
    mainPanel(
      tabsetPanel(
        tabPanel("Plot",
                 plotOutput("PCPlot"),
                 plotOutput("SMPlot")
        ),
        
        tabPanel("Heatmap", plotOutput('Heatmap',height = "580px"))
      )     
          )
  ))