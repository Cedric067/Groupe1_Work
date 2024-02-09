# Définir l'interface utilisateur pour l'application de calcul de l'IMC
ui <- fluidPage(
  
  # Titre de l'application
  titlePanel("Cet outil vous permet de calculer votre IMC"),
  
  # Disposition de la barre latérale avec les entrées et les sorties
  sidebarLayout(
    
    # Panneau latéral avec les entrées
    sidebarPanel(
      
      # Zone de texte pour le nom
      textInput("nom", "Nom:", placeholder = "Entrez votre nom"),
      
      # Champ numérique pour l'âge
      numericInput("age", "Âge:", value = NULL, min = 1, max = 150, step = 1),
      
      # Champ numérique pour le poids
      numericInput("poids", "Poids (en kg):", value = NULL, min = 10, max = 500, step = 0.1),
      
      # Curseur pour la taille
      sliderInput("taille", "Taille (en mètres):", min = 0.5, max = 2.5, value = 1.7, step = 0.01),
      
      # Bouton pour calculer l'IMC
      actionButton("calculer", "Calculer l'IMC")
    ),
    
    # Afficher le résultat de l'IMC
    mainPanel(
      h3("Votre IMC est :"),
      verbatimTextOutput("imcBar"),
      
      # Afficher un graphique à barres de la répartition des catégories de poids
      plotOutput("imcPlot"),
      
      # Afficher les conseils basés sur l'IMC
      h3("Conseils basés sur l'IMC :"),
      verbatimTextOutput("imcAdvice")
    )
  )
)

# Définir la logique serveur nécessaire pour dessiner le graphique à barres de l'IMC
server <- function(input, output) {
  
  # Fonction pour calculer les catégories et proportions de l'IMC
  calculateBMI <- function(imc_values) {
    # Définir les seuils de l'IMC pour différentes catégories de poids
    bmi_thresholds <- c(18.5, 24.9, 29.9)  # Seuils pour la maigreur, le poids normal, le surpoids, l'obésité (selon l'OMS)
    
    # Calculer les catégories de poids pour chaque individu en fonction des seuils de l'IMC
    weight_categories <- cut(imc_values, breaks = c(-Inf, bmi_thresholds, Inf), labels = c("Sous-poids", "Poids normal", "Surpoids", "Obésité"))
    
    # Compter le nombre d'individus dans chaque catégorie de poids
    category_counts <- table(weight_categories)
    
    # Calculer les proportions de chaque catégorie de poids
    category_proportions <- prop.table(category_counts)
    
    return(category_proportions)
  }
  
  # Calculer l'IMC et l'afficher
  observeEvent(input$calculer, {
    # Calculer l'IMC pour les valeurs d'entrée actuelles
    imc <- input$poids / (input$taille^2)
    
    # Arrondir l'IMC à deux décimales
    imc_arrondi <- round(imc, 2)
    
    # Afficher l'IMC
    output$imcBar <- renderText({
      paste("Votre IMC :", imc_arrondi)
    })
    
    # Appeler la fonction pour calculer les catégories et proportions de l'IMC
    bmi_proportions <- calculateBMI(imc)
    
    # Générer un graphique à barres
    output$imcPlot <- renderPlot({
      barplot(bmi_proportions, main = "Répartition des catégories de poids", xlab = "Catégorie de poids", ylab = "Proportion", col = rainbow(length(bmi_proportions)))
    })
    
    # Déterminer les conseils en fonction de la valeur de l'IMC
    output$imcAdvice <- renderText({
      if (imc < 18.5) {
        conseils <- "Vous êtes en état de maigreur. Vous devriez consulter un professionnel de la santé pour obtenir des conseils sur la façon d'atteindre un poids santé."
      } else if (imc < 25) {
        conseils <- "Vous avez un poids normal. Continuez à maintenir un mode de vie sain en faisant de l'exercice régulièrement et en mangeant équilibré."
      } else if (imc < 30) {
        conseils <- "Vous êtes en surpoids. Il est recommandé de perdre un peu de poids en faisant de l'exercice régulièrement et en adoptant un régime alimentaire équilibré."
      } else {
        conseils <- "Vous êtes obèse. Il est fortement recommandé de consulter un professionnel de la santé pour obtenir un plan de perte de poids et des conseils sur la gestion de votre santé."
      }
      conseils
    })
  })
}

# Exécuter l'application Shiny
shinyApp(ui = ui, server = server)
