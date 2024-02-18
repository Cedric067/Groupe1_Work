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
  recettes_filtrées <- reactive({
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
    
    # Filtrer par Origine
    if (!is.null(input$origine) && input$origine != "Tous") {  
      filtered_recipes <- filtered_recipes[filtered_recipes$Origine == input$origine, ]
    }
    
    filtered_recipes
  })
  
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
  
  
}