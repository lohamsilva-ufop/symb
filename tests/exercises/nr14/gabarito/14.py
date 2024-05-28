#14) Dados três valores A, B e C, construa um programa, que imprima os valores de forma ascendente (do menor para o maior). 

A = input("Digite o valor A: ")
B = input("Digite o valor B: ")
C = input("Digite o valor C: ")


if A > B and A > C :
   print ("O maior valor e: " , A)
else:
   if B > A and B > C :
      print ("O maior valor e: " , B)
   else :
      print ("O maior valor e: " , C)
