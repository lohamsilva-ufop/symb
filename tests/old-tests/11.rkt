#lang interp-imp/python/z3/testz3

numero = input("Digite um numero: ")
divide3 = numero%3
divide7 = numero%7

if divide3 == 0 and divide7 == 0 :{
   print("É divisível por 3 e 7")
} else:{
   print("Não é divisível por 3 e 7")
}