library(shiny)

# Définition de l'interface utilisateur
ui <- fluidPage(
  titlePanel("FOOD SAFETY - Informations"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("sexe", "Sexe :", choices = c("M" = "Masculin", "F" = "Féminin")),
      textInput("nom", "Nom:", placeholder = "Entrez votre nom"),
      textInput("prenom", "Prénom:", placeholder = "Entrez votre prénom")
    ),
    mainPanel(
      textOutput("resultat_nom_prenom")
    )
  )
)

# Serveur de l'application
server <- function(input, output) {
  output$resultat_nom_prenom <- renderText({
    paste("Nom :", input$nom, "<br>",
          "Prénom :", input$prenom)
  })
}

# Lancement de l'application Shiny
shinyApp(ui = ui, server = server)
