library(shiny)

liste_pays <- c("Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Côte d'Ivoire", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo (Congo-Brazzaville)", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini (Swaziland)", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Holy See", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar (Burma)", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "North Macedonia (formerly Macedonia)", "Norway", "Oman", "Pakistan", "Palau", "Palestine State", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe")

# Définition de l'interface utilisateur
ui <- fluidPage(
  
  # Titre de l'application
  titlePanel("Application de Recettes"),
  
  # Première section : Introduction à l'application
  mainPanel(
    h4("Bienvenue dans notre application de recettes équilibrées!"),
    p("Cette application vous permettra de découvrir des recettes adaptées à vos ingrédients disponibles dans votre frigo."),
    p("Pour commencer, veuillez remplir les informations ci-dessous :")
  ),
  
  # Deuxieme section : information users 
  sidebarPanel(
    # Sélection du sexe
    radioButtons("sexe", "Sexe :", choices = c("M" = "Masculin", "F" = "Féminin")),
    
    # Zone de texte pour le nom
    textInput("nom", "Nom:", placeholder = "Entrez votre nom"),
    
    # Zone de texte pour le prénom
    textInput("prenom", "Prénom:", placeholder = "Entrez votre prénom"),
    
    # Champ numérique pour le poids
    numericInput("poids", "Poids (en kg):", value = NULL, min = 10, max = 500, step = 0.1),
    
    # Curseur pour la taille
    sliderInput("taille", "Taille (en mètres):", min = 0.5, max = 2.5, value = 1.7, step = 0.01),
    
    # Liste déroulante pour sélectionner le pays
    selectInput("pays", "Pays :", choices = liste_pays),
    
    # Bouton pour calculer l'IMC
    actionButton("calculer", "Calculer l'IMC")
  ),
  
  # Afficher le résultat de l'IMC
  mainPanel(
    h3("Votre IMC est :"),
    textOutput("resultat_imc"),
    br(),
    h4("Conseils :"),
    textOutput("imcAdvice"),
    
    # Bouton pour la sélection de recette
    actionButton("selection_recette", "Sélection de recette")
  )
)

# Définition du serveur
server <- function(input, output) {
  # Logique du serveur pour calculer l'IMC et afficher le résultat
  observeEvent(input$calculer, {
    poids <- input$poids
    taille <- input$taille
    imc <- poids / (taille^2)
    output$resultat_imc <- renderText({
      paste("Votre IMC est :", round(imc, 2))
    })
    
    # Déterminer les conseils en fonction de la valeur de l'IMC et du sexe
    output$imcAdvice <- renderText({
      sexe <- ifelse(input$sexe == "M", "Mr", "Mme")
      if (imc < 18.5) {
        conseils <- paste(sexe, input$nom, input$prenom, ", si votre IMC est inférieur à 18,5, cela peut indiquer un sous-poids, ce qui peut être associé à un risque accru de certaines complications de santé. Il est important de chercher à atteindre un poids santé de manière saine. Voici quelques conseils :
Consultez un professionnel de la santé pour déterminer les causes possibles de votre sous-poids et élaborer un plan pour atteindre un poids santé.
Adoptez une alimentation riche en calories et nutritive, en privilégiant les aliments densément nutritifs tels que les noix, les graines, les avocats, les produits laitiers, les céréales complètes, les légumineuses et les viandes maigres.
Essayez de manger régulièrement et d'ajouter des collations saines entre les repas pour augmenter votre apport calorique quotidien.
Faites de l'exercice régulièrement pour renforcer vos muscles et favoriser un gain de poids sous forme de masse musculaire maigre.")
      } else if (imc < 25) {
        conseils <- paste("Félicitations,", sexe, input$nom, input$prenom, ", vous êtes dans la plage de poids considérée comme normale pour votre taille. Cependant, il est toujours important de maintenir de saines habitudes de vie pour optimiser votre santé globale. Voici quelques conseils :
Continuez à adopter une alimentation équilibrée comprenant une variété d'aliments nutritifs, notamment des fruits, des légumes, des protéines maigres, des céréales complètes et des graisses saines.
Faites de l'exercice régulièrement en intégrant une combinaison d'activités cardiovasculaires, de renforcement musculaire et de flexibilité pour maintenir votre condition physique.
Surveillez votre poids et votre composition corporelle régulièrement pour détecter tout changement significatif et ajustez votre alimentation et votre exercice en conséquence si nécessaire.")
      } else if (imc < 30) {
        conseils <- paste("Un IMC situé entre 25 et 29,9 indique que", sexe, input$nom, input$prenom, ", vous êtes en surpoids, ce qui peut augmenter le risque de développer certaines maladies chroniques telles que les maladies cardiaques, le diabète de type 2 et l'hypertension. Voici quelques conseils pour atteindre un poids santé :
Adoptez une alimentation équilibrée et réduisez votre consommation de calories en limitant les aliments riches en sucres ajoutés, en graisses saturées et en aliments transformés.
Augmentez votre activité physique en intégrant au moins 150 minutes d'exercice modéré à vigoureux par semaine, ce qui peut aider à brûler des calories supplémentaires et à favoriser une perte de poids saine.
Fixez-vous des objectifs réalistes de perte de poids et surveillez votre progression en tenant un journal alimentaire et en suivant vos habitudes d'exercice.")
      } else {
        conseils <- paste("Un IMC de 30 ou plus indique une obésité, ce qui peut entraîner un risque significativement accru de divers problèmes de santé graves. Si votre IMC se situe dans cette fourchette,", sexe, input$nom, input$prenom, ", il est important de prendre des mesures pour perdre du poids et améliorer votre santé globale. Voici quelques conseils :
Consultez un professionnel de la santé pour obtenir une évaluation complète de votre santé et discuter des options de perte de poids adaptées à votre situation spécifique.
Suivez un plan alimentaire équilibré et réduit en calories, en vous concentrant sur des aliments riches en nutriments tels que les fruits, les légumes, les protéines maigres et les céréales complètes.
Engagez-vous dans une activité physique régulière comprenant à la fois des exercices cardiovasculaires et de renforcement musculaire pour brûler des calories et renforcer votre corps.
Envisagez des interventions médicales ou chirurgicales si votre obésité est sévère et si d'autres mesures n'ont pas été efficaces pour atteindre un poids santé.")
      }
      conseils
    })
  })
  
  # Logique du serveur pour la sélection de recette
  observeEvent(input$selection_recette, {
    # Ajouter ici la logique pour la sélection de recette
    # Cette partie sera développée en fonction des besoins spécifiques de votre application
  })
}

# Exécution de l'application Shiny
shinyApp(ui = ui, server = server)
