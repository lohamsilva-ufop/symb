#21) Construa um programa para determinar se o indivíduo esta com um peso favorável.
#Essa situação é determinada através do IMC (Índice de Massa Corpórea), que é
#definida como sendo a relação entre o peso (PESO) e o quadrado da Altura (ALTURA) do indivíduo. Ou seja, 
#IMC = Peso / Altura ^2 e, a situação do peso é determinada pela tabela abaixo:
#Condição Situação
#IMC abaixo de 20 Abaixo do peso
#IMC de 20 até 25 Peso Normal
#IMC de 25 até 30 Sobre Peso
#IMC de 30 até 40 Obeso
#IMC de 40 e acima Obeso Mórbido

peso = input("Digite o peso: ")
altura = input("Digite a altura: ")
quadrado = altura * altura
imc = peso / quadrado 

if imc < 20 :
   print ("Abaixo do peso")
elif imc >= 20 and imc < 25 :
    print ("Peso normal")
elif imc >= 25 and imc < 30 :
    print ("Sobre Peso")
elif imc >= 30 and imc < 40 :
    print ("Obeso")
else:
    print ("Obeso Mórbido")
   
