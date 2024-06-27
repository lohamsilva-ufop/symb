#37) Criar um programa que a partir da idade e peso do paciente calcule a dosagem de
#determinado medicamento e imprima a receita informando quantas gotas do
#medicamento o paciente deve tomar por dose. Considere que o medicamento em
#questão possui 500 mg por ml, e que cada ml corresponde a 20 gotas.

#- Adultos ou adolescentes desde 12 anos, inclusive, se tiverem peso igual ou
#acima de 60 quilos devem tomar 1000 mg; com peso abaixo de 60 quilos
#devem tomar 875 mg.

#- Para crianças e adolescentes abaixo de 12 anos a dosagem é calculada pelo
#peso corpóreo conforme a tabela a seguir:

#5 kg a 9 kg - 125 mg
#9.1 kg a 16 kg - 250 mg
#16.1 kg a 24 kg - 375 mg
#24.1 kg a 30 kg - 500 mg
#Acima de 30 kg - 750 mg 

idade = input("Digite sua idade: ")
peso = input("Digite seu peso: ")

if idade >= 12 :
    if peso >= 60:
        ml = 1000/500
        gotas = ml * 20
        print (gotas," gotas")
    else:
        ml = 875/500
        gotas = ml * 20
        print (gotas," gotas")
else:
    if peso >= 5 and peso <= 9 :
        ml = 125/500
        gotas = ml * 20
        print (gotas," gotas")
    elif peso > 9 and peso <= 16 :
        ml = 250/500
        gotas = ml * 20
        print (gotas," gotas")
    elif peso > 16 and peso <= 24 :
        ml = 375/500
        gotas = ml * 20
        print (gotas," gotas")
    elif peso > 24 and peso <= 30 :
        ml = 500/500
        gotas = ml * 20
        print (gotas," gotas")
    else:
        if peso > 30 :
            ml = 750/500
            gotas = ml * 20
            print (gotas," gotas")
        
    
