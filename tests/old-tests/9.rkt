#lang interp-imp/python/z3/testz3

A = input("Digite o valor A: ")
B = input("Digite o valor B: ")
divisivel = A%B

if divisivel == 0:{
   print("A é divisivel por B")
} else:{
   print("A não é divisivel por B")
}