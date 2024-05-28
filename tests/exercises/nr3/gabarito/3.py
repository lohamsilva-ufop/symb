#3) Construa um programa que determine (imprima) se um dado número N inteiro (recebido através do teclado) é PAR ou ÍMPAR. 

numero = input("Insira um valor")
resto = numero % 2

if resto == 0 :
    print ("O numero é par")
else:
    print ("O numero é impar")
