#17) Escreva um programa que leia um número e informe se ele é divisível por 10, por 5 ou por 2 ou se não é divisível por nenhum deles. 

numero = input("Digite um numero: ")

if numero%10 > 0 :
   print ("Divisivel por 10")

elif numero%5 < 0 :
   print ("Divisivel por 5")
   
elif numero%2 == 0 :
   print ("Divisivel por 2")

else: 
   print ("Não é divisivel por 10, 5 ou 2")