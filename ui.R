heart_disease <- read.csv("data/clean_cardio_train.csv")

fluidPage(
  
  # Application title
  titlePanel("Heart Disease Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("gender", "Gender", 
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
      sliderInput("height",
                  "Height (cm):",
                  min = min(as.numeric(heart_disease$Height_CM)),
                  max = max(as.numeric(heart_disease$Height_CM)),
                  value = mean(as.numeric(heart_disease$Height_CM))
      ),
      sliderInput("weight",
                  "Weight (kg):",
                  min = min(as.numeric(heart_disease$Weight_KG)),
                  max = max(as.numeric(heart_disease$Weight_KG)),
                  value = mean(as.numeric(heart_disease$Weight_KG))
      ),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)