#lang interp-imp/python/z3/testz3

numero = input("Digite um numero: ")
multiplo = numero%3

if multiplo == 0:{
   print("É multiplo de 3")
} else:{
   print("Não é multiplo de 3")
}