#lang interp-imp/python/plugin

numero1 = input("Digite o primeiro numero: ")
numero2 = input("Digite o segundo numero: ")

if numero1 > numero2 :{
   print ("Raiz quadrada do maior numero:" )
   print (math.sqrt(numero1))
} elif numero2 > numero1 :{
   print ("Raiz quadrada do maior numero:" )
   print (math.sqrt(numero2))
} elif numero1 < numero2 :{
   print ("Quadrado do menor numero:" )                                     
   print (numero1*numero1)
} else:{
   print ("Quadrado do menor numero:" )   
   print (numero2*numero2)}