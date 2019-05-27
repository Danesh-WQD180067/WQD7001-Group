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
                  ),
                  selected = Modes(heart_disease$Gender)
      ),
      sliderInput("Age",
                  "Age:",
                  min = getMin(heart_disease$Age),
                  max = getMax(heart_disease$Age),
                  value = mean(as.numeric(heart_disease$Age))
      ),
      sliderInput("Height_CM",
                  "Height (cm):",
                  min = getMin(heart_disease$Height_CM),
                  max = getMax(heart_disease$Height_CM),
                  value = mean(as.numeric(heart_disease$Height_CM))
      ),
      sliderInput("Weight_KG",
                  "Weight (kg):",
                  min = getMin(heart_disease$Weight_KG),
                  max = getMax(heart_disease$Weight_KG),
                  value = mean(as.numeric(heart_disease$Weight_KG))
      ),
      sliderInput("Systolic_Blood_Pressure",
                  "Systolic Blood Pressure:",
                  min = getMin(heart_disease$Systolic_Blood_Pressure),
                  max = getMax(heart_disease$Systolic_Blood_Pressure),
                  value = mean(as.numeric(heart_disease$Systolic_Blood_Pressure))
      ),
      sliderInput("Diastolic_Blood_Pressure",
                  "Diastolic Blood Pressure:",
                  min = getMin(heart_disease$Diastolic_Blood_Pressure),
                  max = getMax(heart_disease$Diastolic_Blood_Pressure),
                  value = mean(as.numeric(heart_disease$Diastolic_Blood_Pressure))
      ),
      sliderInput("Cholesterol_Level",
                  "Cholesterol Level:",
                  min = min(as.numeric(heart_disease$Cholesterol_Level)),
                  max = max(as.numeric(heart_disease$Cholesterol_Level)),
                  value = Modes(as.numeric(heart_disease$Cholesterol_Level))
      ),
      sliderInput("Glucose_Level",
                  "Glucose Level:",
                  min = min(as.numeric(heart_disease$Glucose_Level)),
                  max = max(as.numeric(heart_disease$Glucose_Level)),
                  value = Modes(as.numeric(heart_disease$Glucose_Level))
      ),
      selectInput("Smoker", 
                  "Smoker:", 
                  choices = list("Yes" = "Yes", 
                                 "No" = "No"
                  ),
                  selected = Modes(heart_disease$Smoker)
      ),
      selectInput("Alcoholic", 
                  "Alcoholic:", 
                  choices = list("Yes" = "Yes", 
                                 "No" = "No"
                  ),
                  selected = Modes(heart_disease$Alcoholic)
      ),
      selectInput("Physically_Active", 
                  "Physically Active:", 
                  choices = list("Yes" = "Yes", 
                                 "No" = "No"
                  ),
                  selected = Modes(heart_disease$Physically_Active)
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('Prediction',
                 plotOutput("piePlot"),
                 tableOutput("view")
        ),
        tabPanel('About',
                 p(),
                 p("This application would evaluate if an individual has cardiovascular disease based on several physiological attributes"),
                 p("The menu on the left let user to select their health attributes, gender, age, height, weight, blood pressure, 
                   chloslestrol level, glucose level, smoke, alcohol consumption and physical active status."),
                 p("1. User should select all the related attributes."),
                 p("2. Six different models will then predict if the user has cardiovascular disease."),
                 p("3. The prediction results can be viewed in the Prediction tab")
                 )
        
      )
    )
  )
)