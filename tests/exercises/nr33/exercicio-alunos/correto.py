#33) Criar um programa que receba o valor de x, e calcule e imprima o valor de f(x).
# 1, se x <= 1
# 2, se 1 < x <= 2
# x^2, se 2 < x <= 3
# x^3, se x > 3

import math

x = input("Insira o valor de x: ")

if x <= 1 :
    print ("1")
else:
    if x > 1 and x <= 2:
        print ("2")
    elif x > 2 and x <= 3:
        print (pow(x,2))
    else:
        print (pow(x, 3))
   
   
   