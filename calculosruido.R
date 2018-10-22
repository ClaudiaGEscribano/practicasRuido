##setwd("/home/kike/Escritorio/Dropbox/docencia/ryr/2018_2019/practicas/")
install.packages("gdata")
## require("gdata")
## ll1<-read.csv(file="lun_cuba_10min.csv", header=FALSE, skip=2)

## ________________________________________________________________

## 2. Lee el fichero excel de datos y crea un objeto para operar en R.

rlun<-read.xls("lun_cuba_10min.xls",header=FALSE)

## Para poder ver qué cómo es el objeto rlun, debo llamarlo en la consola:
rlun
## si el fichero es muy grande, es preferible mirar el encabezado:
head(rlun)
## En alguna ocasión puede sernos de utilidad observar el final del objeto (matriz, vector, data.frame):
tail(rlun)

## Asigno los nombres a las columnas del 'data.frame'.
colnames(rlun) <- c("time", "intensidad")

## __________________________________________________________________

## 3. Represento los datos:
## Como es una serie temporal, puedo utilizar la siguiente función:
## ts.plot(ll1[2])

ts.plot(rlun[2], type='o', ylab='intensidad')

## La función ts.plot considera el que el argumento que se le introduce es una series temporal y lo representa como tal.
## Esta función acepta como argumentos 'type' para cambiar el tipo de representación y distintos argumentos para insertar el título y el nombre en los ejes.

## 3.2 Puedo utilizar también la funcín 'plot' del base de R.
## En este caso, tengo que indicar los valores de x e y que quiero representar.

plot(rlun[1:144,2], type='b')
##plot(ll1[1:144,2], type='b')

## __________________________________________________________________

## 4. 
t1<-10^(rlun[2]/10)
deltat<-10.
#Leqdiario
t2<-sum(deltat*t1)
leqlunes<-10*log10(1/(60*24)*t2)
# Leq diurno: 43 a 114, de 7 a 19h: 12h
# Leq tarde: 115 a 138:  19 a 23: 4 h
# Leq nocturno: 1 a 42 y 139 a 144: 0 a 7 y 23 a 24: 8h
t1d<-10^(rlun[43:114,2]/10)
t2d<-sum(deltat*t1d)
leqdlunes<-10*log10(1/(60*12)*t2d)
t1t<-10^(rlun[115:138,2]/10)
t2t<-sum(deltat*t1t)
leqtlunes<-10*log10(1/(60*4)*t2t)
t1n1<-10^(rlun[1:42,2]/10)
t1n2<-10^(rlun[139:144,2]/10)
t2n<-sum(deltat*t1n1)+sum(deltat*t1n2)
leqnlunes<-10*log10(1/(60*8)*t2n)

ttd=10^(leqdlunes/10)
ttt=10^((leqtlunes+5)/10)
ttn=10^((leqnlunes+10)/10)
ldn=10*log10((12*ttd+4*ttt+8*ttn)/24)

rlunesp90<-quantile(rlun[,2],0.9)
rlunesp10<-quantile(rlun[,2],0.1)
tni<-4*(rlunesp90-rlunesp10)+rlunesp10-30
