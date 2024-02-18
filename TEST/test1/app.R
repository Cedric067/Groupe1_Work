#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

## Define server logic required to draw BMI bar chart
server <- function(input, output) {
  
  # Function to calculate BMI categories and proportions
  calculateBMI <- function(imc_values) {
    # Define BMI thresholds for different weight categories
    bmi_thresholds <- c(18.5, 24.9, 29.9)  # Thresholds for underweight, normal weight, overweight, obesity (according to WHO)
    
    # Calculate weight categories for each individual based on BMI thresholds
    weight_categories <- cut(imc_values, breaks = c(-Inf, bmi_thresholds, Inf), labels = c("Underweight", "Normal weight", "Overweight", "Obesity"))
    
    # Count the number of individuals in each weight category
    category_counts <- table(weight_categories)
    
    # Calculate proportions of each weight category
    category_proportions <- prop.table(category_counts)
    
    return(category_proportions)
  }
  
  # Function to generate BMI bar chart
  output$imcPlot <- renderPlot({
    # Call the function to calculate BMI categories and proportions
    bmi_proportions <- calculateBMI(input$imc)
    
    # Generate bar chart
    barplot(bmi_proportions, main = "Répartition des catégories de poids", xlab = "Catégorie de poids", ylab = "Proportion", col = rainbow(length(bmi_proportions)))
  })
  
  # Calculate BMI and display it
  output$imcBar <- renderUI({
    # Calculate BMI for the current input values
    imc <- input$poids / (input$taille^2)
    
    # Round IMC to two decimal places
    imc_rounded <- round(imc, 2)
    
    # Create a bar with the IMC value
    tags$div(
      style = paste0("width: ", imc_rounded * 10, "px; background-color: blue; color: white; padding: 5px;"),
      paste("Votre IMC :", imc_rounded)
    )
  })
}



# Définition de la logique du serveur nécessaire pour dessiner le diagramme à barres de l'IMC
server <- function(input, output) {
  
  # Fonction pour calculer les catégories et les proportions de l'IMC
  calculerIMC <- function(valeurs_imc) {
    # Définir les seuils de l'IMC pour différentes catégories de poids
    seuils_imc <- c(18.5, 24.9, 29.9)  # Seuils pour le poids insuffisant, le poids normal, le surpoids, l'obésité (selon l'OMS)
    
    # Calculer les catégories de poids pour chaque individu en fonction des seuils de l'IMC
    categories_poids <- cut(valeurs_imc, breaks = c(-Inf, seuils_imc, Inf), labels = c("Insuffisant", "Poids normal", "Surpoids", "Obésité"))
    
    # Compter le nombre d'individus dans chaque catégorie de poids
    comptes_categories <- table(categories_poids)
    
    # Calculer les proportions de chaque catégorie de poids
    proportions_categories <- prop.table(comptes_categories)
    
    return(proportions_categories)
  }
  
  # Fonction pour générer le diagramme à barres de l'IMC
  output$imcPlot <- renderPlot({
    # Calculer l'IMC pour les valeurs d'entrée actuelles
    imc <- input$poids / (input$taille^2)
    
    # Appeler la fonction pour calculer les catégories et les proportions de l'IMC
    proportions_imc <- calculerIMC(imc)
    
    # Générer le diagramme à barres
    bp <- barplot(proportions_imc, col = rainbow(length(proportions_imc)), main = "Distribution des catégories de poids", xlab = "Catégorie de poids", ylab = "Proportion")
    
    # Ajouter du texte pour afficher la valeur de l'IMC au-dessus de chaque barre
    text(x = bp, y = proportions_imc, labels = round(imc, 2), pos = 3, cex = 0.8, col = "black")
  })
}

# Exécuter l'application 
shinyApp(ui = ui, server = server)
