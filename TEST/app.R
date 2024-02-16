
  ## Essai code interface sélection recettes en fonction de choix d'ingrédients et de plats
  
  #install.packages("shinydashboard")
  #install.packages("DT")
  
library(shinydashboard)
library(shiny)
library(DT)

ingredients <- c("Oeufs", "Légumes variés", "Sel", "Poivre", "Pâtes", "Lardons", "Crème fraîche",
                 "Parmesan", "Laitue", "Croûtons", "Poulet", "Sauce césar", "Poulet entier",
                 "Herbes aromatiques", "Aubergine", "Courgette", "Poivron", "Tomate", "Oignon",
                 "Ail", "Huile d'olive", "Herbes de Provence", "Viande hachée", "Persil",
                 "Chapelure", "Viande de boeuf", "Fromage blanc", "Fruits rouges", "Citron",
                 "Farine", "Fruits frais variés", "Crème pâtissière", "Sucre glace", "Menthe",
                 "Riz arborio", "Champignons", "Vin blanc", "Beurre", "Pâte brisée", "Saumon fumé",
                 "Poireaux", "Quinoa", "Vinaigre balsamique", "Farine de sarrasin", "Fromage de chèvre",
                 "Crème fraîche épaisse", "Crème fraîche liquide", "Levure chimique", "Gingembre",
                 "Yaourt nature", "Épices indiennes", "Coriandre", "Carottes", "Bouillon de légumes",
                 "Cumin", "Fromage à fondue", "Pain", "Cornichons", "Pommes de terre", "Lentilles",
                 "Avocat", "Lait de coco", "Curry", "Cerises", "Vanille", "Tortillas", "Haricots rouges",
                 "Crème fraîche allégée", "Mélange de légumes mexicains")
recettes <- data.frame(
  Nom = c("Omelette aux Légumes", "Pâtes à la Carbonara", "Salade César", "Poulet rôti aux Herbes", "Ratatouille Provençale",
          "Boulettes de Viande à la Provençale", "Gâteau au Fromage Blanc et Fruits Rouges", "Risotto aux Champignons et Parmesan",
          "Tarte aux Poireaux et Saumon Fumé", "Salade de Quinoa aux Légumes Rôtis", "Muffins aux Myrtilles et Amandes",
          "Poulet Tikka Masala", "Galette de Sarrasin aux Champignons et Fromage de Chèvre", "Velouté de Carottes au Cumin",
          "Fondue au Fromage et Vin Blanc", "Salade de Lentilles et Avocat", "Poulet au Curry et Lait de Coco",
          "Clafoutis aux Cerises et Amandes", "Tacos Mexicains aux Haricots et Avocat", "Gâteau de Crêpes aux Fruits Frais"),
  Type = c("Entrée", "Plat principal", "Entrée", "Plat principal", "Plat principal",
           "Plat principal", "Dessert", "Plat principal", "Plat principal", "Entrée",
           "Dessert", "Plat principal", "Plat principal", "Entrée", "Plat principal",
           "Entrée", "Plat principal", "Dessert", "Plat principal", "Dessert"),
  Ingrédients = c("Oeufs, Légumes variés, Sel, Poivre", "Pâtes, Lardons, Oeufs, Crème fraîche, Parmesan, Poivre",
                  "Laitue, Croûtons, Poulet, Parmesan, Sauce césar", "Poulet entier, Herbes aromatiques, Sel, Poivre",
                  "Aubergine, Courgette, Poivron, Tomate, Oignon, Ail, Huile d'olive, Herbes de Provence",
                  "Viande hachée, Oignon, Ail, Persil, Chapelure, Oeuf, Sel, Poivre",
                  "Fromage blanc, Oeufs, Sucre, Farine, Fruits rouges, Citron, Sel",
                  "Riz arborio, Champignons, Oignon, Vin blanc, Bouillon de légumes, Parmesan, Beurre, Sel, Poivre",
                  "Pâte brisée, Poireaux, Saumon fumé, Crème fraîche, Oeufs, Sel, Poivre",
                  "Quinoa, Courgette, Poivron, Tomate, Oignon, Huile d'olive, Vinaigre balsamique, Sel, Poivre",
                  "Farine, Sucre, Oeufs, Lait, Beurre, Myrtilles, Amandes, Levure chimique, Sel",
                  "Poulet, Tomate, Oignon, Ail, Gingembre, Yaourt nature, Épices indiennes, Coriandre, Sel, Poivre",
                  "Farine de sarrasin, Oeufs, Champignons, Fromage de chèvre, Crème fraîche, Sel, Poivre",
                  "Carottes, Oignon, Ail, Bouillon de légumes, Crème fraîche, Cumin, Sel, Poivre",
                  "Fromage à fondue, Vin blanc, Ail, Pain, Cornichons, Pommes de terre, Sel, Poivre",
                  "Lentilles, Avocat, Tomate, Persil, Citron, Huile d'olive, Sel, Poivre",
                  "Poulet, Lait de coco, Curry, Oignon, Ail, Gingembre, Coriandre, Sel, Poivre",
                  "Cerises, Oeufs, Farine, Sucre, Lait, Amandes, Beurre, Sel, Vanille",
                  "Tortillas, Haricots rouges, Avocat, Tomate, Oignon, Coriandre, Fromage râpé, Crème fraîche, Sel, Poivre",
                  "Crêpes, Fruits frais variés, Crème pâtissière, Sucre glace, Menthe"),
  Instructions = c("Battez les oeufs, ajoutez les légumes, assaisonnez avec sel et poivre, faites cuire dans une poêle chaude.",
                   "Faites cuire les pâtes, faites revenir les lardons, mélangez avec les pâtes cuites, les oeufs battus, la crème fraîche, le parmesan et le poivre.",
                   "Mélangez la laitue, les croûtons, le poulet, le parmesan, ajoutez la sauce césar, mélangez.",
                   "Assaisonnez le poulet avec des herbes aromatiques, du sel et du poivre, faites rôtir au four.",
                   "Faites revenir les légumes dans l'huile d'olive avec l'ail et l'oignon, assaisonnez avec les herbes de Provence.",
                   "Mélangez la viande hachée avec l'oignon, l'ail, le persil, la chapelure, l'oeuf, formez des boulettes, faites cuire dans une poêle.",
                   "Mélangez le fromage blanc, les oeufs, le sucre, la farine, le citron, ajoutez les fruits rouges, faites cuire au four.",
                   "Faites revenir l'oignon dans du beurre, ajoutez le riz et le vin blanc, puis le bouillon de légumes, les champignons, le parmesan, assaisonnez.",
                   "Faites revenir les poireaux, étalez-les sur la pâte brisée, ajoutez le saumon fumé, le mélange d'oeufs et de crème fraîche, assaisonnez, faites cuire au four.",
                   "Faites rôtir les légumes dans l'huile d'olive, mélangez avec le quinoa cuit, assaisonnez avec le vinaigre balsamique, le sel et le poivre.",
                   "Mélangez la farine, le sucre, les oeufs, le lait, le beurre fondu, les myrtilles, les amandes, la levure chimique, le sel, faites cuire au four.",
                   "Faites revenir le poulet, les oignons, l'ail et le gingembre, ajoutez les tomates, les épices, le yaourt, la coriandre, faites mijoter.",
                   "Faites cuire les galettes de sarrasin, garnissez-les avec les champignons poêlés et le fromage de chèvre, ajoutez la crème fraîche, assaisonnez.",
                   "Faites cuire les carottes, l'oignon et l'ail dans le bouillon de légumes, mixez avec la crème fraîche et le cumin, assaisonnez.",
                   "Faites fondre le fromage dans le vin blanc avec l'ail, trempez les morceaux de pain dans le fromage fondu, servez avec les cornichons et les pommes de terre.",
                   "Faites cuire les lentilles, mélangez avec les avocats, les tomates, le persil, le citron, l'huile d'olive, assaisonnez.",
                   "Faites cuire le poulet avec l'oignon, l'ail, le curry, ajoutez le lait de coco, laissez mijoter, assaisonnez.",
                   "Dénoyautez les cerises, mélangez les oeufs, la farine, le sucre, le lait, les amandes, faites cuire au four.",
                   "Réchauffez les tortillas, garnissez de haricots, d'avocat, de tomate, d'oignon, de coriandre, de fromage râpé, de crème fraîche, assaisonnez.",
                   "Alternez les crêpes avec la crème pâtissière et les fruits frais, saupoudrez de sucre glace, décorez de feuilles de menthe."),
  Temps = c("15 minutes", "20 minutes", "30 minutes", "1 heure", "45 minutes",
            "45 minutes", "1 heure", "30 minutes", "45 minutes", "40 minutes",
            "30 minutes", "45 minutes", "25 minutes", "40 minutes", "30 minutes",
            "20 minutes", "50 minutes", "30 minutes", "20 minutes", "45 minutes"),
  Origine = c("France", "Italie", "États-Unis", "France", "France",
              "France", "France", "Italie", "France", "International",
              "France", "Inde", "France", "Suisse", "France",
              "International", "France", "France", "Mexique", "France"),
  stringsAsFactors = FALSE
)

