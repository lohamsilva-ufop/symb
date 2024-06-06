#25) A confederação brasileira de natação irá promover eliminatórias para o próximo
#mundial. Fazer um programa que receba a idade de um nadador e determine (imprima)
#a sua categoria segundo a tabela a seguir:
#Categoria Idade
#Infantil A 5 – 7 anos
#Infantil B 8 – 10 anos
#Juvenil A 11 – 13 anos
#Juvenil B 14 – 17 anos
#Sênior Maiores de 18 anos

idade = input("Digite a idade: ")

if idade >= 5 and idade <= 7 :
   print ("Infantil A")
elif idade >= 8 and idade <= 10 :
    print ("Infantil B")
elif idade >= 11 and idade <= 13 :
    print ("Juvenil A")
elif idade >= 14 and idade <= 17 :
    print ("Juvenil B")
else :
    if idade >= 18 :
        print ("Sênior")
   
   