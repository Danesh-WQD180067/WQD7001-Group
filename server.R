function(input, output) {

  output$view <- renderTable({
    input_list <- reactiveValuesToList(input)
    
    model_list <- "Generalized Boosted Modeling"
    prediction_list <- as.character(predict(fit.gbm, input_list))
    
    model_list <- append(model_list, "C5.0")
    prediction_list <-  append(prediction_list, 
                               as.character(predict(fit.c50, input_list)))

    model_list <- append(model_list, "CART")
    prediction_list <-  append(prediction_list, 
                               as.character(predict(fit.cart, input_list)))

    model_list <- append(model_list, "K Nearest Neighbors")
    prediction_list <-  append(prediction_list, 
                               as.character(predict(fit.knn, input_list)))

    model_list <- append(model_list, "Linear Discriminant Analysis")
    prediction_list <-  append(prediction_list, 
                               as.character(predict(fit.lda, input_list)))

    model_list <- append(model_list, "Naive Bayes")
    prediction_list <-  append(prediction_list, 
                               as.character(predict(fit.nb, input_list)))
    
    prediction <- data.frame(model_list, prediction_list)
    colnames(prediction)[1] <- "Model"
    colnames(prediction)[2] <- "Prediction"
    
    output$piePlot <- renderPlot({
      
      ggplot(prediction, aes(x=factor(1), fill=Prediction)) +
        geom_bar(width = 1) +
        coord_polar("y") +
        labs(title = "Cardiovascular Disease (Yes/No)")
    })
    
    prediction
    
  })
  
  
  
}