#lang interp-imp/python/z3/testz3

numero = input("Digite um numero: ")

if numero >= 0:{
   print(math.sqrt(numero))
} else:{
        print (numero*numero)
}