#5) Construir um programa que leia dois números e efetue a adição. Caso o valor somado seja maior que 20, 
#este deverá ser apresentado somando-se a ele mais 8; caso o valor
#somado seja menor ou igual a 20, este deverá ser apresentado subtraindo-se 5

numero1 = input("Insira um valor para o primeiro numero: ")
numero2 = input("Insira um valor para o segundo numero: ")
adicao = numero1 + numero2

if adicao > 20 :
    print (adicao + 8)
else:
    print (adicao - 5)  