---
  title: "ggplot"
author: "Cédric Octave ADECHINA"
date: "2024-02-06"
---


library(ggplot2)
library(dplyr)
data("starwars")
names(starwars)

ggplot(starwars)
p <- ggplot(data = starwars, aes(x = height, y = mass))
p <- p + geom_point()
p <- p + aes(color = sex)
p <- p + labs(title = "Relation entre la taille et la masse des personnages de Star Wars",
              x = "Taille (cm)",
              y = "Masse (kg)",
              color = "Sexe")

# Afficher le graphique
print(p)

# Reduction taille echelles
p <- p + scale_x_continuous(limits = c(0, 250)) + scale_y_continuous(limits = c(0, 250))

# Afficher le graphique
print(p)

# ligne de meilleur ajustement
ggplot(
  data = starwars,
  mapping = aes(x = height, y = mass, color = sex)
) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_continuous(limits = c(0, 250)) +
  scale_y_continuous(limits = c(0, 250))

# ligne de regression lineaire
ggplot(
  data = starwars,
  mapping = aes(x = height, y = mass, color = sex)
) +
  geom_point() +
  geom_smooth(se = FALSE)+
  scale_x_continuous(limits = c(0, 250)) +
  scale_y_continuous(limits = c(0, 250))

# Visualisation dustribution 
ggplot(
  data = starwars,
  mapping = aes(x = height, y = mass, color = sex)
) +
  geom_point() +
  geom_dotplot(binwidth = 5, aes(y = ..count..)) + 
  geom_smooth(method = "loess", se = FALSE) + 
  scale_x_continuous(limits = c(0, 250)) +
  scale_y_continuous(limits = c(0, 250))

# Densité

# Supprimer les lignes avec des valeurs manquantes
starwars <- na.omit(starwars)

# Visualisation avec ggplot2
ggplot(data = starwars, aes(x = height, color = sex, fill = sex)) +
  geom_density(alpha = 0.5) +
  labs(title = "Densité de la taille des personnages de Star Wars par sexe",
       x = "Taille (cm)",
       y = "Densité") +
  scale_fill_manual(values = c("blue", "pink")) +
  scale_color_manual(values = c("blue", "pink"))

# sous-graphique pour chaque planète d'origine, montrant la relation entre la taille et la masse des personnages spécifiques à cette planète.
ggplot(data = starwars, aes(x = height, y = mass)) +
  geom_point(aes(color = sex, shape = sex)) +
  facet_wrap(~homeworld) +
  labs(title = "Relation entre la taille et la masse des personnages de Star Wars",
       x = "Taille (cm)",
       y = "Masse (kg)") +
  scale_color_manual(values = c("blue", "pink")) +
  scale_shape_manual(values = c(16, 17)) # 16: cercle, 17: losange

ggplot(data = starwars, aes(x = height, y = mass)) +
  geom_point(aes(color = sex, shape = sex)) +
  geom_label(aes(label = name), vjust = 1.5, hjust = 0.5, size = 3) +
  facet_wrap(~homeworld) +
  labs(title = "Relation entre la taille et la masse des personnages de Star Wars",
       x = "Taille (cm)",
       y = "Masse (kg)") +
  scale_color_manual(values = c("blue", "pink")) +
  scale_shape_manual(values = c(16, 17)) # 16: cercle, 17: losange

