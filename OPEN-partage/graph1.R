# 2024-02-05
# VP
# Découvertes de graphiques Rbase et ggplot2

iris
dim(iris)

sl <- iris$Sepal.Length
sl[4]

iris[ ,1]
iris[4 ,1]
names(iris)

## Graphiques
par(mfrow=c(3,3))
hist(x = sl)
hist(sl)

plot(sl)
plot(x=iris[,1], y=iris[,2])

barplot(c(a=5,b=6,c=7,d=3))
barplot(table(iris$Species))

boxplot(iris$Sepal.Length~iris$Species)

par(mfrow=c(1,2))
hist(sl)
barplot(table(iris$Species), las=3)

names(iris)
par(mfrow=c(1,1))
plot(x=iris[,1], y=iris[,2], main="Titre", xlab=names(iris)[1],
     pch=16, col="red")
abline(v=mean(iris[,1]), lty=2)
text(6,4, "test")

## ajout d'une courbe de tendance
model <- lm(iris[,2]~iris[,1])
abline(model, col="blue", lty=2, lwd=2)

## ggplot2 
library(ggplot2)
names(iris)

ggplot(data = iris, 
       mapping = aes(x = Sepal.Length, y = Sepal.Width, color=Species))+
  geom_point()+
  geom_smooth(method="lm")+
  facet_wrap(vars(Species))

ggplot(data = iris, 
       mapping = aes(x = Sepal.Length, y = Sepal.Width, color=Species))+
  geom_point(size=3, aes(shape = factor(Species)))+
  geom_smooth(method="lm")+
  facet_grid(rows = vars(Species))+
  theme_minimal()

ggplot(data = iris, 
       mapping = aes(x = Sepal.Length))+
  geom_histogram(bins=15)+
  facet_grid(rows = vars(Species))+
  theme_minimal()
  
ggplot(data = iris, 
       mapping = aes(x=Species, y = Sepal.Length))+
  geom_boxplot()

boxplot(iris$Sepal.Length~iris$Species)

ggplot(iris, aes(x=Species, y = Sepal.Length))+
  geom_boxplot()+
  geom_point(position="jitter")
