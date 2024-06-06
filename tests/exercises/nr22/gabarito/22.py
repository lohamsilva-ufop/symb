#22) A CEF concederá um crédito especial com juros de 2% aos seus clientes de acordo com o saldo médio no último ano. 
#Fazer um programa que leia o saldo médio de um cliente e calcule o valor do crédito de acordo com a tabela a seguir. 
#Imprimir uma mensagem informando o saldo médio e o valor de crédito. 

#Saldo Médio               Percentual
#De 0 a 500 ...............Nenhum crédito
#De 501 a 1000 ............30% do valor do saldo médio
#De 1001 a 3000 ...........40% do valor do saldo médio
#Acima de 3001 ............50% do valor do saldo médio

saldomedio = input("Digite o saldo medio: ")

if saldomedio >= 0 and saldomedio <= 500 :
   print ("Nenhum crédito")
elif saldomedio >= 501 and saldomedio <= 1000 :
    print ("Saldo medio: ", saldomedio)
    print ("Crédito: ", saldomedio * 0.3)
elif saldomedio >= 1001 and saldomedio <= 3000 :
    print ("Saldo medio: ", saldomedio)
    print ("Crédito: ", saldomedio * 0.4)
else :
    if saldomedio >= 3001 :
        print ("Saldo medio: ", saldomedio)
        print ("Crédito: ", saldomedio * 0.5)
   
