fluidPage(
  
  # Application title
  titlePanel("Heart Disease Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("Gender", 
                  "Gender:", 
                  choices = list("Male" = "Man", 
                                 "Female" = "Woman"
                  )
      ),
      sliderInput("Age",
                  "Age:",
                  min = min(as.numeric(heart_disease$Age)),
                  max = max(as.numeric(heart_disease$Age)),
                  value = mean(as.numeric(heart_disease$Age))
      ),
      sliderInput("Height_CM",
                  "Height (cm):",
                  min = min(as.numeric(heart_disease$Height_CM)),
                  max = max(as.numeric(heart_disease$Height_CM)),
                  value = mean(as.numeric(heart_disease$Height_CM))
      ),
      sliderInput("Weight_KG",
                  "Weight (kg):",
                  min = min(as.numeric(heart_disease$Weight_KG)),
                  max = max(as.numeric(heart_disease$Weight_KG)),
                  value = mean(as.numeric(heart_disease$Weight_KG))
      ),
      sliderInput("Systolic_Blood_Pressure",
                  "Systolic Blood Pressure:",
                  min = boxplot(as.numeric(heart_disease$Systolic_Blood_Pressure), plot = FALSE)$stats[1] - 50,
                  max = boxplot(as.numeric(heart_disease$Systolic_Blood_Pressure), plot = FALSE)$stats[5] + 50,
                  value = mean(as.numeric(heart_disease$Systolic_Blood_Pressure))
      ),
      sliderInput("Diastolic_Blood_Pressure",
                  "Diastolic Blood Pressure:",
                  min = boxplot(as.numeric(heart_disease$Diastolic_Blood_Pressure), plot = FALSE)$stats[1] - 50,
                  max = boxplot(as.numeric(heart_disease$Diastolic_Blood_Pressure), plot = FALSE)$stats[5] + 50,
                  value = mean(as.numeric(heart_disease$Diastolic_Blood_Pressure))
      ),
      sliderInput("Cholesterol_Level",
                  "Cholesterol Level:",
                  min = min(as.numeric(heart_disease$Cholesterol_Level)),
                  max = max(as.numeric(heart_disease$Cholesterol_Level)),
                  value = mean(as.numeric(heart_disease$Cholesterol_Level))
      ),
      sliderInput("Glucose_Level",
                  "Glucose Level:",
                  min = min(as.numeric(heart_disease$Glucose_Level)),
                  max = max(as.numeric(heart_disease$Glucose_Level)),
                  value = mean(as.numeric(heart_disease$Glucose_Level))
      ),
      selectInput("Smoker", 
                  "Smoker:", 
                  choices = list("Yes" = "Yes", 
                                 "No" = "No"
                  )
      ),
      selectInput("Alcoholic", 
                  "Alcoholic:", 
                  choices = list("Yes" = "Yes", 
                                 "No" = "No"
                  )
      ),
      selectInput("Physically_Active", 
                  "Physically Active:", 
                  choices = list("Yes" = "Yes", 
                                 "No" = "No"
                  )
      # ),
      # sliderInput("bins",
      #             "Number of bins:",
      #             min = 1,
      #             max = 50,
      #             value = 30
      )
    ),
    
    # # Show a plot of the generated distribution
    # mainPanel(
    #   plotOutput("distPlot")
    # ),
    mainPanel(
      tableOutput("view")
    )
  )
)