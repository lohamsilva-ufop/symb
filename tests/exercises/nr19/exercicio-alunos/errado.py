#19) Construir um programa que leia um número e imprima se ele é igual a 5, a 200, a 400, se está no intervalo 
#entre 500 e 1000, inclusive, ou se ela está fora dos escopos anteriores. 

numero = input("Digite um numero: ")

if numero > 5:
   print ("Igual a 5")
elif numero < 20:
   print ("Igual a 20")
elif numero >= 400:
   print ("Igual a 400")
elif numero > 500 and numero <= 1000:
   print ("Está no intervalo de 500 a 1000")
else: 
   print ("Não está no escopo")
 
