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

recettes <- read.csv("recettes.csv", sep=";")
  
  
#stringsAsFactors = FALSE


allergenes <- c("Gluten", "Lactose", "Oeufs", "Arachides", "Fruits à coque")
regimes <- c("Tous", "Végétarien", "Végétalien", "Sans gluten", "Cétogène")
types_plat <- c("Tous", "Entrée", "Plat principal", "Dessert", "Apéritif")
durees <- c("Tous", "Express (<20 min)", "Rapide (<30 min)", "Normale (<1 heure)", "Longue (<2 heures)")
origine <- c("Tous", "France", "Italie", "États-Unis", "Inde", "Suisse", "Mexique", "International")



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
    
    # Affichage du graphique IMC
    output$imc_plot <- renderPlot({
      # Définition des valeurs d'IMC et des catégories associées
      imc_values <- c(10, 18.5, 24.9, 29.9, 34.9, 39.9, 60)
      
      # Calcul des valeurs moyennes des plages
      mid_values <- c(14.25, 21.7, 27.4, 32.4, 37.4, 49.95)
      
      # Création du graphique
      plot(imc_values, rep(1, length(imc_values)), type = "n", xlab = "IMC", ylab = "", xlim = c(10, 60), ylim = c(0, 2), yaxt = "n", xaxt = "n", bty = "n")
      axis(1, at = imc_values, labels = imc_values)
      axis(2, at = 1, labels = "", lwd = 0)
      
      # Ajout de couleurs pour les plages d'IMC
      rect(10, 0.5, 18.5, 2, col = rgb(0, 1, 0, 0.3), border = NA) # Poids insuffisant
      rect(18.5, 0.5, 24.9, 2, col = rgb(1, 1, 0, 0.3), border = NA) # Poids normal
      rect(24.9, 0.5, 29.9, 2, col = rgb(1, 0.5, 0, 0.3), border = NA) # Surpoids
      rect(29.9, 0.5, 34.9, 2, col = rgb(1, 0, 0, 0.3), border = NA) # Obésité modérée
      rect(34.9, 0.5, 39.9, 2, col = rgb(0.5, 0, 0, 0.3), border = NA) # Obésité sévère
      rect(39.9, 0.5, 60, 2, col = rgb(0, 0, 0, 0.3), border = NA) # Obésité morbide
      
      # Ajout de textes
      text(mid_values, rep(1.2, length(mid_values)), c("Poids insuffisant", "Poids normal", "Surpoids", "Obésité modérée", "Obésité sévère", "Obésité morbide"), cex = 1, col = "black", pos = 3)
      
      # Ajout d'une flèche représentant l'IMC de l'utilisateur
      if (bmi < 10) {
        text(11, 1.7, "← ", col = "blue", cex = 2)
        text(11, 1.8, "Votre IMC", col = "blue")
      } else if (bmi > 60) {
        text(59, 1.7, "→", col = "blue", cex = 2)
        text(59, 1.8, "Votre IMC", col = "blue")
      } else {
        segments(bmi, 1.5, bmi, 1.9, col = "blue", lwd = 3)
        text(bmi, 1.95, "Votre IMC", col = "blue")
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
  
  # Action pour diriger l'utilisateur vers un autre onglet
  observeEvent(input$bouton, {
    updateTabItems(session, "tabs", "filter_recipes")
  })
  
  # Action pour diriger l'utilisateur vers un autre onglet
  observeEvent(input$bouton2, {
    updateTabItems(session, "tabs", "aides")
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