allergenes <- c("Gluten", "Lactose", "Oeufs", "Arachides", "Fruits à coque")
regimes <- c("Tous", "Végétarien", "Végétalien", "Sans gluten", "Cétogène")
types_plat <- c("Tous", "Entrée", "Plat principal", "Dessert", "Apéritif")
durees <- c("Tous", "Express (<20 min)", "Rapide (<30 min)", "Normale (<1 heure)", "Longue (<2 heures)")
origine <- c("Tous", "France", "Italie", "États-Unis", "Inde", "Suisse", "Mexique", "International")

liste_pays <- c("Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Côte d'Ivoire", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo (Congo-Brazzaville)", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini (Swaziland)", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Holy See", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar (Burma)", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "North Macedonia (formerly Macedonia)", "Norway", "Oman", "Pakistan", "Palau", "Palestine State", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe")

ui <- dashboardPage(
  dashboardHeader(title = "NutriPlaisirs"),
  dashboardSidebar(
    sidebarMenu(
      # Onglets dans le menu
      menuItem("Profil Nutritionnel", tabName = "user", icon = icon("user")), 
      menuItem("Choix de Recettes", tabName = "filter_recipes", icon = icon("cutlery")),
      menuItem("Recommandations", tabName = "aides", icon = icon("search")),
      menuItem("À propos", tabName = "about", icon = icon("info-circle"))
    )
  ),
  #style de l'interface
  dashboardBody(
    tags$head(tags$style(HTML('
                              /* Styles du logo dans len-tête */
                                .skin-blue .main-header .logo {
                                  background-color: #354B61; /* Couleur de fond du logo */
                                    color: #ECF0F5; /* Couleur du texte des autres liens dans le menu latéral */
                                }
                              
                              /* Styles du logo lorsquil est survolé */
                                .skin-blue .main-header .logo:hover {
                                  background-color: #2E4154; /* Couleur de fond du logo lorsquil est survolé */
                                                              }
                              
                              /* Styles de la barre de navigation */
                                .skin-blue .main-header .navbar {
                                  background-color: #496785; /* Couleur de fond de la barre de navigation */
                                }
                              
                              /* Styles de la barre latérale principale */
                                .skin-blue .main-sidebar {
                                  background-color: #354B61; /* Couleur de fond de la barre latérale principale */
                                }
                              
                              /* Styles de longlet sélectionné dans le menu latéral */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu .active a {
                                  background-color: #1D2A36; /* Couleur de fond de longlet sélectionné dans le menu latéral */
                                }
                              
                              /* Styles des autres liens dans le menu latéral */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a {
                                  background-color: #263545; /* Couleur de fond des autres liens dans le menu latéral */
                                    color: #FFFFFF; /* Couleur du texte des autres liens dans le menu latéral */
                                }
                              
                              /* Styles des autres liens dans le menu latéral lorsquils sont survolés */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover {
                                  background-color: #1D2A36; /* Couleur de fond des autres liens dans le menu latéral lorsquils sont survolés */
                                }
                              
                              /* Styles du bouton de basculement lorsquil est survolé */
                                .skin-blue .main-header .navbar .sidebar-toggle:hover {
                                  background-color: #3E5770; /* Couleur de fond du bouton de basculement lorsquil est survolé */
                                }
                              
                              /* Styles de la zone de contenu */
                                .content-wrapper, .right-side {
                                  background-color: #ECF0F5; /* Couleur de fond de la zone de contenu */
                                }
                              
                              /* Styles des éléments de menu dans la barre latérale */
                                .treeview-menu > li > a {
                                  width: 240px; /* Définir une largeur fixe pour les éléments de menu */
                                }
                              
                              /* Styles de la boîte personnalisée */
                                .custom-box {
                                  background-color: #E1E9F5; /* Couleur de fond de la boîte personnalisée */
                                }
                                
                                /* Styles de la boîte personnalisée */
                                .custom-box1 {
                                  background-color: #CED5E0; /* Couleur de fond de la boîte petit déjeuner */
                                }
                                
                                /* Styles de la boîte personnalisée */
                                .custom-box2 {
                                  background-color: #CED5E0; /* Couleur de fond de la boîte déjeuner */
                                }
                                
                                /* Styles de la boîte personnalisée */
                                .custom-box3 {
                                  background-color: #CED5E0; /* Couleur de fond de la boîte diner */
                                }
                                
                                /* Styles de la boîte personnalisée */
                                .custom-box4 {
                                  background-color: #CED5E0; /* Couleur de fond des boîtes résultats IMC et kcal */
                                }
                              
                              /* Styles du popup */
                                .modal-content {
                                  background-color: #E1E9F5; /* Couleur de fond du popup */
                                }
                              
                              /* Styles de len-tête du popup */
                                .modal-header {
                                  background-color: #3C8DBC; /* Couleur de fond de len-tête du popup */
                                color: #fff; /* Couleur du texte de len-tête du popup */
                                }
                                
                                /* Styles du bouton Calculer */
                                #calculate_button {
                                  background-color: #428BCA; /* Couleur de fond du bouton Calculer */
                                  border-color: #428BCA; /* Couleur de bordure du bouton Calculer */
                                  color: #fff; /* Couleur du texte */
                                }
                                
                                /* Ajoutez la classe personnalisée pour centrer le texte dans le wellPanel */
                                .center-text {
                                  text-align: center;
                                }

                              '))),
    
    # Définir la largeur du corps du tableau de bord
    width = "100%",
    tabItems(
      # 2ème onglet Choix de Recettes
      tabItem(
        tabName = "filter_recipes",
        h2("Choix de Recettes"),
        fluidRow(
          box(
            width = 12, # Utiliser la largeur complète de la rangée
            title = "Filtrer les Recettes",
            status="primary",
            solidHeader = TRUE,
            collapsible = TRUE,
            fluidRow(
              column(2, selectizeInput("ingredient", "Ingrédients", choices = ingredients, multiple = TRUE, options = list(
                placeholder = "Sélectionnez les ingrédients...",
                plugins = list('remove_button')
              ))),
              column(2, selectizeInput("allergene", "Allergènes", choices = allergenes, multiple = TRUE, options = list(
                placeholder = "Sélectionnez les allergènes...",
                plugins = list('remove_button')
              ))),
              column(2, selectizeInput("regime", "Diète", choices = setNames(regimes, regimes), options = list(
                placeholder = "Sélectionnez la diète...",
                plugins = list('remove_button')
              ))),
              column(2, selectizeInput("type_recette", "Type de plat", choices = types_plat, options = list(
                placeholder = "Sélectionnez le type de plat...",
                plugins = list('remove_button')
              ))),
              column(2, selectizeInput("duree", "Durée de préparation", choices = setNames(durees, durees), options = list(
                placeholder = "Sélectionnez la durée de préparation...",
                plugins = list('remove_button')
              ))),
              column(2, selectizeInput("origine", "Origine", choices = origine, options = list(
                placeholder = "Sélectionnez le type d'origine...",
                plugins = list('remove_button')
              )))
            ),
            class = "custom-box" 
          )
        ),
        fluidRow(
          box(
            width = 12, # Utiliser la largeur complète de la rangée
            title = "Recettes",
            status="primary",
            solidHeader = TRUE,
            collapsible = TRUE,
            DTOutput("recettes_table"),
            class = "custom-box" # Appliquer couleur du fond de box
          )
        )
      ),
      
      # 4ème onglet About l'appli
      tabItem(
        tabName = "about",
        h2("À propos de NutriPlaisirs"),
        h3("NutriPlaisirs : Des Recettes à Votre Goût"),
        p("Cette application a été développée pour vous aider à trouver des recettes délicieuses en fonction de vos préférences et de vos objectifs."),
        p("Elle vous permet de filtrer les recettes en fonction de divers critères tels que les ingrédients, les allergènes, le type de plat, la durée de préparation et l'origine. Elle vous permet aussi, par la même occasion, de calculer votre besoin énergétique journalier."),
        p("Profitez de NutriPlaisirs pour découvrir de nouvelles idées culinaires et atteindre vos objectifs !"),
        h3("Auteurs"),
        p("L'application a été conçue dans le cadre du module OPEN par des étudiants de l'Isara."),
        p("Les auteurs de cette application sont :"),
        p("- Cédric Octave ADECHINA"),
        p("- Zineb BELMADAN"),
        p("- Maxime DE BONI"),
        p("- Diamande DELANNAY"),
        p("- Antônio Gabriel ELEUTERIO VIANA ?"),
        p("- Thomas FERNANDEZ-SANTONNAT"),
        h3("Informations des calculs nutritionnels"),
        p("Les valeurs de kcal/j sont basées sur des recommandations générales et peuvent nécessiter des ajustements en fonction de facteurs individuels tels que la composition corporelle et l'état de santé. Ils fournissent donc une estimation générale des besoins caloriques quotidiens et de la répartition des calories entre les repas. Il est toujours recommandé de consulter un professionnel pour obtenir des conseils nutritionnels personnalisés."),
        p("Voici comment les différents calculs sont effectués :"),
        h4("1. Calcul de l'IMC (Indice de Masse Corporelle) :"),
        p("L'IMC est calculé en divisant le poids (en kg) par le carré de la taille (en m). Cet indice est utilisé pour évaluer le statut pondéral d'une personne."),
        h4("2. Calcul des besoins caloriques quotidiens :"), 
        p("Les besoins caloriques quotidiens sont calculés à partir de la formule du BMR (Basal Metabolic Rate), qui est une estimation des calories que votre corps brûle au repos. Cette estimation tient compte de facteurs tels que votre poids, votre taille, votre âge et votre sexe."), 
        p("Ensuite, en fonction de votre niveau d'activité physique, cette estimation est ajustée. Les personnes plus actives ont besoin de plus de calories pour soutenir leurs activités quotidiennes et leurs exercices physiques."),
        p("Puis les objectifs sont pris en compte à partir de la moyenne de ces recommandations :"),
        p("    - Si l'objectif est de garder le même poids, il faut un apport calorique quotidien égal."),
        p("    - Si l'objectif est de prendre du poids, il faut augmenter légèrement l'apport calorique quotidien (de 200 à 500 kcal)."),
        p("    - Si l'objectif est de prendre de la masse musculaire, il faut augmenter légèrement l'apport calorique quotidien (de 300 kcal)."),
        p("    - Si l'objectif est de perdre du poids, il faut diminuer progressivement l'apport calorique quotidien (de 300 à 700 kcal)."),
        h4("3. Répartition des calories entre les repas :"), 
        p("Les calories sont réparties entre les repas (petit-déjeuner, déjeuner, dîner) en fonction de proportions standard. En moyenne, le petit-déjeuner représente environ 20-25% des calories totales, le déjeuner et le dîner environ 30-35% chacun.")
      ),
      
      # 1er onglet Informations utilisateur
      tabItem(
        tabName = "user",
        h2("Profil Nutritionnel et Besoins Caloriques"),
        h3("Calculateur de besoins caloriques journaliers"),
        sidebarLayout(
          sidebarPanel(
            width = 6,
            numericInput("weight", "Entrez votre poids (en kg) :", value = 70),
            sliderInput("height", "Choisissez votre taille (en m) :", min = 0.5, max = 2.5, value = 1.7, step = 0.01),
            numericInput("age", "Entrez votre âge :", value = 30),
            radioButtons("gender", "Genre :",
                         c("Homme", "Femme")),
            radioButtons("activity_level", "Niveau d'activité physique :",
                         c("Sédentaire" = 1, "Modéré" = 2, "Actif" = 3)),
            selectInput("goal", "Objectif :",
                        c("Maintenir le poids", "Prendre du poids", "Prendre de la masse musculaire", "Perdre du poids")),
            actionButton("calculate_button", "Calculer"),
            class = "custom-box" # Appliquer couleur du fond de box
          ),
          mainPanel(
            width = 5,
            h3("Comment utiliser le calculateur de besoins caloriques journaliers ? "),
            wellPanel(
              p("Entrez vos informations personnelles dans le panneau de gauche :"),
              p("- Renseignez votre âge, votre sexe, votre poids et votre taille"), 
              p("- Sélectionnez votre niveau d'activité physique et votre objectif parmi les options proposées"),
              p("- Cliquez sur le bouton : Calculer pour obtenir une estimation des calories à consommer"),
              class = "custom-box" # Appliquer couleur du fond de box
            ),
            conditionalPanel(
              condition = "input.calculate_button > 0",
              h3("Résultats IMC"),
              wellPanel(
                textOutput("bmi_result"),
                class = "custom-box4" 
              ),
              h3("Besoins caloriques quotidiens"),
              wellPanel(
                textOutput("calories_result"),
                class = "custom-box4" 
              ),
              h3("Proposition de calories par repas"),
              fluidRow(
                column(4, 
                       wellPanel(
                         h4("Petit-déjeuner"),
                         textOutput("breakfast_calories"),
                         class = "custom-box1 center-text" 
                       )
                ),
                column(4, 
                       wellPanel(
                         h4("Déjeuner"),
                         textOutput("lunch_calories"),
                         class = "custom-box2 center-text" 
                       )
                ),
                column(4, 
                       wellPanel(
                         h4("Dîner"),
                         textOutput("dinner_calories"),
                         class = "custom-box3 center-text"
                       )
                )
              )
            )
          )
        )
      ),
      
      # 3ème onglet Recommandations
      tabItem(
        tabName = "aides",
        h2("Recommandations basées sur l'IMC"),
        p("Conseil"),
        textOutput("imc_recommandations"),
        uiOutput("physique_image")
      )
    )
  )
)




import gspread
from oauth2client.service_account import ServiceAccountCredentials

# Définir les informations d'identification pour accéder à Google Sheets
scope = ['https://spreadsheets.google.com/feeds', 'https://www.googleapis.com/auth/drive']
creds = ServiceAccountCredentials.from_json_keyfile_name('credentials.json', scope)
client = gspread.authorize(creds)

# Accéder à la feuille de calcul
sheet = client.open('Nom_De_Votre_Feuille_De_Calcul').sheet1

# Obtenir toutes les valeurs de la feuille de calcul
data = sheet.get_all_values()

# Convertir les données en dictionnaire
data_dict = {}
for row in data[1:]:  # Ignorer la première ligne (en-têtes)
  data_dict[row[0]] = {
    recettes$Nom: row[2],
    recette$Type: row[3],
    recettes$Ingrédients : row[4,5,6,7,8],
    recettes$Instructions: row[9],
    recettes$Origine: row[10],
    recettes$Temps: row[11],
    recettes$Calories : row[12],
    recettes$regimes : row [13],
    recettes$Allergene : row [14]
  }



allergenes <- c("Gluten", "Lactose", "Oeufs", "Arachides", "Fruits à coque")
regimes <- c("Tous", "Végétarien", "Végétalien", "Sans gluten", "Cétogène")
types_plat <- c("Tous", "Entrée", "Plat principal", "Dessert", "Apéritif")
durees <- c("Tous", "Express (<20 min)", "Rapide (<30 min)", "Normale (<1 heure)", "Longue (<2 heures)")
origine <- c("Tous", "France", "Italie", "États-Unis", "Inde", "Suisse", "Mexique", "International")
Cal<- c("<200cal","<500cal",">500cal")
liste_pays <- c("Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Côte d'Ivoire", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo (Congo-Brazzaville)", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini (Swaziland)", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Holy See", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar (Burma)", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "North Macedonia (formerly Macedonia)", "Norway", "Oman", "Pakistan", "Palau", "Palestine State", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe")



# Définition de la fonction pour calculer les besoins caloriques quotidiens
calculate_calories <- function(weight_kg, height_m, age, gender, activity_level, goal) {
  bmr <- ifelse(gender == "Homme", 10 * weight_kg + 6.25 * 100 * height_m - 5 * age + 5,
                ifelse(gender == "Femme", 10 * weight_kg + 6.25 * 100 * height_m - 5 * age - 161, NA))
  
  activity_factor <- ifelse(activity_level == 1, 1.2,
                            ifelse(activity_level == 2, 1.4,
                                   ifelse(activity_level == 3, 1.6, NA)))
  
  if (goal == "Maintenir le poids") {
    calories <- bmr * activity_factor
  } else if (goal == "Prendre du poids") {
    calories <- bmr * activity_factor + 350
  } else if (goal == "Prendre de la masse musculaire") {
    calories <- bmr * activity_factor + 300
  } else if (goal == "Perdre du poids") {
    calories <- bmr * activity_factor - 500
  }
  
  return(calories)
}



server <- function(input, output, session) {
  recettes_filtrées <- reactive{
    filtered_recipes <- recettes
    
    # Filtrer par ingrédients sélectionnés
    if (!is.null(input$ingredient) && length(input$ingredient) > 0) {
      filtered_recipes <- filtered_recipes[sapply(filtered_recipes$Ingrédients, function(x) all(input$ingredient %in% strsplit(x, ", ")[[1]])), ]
    }
    
    # Filtrer par allergènes à éviter
    if (!is.null(input$allergene) && length(input$allergene) > 0) {
      for (i in input$allergene) {
        filtered_recipes <- filtered_recipes[!grepl(i, filtered_recipes$Ingrédients), ]
      }
    }
    
    # Filtrer par types de recettes
    if (!is.null(input$type_recette) && input$type_recette != "Tous") {
      filtered_recipes <- filtered_recipes[filtered_recipes$Type == input$type_recette, ]
    }
    
    # Filtrer par diète
    if (!is.null(input$regime) && input$regime != "Tous") {
      for (i in input$regime) {
        if (i == "Végétarien") {
          filtered_recipes <- filtered_recipes[!grepl("Viande", filtered_recipes$Type), ]
        }
        if (i == "Végétalien") {
          filtered_recipes <- filtered_recipes[!grepl("Oeufs|Lait|Fromage|Miel", filtered_recipes$Ingrédients), ]
        }
        if (i == "Sans gluten") {
          filtered_recipes <- filtered_recipes[!grepl("Farine|Pâtes|Pain", filtered_recipes$Ingrédients), ]
        }
        if (i == "Cétogène") {
        }
      }
    }
    
    # Filtrer par Temps de préparation
    if (input$duree != "Tous") {
      if (input$duree == "Express (<20 min)") {
        filtered_recipes <- filtered_recipes[grepl("minutes|minute", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 20, ]
      } else if (input$duree == "Rapide (<30 min)") {
        filtered_recipes <- filtered_recipes[grepl("minutes|minute", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 30, ]
      } else if (input$duree == "Normale (<1 heure)") {
        filtered_recipes <- filtered_recipes[grepl("minutes|minute", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 60, ]
      } else if (input$duree == "Longue (<2 heures)") {
        filtered_recipes <- filtered_recipes[grepl("heure|heures", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 2, ]
      }
    }
    
    # par calories
    if (input$calories == "Léger (<200 cal)") {
      filtered_recipes <- filtered_recipes[grepl("cal", filtered_recipes$Calories) & as.numeric(gsub("\\D", "", filtered_recipes$Calories)) < 200, ]
    } else if (input$calories == "Modéré (<500cal)") {
      filtered_recipes <- filtered_recipes[grepl("cal", filtered_recipes$Calories) & as.numeric(gsub("\\D", "", filtered_recipes$Calories)) < 500, ]
    } else if (input$calories == "lourd (>500cal)") {
      filtered_recipes <- filtered_recipes[grepl("cal", filtered_recipes$Calories) & as.numeric(gsub("\\D", "", filtered_recipes$Calories)) > 500, ]
    }
    
    # Filtrer par Origine
    if (!is.null(input$origine) && input$origine != "Tous") {  
      filtered_recipes <- filtered_recipes[filtered_recipes$Origine == input$origine, ]
    }
    
    filtered_recipes
  }
  
  #calcul kcal/j
  observeEvent(input$calculate_button, {
    # Calcul de l'IMC
    bmi <- input$weight / (input$height^2)
    output$bmi_result <- renderText({
      paste("Votre IMC est de ", round(bmi, 2))
    })
    
    # Calcul des besoins caloriques quotidiens
    calories_per_day <- calculate_calories(input$weight, input$height, input$age, input$gender, input$activity_level, input$goal)
    output$calories_result <- renderText({
      paste("Vos besoins caloriques quotidiens sont de ", round(calories_per_day), "kcal")
    })
    
    # Afficher les recommandations en fonction de l'IMC
    output$imc_recommandations <- renderText({
      if (!is.null(input$calculate_button)) {
        bmi <- input$weight / (input$height^2)
        if (!is.na(bmi)) {
          if (bmi < 18.5) {
            return("Votre IMC indique que vous êtes en état de maigreur, ce qui peut être associé à un risque accru de certaines complications de santé. Il est crucial de chercher à atteindre un poids santé de manière saine. Pour ce faire, consultez un professionnel de la santé pour déterminer les causes possibles de votre sous-poids et élaborer un plan adapté pour atteindre un poids santé de façon sécuritaire. En parallèle, adoptez une alimentation équilibrée et nutritive, riche en calories. Privilégiez les aliments densément nutritifs tels que les noix, les graines, les avocats, les produits laitiers, les céréales complètes, les légumineuses et les viandes maigres. Essayez également de manger régulièrement et d'ajouter des collations saines entre les repas pour augmenter votre apport calorique quotidien de manière progressive. Enfin, l'exercice régulier est également important. Il peut vous aider à renforcer vos muscles et à favoriser un gain de poids sous forme de masse musculaire maigre. Optez pour des activités qui vous plaisent et qui peuvent vous aider à atteindre vos objectifs de santé. En suivant ces conseils et en travaillant avec un professionnel de la santé, vous pouvez progressivement atteindre un poids santé tout en améliorant votre bien-être général.")
          } else if (bmi >= 18.5 && bmi < 24.9) {
            return("Votre IMC est dans la plage normale. Choisissez des recettes équilibrées pour maintenir un poids santé. Cependant, il est toujours important de maintenir de saines habitudes de vie pour optimiser votre santé globale. Voici quelques conseils :
Continuez à adopter une alimentation équilibrée comprenant une variété d'aliments nutritifs, notamment des fruits, des légumes, des protéines maigres, des céréales complètes et des graisses saines.
Faites de l'exercice régulièrement en intégrant une combinaison d'activités cardiovasculaires, de renforcement musculaire et de flexibilité pour maintenir votre condition physique.
Surveillez votre poids et votre composition corporelle régulièrement pour détecter tout changement significatif et ajustez votre alimentation et votre exercice en conséquence si nécessaire.")
          } else if (bmi >= 25 && bmi < 29.9) {
            return("Votre IMC indique que vous êtes en surpoids, ce qui peut augmenter le risque de développer certaines maladies chroniques telles que les maladies cardiaques, le diabète de type 2 et l'hypertension. Afin de perdre du poids de manière saine, privilégiez des recettes à faible teneur en calories et riches en nutriments. Pour cela, adoptez une alimentation équilibrée en réduisant votre consommation de calories. Limitez les aliments riches en sucres ajoutés, en graisses saturées et en aliments transformés. De plus, augmentez votre activité physique en intégrant au moins 150 minutes d'exercice modéré à vigoureux par semaine. Cela vous aidera à brûler des calories supplémentaires et à favoriser une perte de poids saine. Enfin, fixez-vous des objectifs réalistes de perte de poids et surveillez votre progression en tenant un journal alimentaire et en suivant vos habitudes d'exercice. En suivant ces conseils, vous pourrez progressivement atteindre un poids santé tout en améliorant votre bien-être général.")
          } else {
            return("Votre IMC indique que vous êtes en situation d'obésité, ce qui peut entraîner un risque significativement accru de divers problèmes de santé graves. Afin d'atteindre un poids santé, il est recommandé de choisir des recettes faibles en calories et riches en fibres. Si votre IMC est de 30 ou plus, il est important de prendre des mesures pour perdre du poids et améliorer votre santé globale. Voici quelques conseils pour vous aider dans ce processus : Consultez un professionnel de la santé pour obtenir une évaluation complète de votre santé et discuter des options de perte de poids adaptées à votre situation spécifique. Suivez un plan alimentaire équilibré et réduit en calories, en vous concentrant sur des aliments riches en nutriments tels que les fruits, les légumes, les protéines maigres et les céréales complètes. Engagez-vous dans une activité physique régulière comprenant à la fois des exercices cardiovasculaires et de renforcement musculaire pour brûler des calories et renforcer votre corps. Envisagez des interventions médicales ou chirurgicales si votre obésité est sévère et si d'autres mesures n'ont pas été efficaces pour atteindre un poids santé. En suivant ces conseils et en bénéficiant d'un suivi médical approprié, vous pourrez progressivement atteindre vos objectifs de poids et améliorer votre bien-être général.")
          }
        }
      }
    })
    
    # Génération du plan de repas
    meal_plan <- data.frame(
      Meal = c("Petit-déjeuner", "Déjeuner", "Dîner"),
      Calories = round(c(0.25, 0.35, 0.35) * calories_per_day)
    )
    
    output$breakfast_calories <- renderText({
      paste("Calories: ", meal_plan$Calories[1])
    })
    
    output$lunch_calories <- renderText({
      paste("Calories: ", meal_plan$Calories[2])
    })
    
    output$dinner_calories <- renderText({
      paste("Calories: ", meal_plan$Calories[3])
    })
  })
}

# Afficher le tableau des recettes
output$recettes_table <- renderDT({
  datatable(
    recettes_filtrées(),  
    selection = "single",  # Permet à l'utilisateur de sélectionner une seule ligne à la fois
    options = list(  
      searching = TRUE,  # Active la barre de recherche
      lengthMenu = list(c(5, 10, 15), c("5", "10", "15")),  # Options de longueur du tableau par page
      scrollY = "600px",  # Hauteur maximale du tableau avec une barre de défilement verticale
      scrollCollapse = TRUE,  # Réduit la hauteur du tableau lorsqu'il y a moins de lignes que la hauteur maximale
      fixedHeader = TRUE,  # Fixe l'en-tête du tableau en haut lors du défilement
      language = list(  # Définit la langue des éléments d'interface utilisateur
        search = "Rechercher :",  # Texte pour la barre de recherche
        lengthMenu = "Afficher _MENU_ recettes par page",  # Texte pour le menu de longueur
        info = "Affichage de _END_ recettes sur _TOTAL_",  # Information sur le nombre d'entrées affichées
        paginate = list(previous = 'Précédent', `next` = 'Suivant'), # Traduction en français des pages
        infoEmpty = "Affichage de 0 recettes",  # Message affiché lorsque le tableau est vide
        infoFiltered = "(filtré à partir de _MAX_ choix)",  # Information sur le nombre de choix possibles filtrés
        zeroRecords = "Aucune recette sous ce nom disponible dans le tableau",  # Message affiché lorsque aucun résultat ne correspond à la recherche
        emptyTable = "Aucune recette disponible dans le tableau",  # Message affiché lorsque le tableau est vide
        first = "Premier",  
        last = "Dernier"  
      )
    )
  )
})

# Afficher une fenêtre détail recette lorsqu'une recette est cliquée
observeEvent(input$recettes_table_rows_selected, {
  selected_row <- input$recettes_table_rows_selected
  if (!is.null(selected_row) && length(selected_row) > 0) {
    showModal(
      modalDialog(
        title = "Détails de la recette",
        HTML(paste0("<h2>Recette : ", recettes_filtrées()$Nom[selected_row], "</h2><p><strong>Type :</strong> ", recettes_filtrées()$Type[selected_row], "</p><p><strong>Ingrédients :</strong> ", recettes_filtrées()$Ingrédients[selected_row], "</p><p><strong>Instructions :</strong> ", recettes_filtrées()$Instructions[selected_row], "</p><p><strong>Temps :</strong> ", recettes_filtrées()$`Temps`[selected_row], "</p><p><strong>Origine :</strong> ", recettes_filtrées()$`Origine`[selected_row])),
        footer = actionButton("close_modal_button", "Fermer", style = "background-color: #3C8DBC; color: white; border: none; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; border-radius: 5px;"),
        easyClose = TRUE
      )
    )
  }
})

# Fermer la fenêtre détail recette
observeEvent(input$close_modal_button, {
  removeModal()
})

De : Maxime DE BONI
Envoyé : vendredi 16 février 2024 09:16
À : Cédric Octave ADECHINA <cadechina@etu.isara.fr>
  Objet : code projet recette

voici le code que j'ai actuellement sur le server, j'essaie d'y relier avec le google docs avec les premieres fonctions et ca veut pas trop :


import gspread
from oauth2client.service_account import ServiceAccountCredentials

# Définir les informations d'identification pour accéder à Google Sheets
scope = ['https://spreadsheets.google.com/feeds', 'https://www.googleapis.com/auth/drive']
creds = ServiceAccountCredentials.from_json_keyfile_name('credentials.json', scope)
client = gspread.authorize(creds)

# Accéder à la feuille de calcul
sheet = client.open('Nom_De_Votre_Feuille_De_Calcul').sheet1

# Obtenir toutes les valeurs de la feuille de calcul
data = sheet.get_all_values()

# Convertir les données en dictionnaire
data_dict = {}
for row in data[1:]:  # Ignorer la première ligne (en-têtes)
  data_dict[row[0]] = {
    recettes$Nom: row[2],
    recette$Type: row[3],
    recettes$Ingrédients : row[4,5,6,7,8],
    recettes$Instructions: row[9],
    recettes$Origine: row[10],
    recettes$Temps: row[11],
    recettes$Calories : row[12],
    recettes$regimes : row [13],
    recettes$Allergene : row [14]
  }



allergenes <- c("Gluten", "Lactose", "Oeufs", "Arachides", "Fruits à coque")
regimes <- c("Tous", "Végétarien", "Végétalien", "Sans gluten", "Cétogène")
types_plat <- c("Tous", "Entrée", "Plat principal", "Dessert", "Apéritif")
durees <- c("Tous", "Express (<20 min)", "Rapide (<30 min)", "Normale (<1 heure)", "Longue (<2 heures)")
origine <- c("Tous", "France", "Italie", "États-Unis", "Inde", "Suisse", "Mexique", "International")
Cal<- c("<200cal","<500cal",">500cal")
liste_pays <- c("Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Côte d'Ivoire", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo (Congo-Brazzaville)", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini (Swaziland)", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Holy See", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar (Burma)", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "North Macedonia (formerly Macedonia)", "Norway", "Oman", "Pakistan", "Palau", "Palestine State", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe")



# Définition de la fonction pour calculer les besoins caloriques quotidiens
calculate_calories <- function(weight_kg, height_m, age, gender, activity_level, goal) {
  bmr <- ifelse(gender == "Homme", 10 * weight_kg + 6.25 * 100 * height_m - 5 * age + 5,
                ifelse(gender == "Femme", 10 * weight_kg + 6.25 * 100 * height_m - 5 * age - 161, NA))
  
  activity_factor <- ifelse(activity_level == 1, 1.2,
                            ifelse(activity_level == 2, 1.4,
                                   ifelse(activity_level == 3, 1.6, NA)))
  
  if (goal == "Maintenir le poids") {
    calories <- bmr * activity_factor
  } else if (goal == "Prendre du poids") {
    calories <- bmr * activity_factor + 350
  } else if (goal == "Prendre de la masse musculaire") {
    calories <- bmr * activity_factor + 300
  } else if (goal == "Perdre du poids") {
    calories <- bmr * activity_factor - 500
  }
  
  return(calories)
}



server <- function(input, output, session) {
  recettes_filtrées <- reactive{
    filtered_recipes <- recettes
    
    # Filtrer par ingrédients sélectionnés
    if (!is.null(input$ingredient) && length(input$ingredient) > 0) {
      filtered_recipes <- filtered_recipes[sapply(filtered_recipes$Ingrédients, function(x) all(input$ingredient %in% strsplit(x, ", ")[[1]])), ]
    }
    
    # Filtrer par allergènes à éviter
    if (!is.null(input$allergene) && length(input$allergene) > 0) {
      for (i in input$allergene) {
        filtered_recipes <- filtered_recipes[!grepl(i, filtered_recipes$Ingrédients), ]
      }
    }
    
    # Filtrer par types de recettes
    if (!is.null(input$type_recette) && input$type_recette != "Tous") {
      filtered_recipes <- filtered_recipes[filtered_recipes$Type == input$type_recette, ]
    }
    
    # Filtrer par diète
    if (!is.null(input$regime) && input$regime != "Tous") {
      for (i in input$regime) {
        if (i == "Végétarien") {
          filtered_recipes <- filtered_recipes[!grepl("Viande", filtered_recipes$Type), ]
        }
        if (i == "Végétalien") {
          filtered_recipes <- filtered_recipes[!grepl("Oeufs|Lait|Fromage|Miel", filtered_recipes$Ingrédients), ]
        }
        if (i == "Sans gluten") {
          filtered_recipes <- filtered_recipes[!grepl("Farine|Pâtes|Pain", filtered_recipes$Ingrédients), ]
        }
        if (i == "Cétogène") {
        }
      }
    }
    
    # Filtrer par Temps de préparation
    if (input$duree != "Tous") {
      if (input$duree == "Express (<20 min)") {
        filtered_recipes <- filtered_recipes[grepl("minutes|minute", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 20, ]
      } else if (input$duree == "Rapide (<30 min)") {
        filtered_recipes <- filtered_recipes[grepl("minutes|minute", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 30, ]
      } else if (input$duree == "Normale (<1 heure)") {
        filtered_recipes <- filtered_recipes[grepl("minutes|minute", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 60, ]
      } else if (input$duree == "Longue (<2 heures)") {
        filtered_recipes <- filtered_recipes[grepl("heure|heures", filtered_recipes$Temps) & as.numeric(gsub("\\D", "", filtered_recipes$Temps)) < 2, ]
      }
    }
    
    # par calories
    if (input$calories == "Léger (<200 cal)") {
      filtered_recipes <- filtered_recipes[grepl("cal", filtered_recipes$Calories) & as.numeric(gsub("\\D", "", filtered_recipes$Calories)) < 200, ]
    } else if (input$calories == "Modéré (<500cal)") {
      filtered_recipes <- filtered_recipes[grepl("cal", filtered_recipes$Calories) & as.numeric(gsub("\\D", "", filtered_recipes$Calories)) < 500, ]
    } else if (input$calories == "lourd (>500cal)") {
      filtered_recipes <- filtered_recipes[grepl("cal", filtered_recipes$Calories) & as.numeric(gsub("\\D", "", filtered_recipes$Calories)) > 500, ]
    }
    
    # Filtrer par Origine
    if (!is.null(input$origine) && input$origine != "Tous") {  
      filtered_recipes <- filtered_recipes[filtered_recipes$Origine == input$origine, ]
    }
    
    filtered_recipes
  }
  
  #calcul kcal/j
  observeEvent(input$calculate_button, {
    # Calcul de l'IMC
    bmi <- input$weight / (input$height^2)
    output$bmi_result <- renderText({
      paste("Votre IMC est de ", round(bmi, 2))
    })
    
    # Calcul des besoins caloriques quotidiens
    calories_per_day <- calculate_calories(input$weight, input$height, input$age, input$gender, input$activity_level, input$goal)
    output$calories_result <- renderText({
      paste("Vos besoins caloriques quotidiens sont de ", round(calories_per_day), "kcal")
    })
    
    # Afficher les recommandations en fonction de l'IMC
    output$imc_recommandations <- renderText({
      if (!is.null(input$calculate_button)) {
        bmi <- input$weight / (input$height^2)
        if (!is.na(bmi)) {
          if (bmi < 18.5) {
            return("Votre IMC indique que vous êtes en état de maigreur, ce qui peut être associé à un risque accru de certaines complications de santé. Il est crucial de chercher à atteindre un poids santé de manière saine. Pour ce faire, consultez un professionnel de la santé pour déterminer les causes possibles de votre sous-poids et élaborer un plan adapté pour atteindre un poids santé de façon sécuritaire. En parallèle, adoptez une alimentation équilibrée et nutritive, riche en calories. Privilégiez les aliments densément nutritifs tels que les noix, les graines, les avocats, les produits laitiers, les céréales complètes, les légumineuses et les viandes maigres. Essayez également de manger régulièrement et d'ajouter des collations saines entre les repas pour augmenter votre apport calorique quotidien de manière progressive. Enfin, l'exercice régulier est également important. Il peut vous aider à renforcer vos muscles et à favoriser un gain de poids sous forme de masse musculaire maigre. Optez pour des activités qui vous plaisent et qui peuvent vous aider à atteindre vos objectifs de santé. En suivant ces conseils et en travaillant avec un professionnel de la santé, vous pouvez progressivement atteindre un poids santé tout en améliorant votre bien-être général.")
          } else if (bmi >= 18.5 && bmi < 24.9) {
            return("Votre IMC est dans la plage normale. Choisissez des recettes équilibrées pour maintenir un poids santé. Cependant, il est toujours important de maintenir de saines habitudes de vie pour optimiser votre santé globale. Voici quelques conseils :
Continuez à adopter une alimentation équilibrée comprenant une variété d'aliments nutritifs, notamment des fruits, des légumes, des protéines maigres, des céréales complètes et des graisses saines.
Faites de l'exercice régulièrement en intégrant une combinaison d'activités cardiovasculaires, de renforcement musculaire et de flexibilité pour maintenir votre condition physique.
Surveillez votre poids et votre composition corporelle régulièrement pour détecter tout changement significatif et ajustez votre alimentation et votre exercice en conséquence si nécessaire.")
          } else if (bmi >= 25 && bmi < 29.9) {
            return("Votre IMC indique que vous êtes en surpoids, ce qui peut augmenter le risque de développer certaines maladies chroniques telles que les maladies cardiaques, le diabète de type 2 et l'hypertension. Afin de perdre du poids de manière saine, privilégiez des recettes à faible teneur en calories et riches en nutriments. Pour cela, adoptez une alimentation équilibrée en réduisant votre consommation de calories. Limitez les aliments riches en sucres ajoutés, en graisses saturées et en aliments transformés. De plus, augmentez votre activité physique en intégrant au moins 150 minutes d'exercice modéré à vigoureux par semaine. Cela vous aidera à brûler des calories supplémentaires et à favoriser une perte de poids saine. Enfin, fixez-vous des objectifs réalistes de perte de poids et surveillez votre progression en tenant un journal alimentaire et en suivant vos habitudes d'exercice. En suivant ces conseils, vous pourrez progressivement atteindre un poids santé tout en améliorant votre bien-être général.")
          } else {
            return("Votre IMC indique que vous êtes en situation d'obésité, ce qui peut entraîner un risque significativement accru de divers problèmes de santé graves. Afin d'atteindre un poids santé, il est recommandé de choisir des recettes faibles en calories et riches en fibres. Si votre IMC est de 30 ou plus, il est important de prendre des mesures pour perdre du poids et améliorer votre santé globale. Voici quelques conseils pour vous aider dans ce processus : Consultez un professionnel de la santé pour obtenir une évaluation complète de votre santé et discuter des options de perte de poids adaptées à votre situation spécifique. Suivez un plan alimentaire équilibré et réduit en calories, en vous concentrant sur des aliments riches en nutriments tels que les fruits, les légumes, les protéines maigres et les céréales complètes. Engagez-vous dans une activité physique régulière comprenant à la fois des exercices cardiovasculaires et de renforcement musculaire pour brûler des calories et renforcer votre corps. Envisagez des interventions médicales ou chirurgicales si votre obésité est sévère et si d'autres mesures n'ont pas été efficaces pour atteindre un poids santé. En suivant ces conseils et en bénéficiant d'un suivi médical approprié, vous pourrez progressivement atteindre vos objectifs de poids et améliorer votre bien-être général.")
          }
        }
      }
    })
    
    # Génération du plan de repas
    meal_plan <- data.frame(
      Meal = c("Petit-déjeuner", "Déjeuner", "Dîner"),
      Calories = round(c(0.25, 0.35, 0.35) * calories_per_day)
    )
    
    output$breakfast_calories <- renderText({
      paste("Calories: ", meal_plan$Calories[1])
    })
    
    output$lunch_calories <- renderText({
      paste("Calories: ", meal_plan$Calories[2])
    })
    
    output$dinner_calories <- renderText({
      paste("Calories: ", meal_plan$Calories[3])
    })
  })
}

# Afficher le tableau des recettes
output$recettes_table <- renderDT({
  datatable(
    recettes_filtrées(),  
    selection = "single",  # Permet à l'utilisateur de sélectionner une seule ligne à la fois
    options = list(  
      searching = TRUE,  # Active la barre de recherche
      lengthMenu = list(c(5, 10, 15), c("5", "10", "15")),  # Options de longueur du tableau par page
      scrollY = "600px",  # Hauteur maximale du tableau avec une barre de défilement verticale
      scrollCollapse = TRUE,  # Réduit la hauteur du tableau lorsqu'il y a moins de lignes que la hauteur maximale
      fixedHeader = TRUE,  # Fixe l'en-tête du tableau en haut lors du défilement
      language = list(  # Définit la langue des éléments d'interface utilisateur
        search = "Rechercher :",  # Texte pour la barre de recherche
        lengthMenu = "Afficher _MENU_ recettes par page",  # Texte pour le menu de longueur
        info = "Affichage de _END_ recettes sur _TOTAL_",  # Information sur le nombre d'entrées affichées
        paginate = list(previous = 'Précédent', `next` = 'Suivant'), # Traduction en français des pages
        infoEmpty = "Affichage de 0 recettes",  # Message affiché lorsque le tableau est vide
        infoFiltered = "(filtré à partir de _MAX_ choix)",  # Information sur le nombre de choix possibles filtrés
        zeroRecords = "Aucune recette sous ce nom disponible dans le tableau",  # Message affiché lorsque aucun résultat ne correspond à la recherche
        emptyTable = "Aucune recette disponible dans le tableau",  # Message affiché lorsque le tableau est vide
        first = "Premier",  
        last = "Dernier"  
      )
    )
  )
})

# Afficher une fenêtre détail recette lorsqu'une recette est cliquée
observeEvent(input$recettes_table_rows_selected, {
  selected_row <- input$recettes_table_rows_selected
  if (!is.null(selected_row) && length(selected_row) > 0) {
    showModal(
      modalDialog(
        title = "Détails de la recette",
        HTML(paste0("<h2>Recette : ", recettes_filtrées()$Nom[selected_row], "</h2><p><strong>Type :</strong> ", recettes_filtrées()$Type[selected_row], "</p><p><strong>Ingrédients :</strong> ", recettes_filtrées()$Ingrédients[selected_row], "</p><p><strong>Instructions :</strong> ", recettes_filtrées()$Instructions[selected_row], "</p><p><strong>Temps :</strong> ", recettes_filtrées()$`Temps`[selected_row], "</p><p><strong>Origine :</strong> ", recettes_filtrées()$`Origine`[selected_row])),
        footer = actionButton("close_modal_button", "Fermer", style = "background-color: #3C8DBC; color: white; border: none; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; border-radius: 5px;"),
        easyClose = TRUE
      )
    )
  }
})

# Fermer la fenêtre détail recette
observeEvent(input$close_modal_button, {
  removeModal()
})




