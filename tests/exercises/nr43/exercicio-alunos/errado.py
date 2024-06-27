#43) Escreva um programa que leia um peso na Terra e o número de um planeta e imprima
#o valor do seu peso neste planeta. A relação de planetas é dada a seguir juntamente
#com o valor das gravidades relativas á Terra:

#1 0,37 Mercúrio
#2 0,88 Vênus
#3 0,38 Marte
#4 2,64 Júpiter
#5 1,15 Saturno
#6 1,17 Urano 

peso = input("Digite seu peso: ")
planeta = input("Digite a numero do planeta: ")


if planeta != 1:
    print ("Seu peso em Mercurio: ", peso * 0.37)
elif planeta == 2:
    print ("Seu peso em Vênus: ", peso * 0.88)
elif planeta == 3:
    print ("Seu peso em Marte: ", peso * 0.38)
elif planeta == 4:
    print ("Seu peso em Júpiter: ", peso * 2.64)
elif planeta == 5:
    print ("Seu peso em Saturno: ", peso * 1.15)
elif planeta == 6:
    print ("Seu peso em Urano: ", peso * 1.17)
else:
    print ("Planeta fora do escopo. Digite uma opcao entre 1 a 6. ")