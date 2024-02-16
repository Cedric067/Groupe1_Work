# UI de l'application
ui <- fluidPage(
  titlePanel("FOOD SAFETY"),
  tabsetPanel(
    tabPanel("Informations",
             sidebarLayout(
               sidebarPanel(
                 radioButtons("sexe", "Sexe :", choices = c("M" = "Masculin", "F" = "Féminin")),
                 textInput("nom", "Nom:", placeholder = "Entrez votre nom"),
                 textInput("prenom", "Prénom:", placeholder = "Entrez votre prénom"),
                 numericInput("poids", "Poids (en kg):", value = NULL, min = 10, max = 500, step = 0.1),
                 sliderInput("taille", "Taille (en mètres):", min = 0.5, max = 2.5, value = 1.7, step = 0.01),
                 selectInput("pays", "Pays :", choices = liste_pays),
                 actionButton("calculer", "Calculer l'IMC")
               ),
               mainPanel(
                 h3("Votre IMC est :"),
                 textOutput("resultat_imc"),
                 br(),
                 h4("Conseils :"),
                 textOutput("imcAdvice"),
                 conditionalPanel(
                   condition = "!$('#nom').val() == '' && !$('#prenom').val() == '' && !$('#poids').val() == '' && !$('#taille').val() == ''",
                   actionButton("selection_recette", "Sélection de recette"),
                   # Ajoutez une sortie pour l'image physique
                   uiOutput("physique_image")
                 )
               )
             )),
    tabPanel("Choix de recette",
             sidebarLayout(
               sidebarPanel(
                 selectInput("ingredient", "Ingrédients :", choices = ingredients, multiple = TRUE),
                 selectInput("type_recette", "Type de plats :", choices = c("Tous", "Entrée", "Plat principal", "Dessert", "Apéritif")),
                 selectInput("allergene", "Allergènes :", choices = allergenes, multiple = TRUE),
                 selectInput("regime", "Régimes :", choices = regimes, multiple = TRUE)
               ),
               mainPanel(
                 h2("Recettes disponibles", align = "center", style = "color: #000000;"),
                 DTOutput("recettes_table"),
                 tags$style(HTML("
        .dataTables_wrapper {
          background-color: #FFDAB9;
          padding: 20px;
          border-radius: 10px;
          box-shadow: none;
        }
      "))
               )
             ))
  )
)


