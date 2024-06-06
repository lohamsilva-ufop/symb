#27) Escreva um programa que leia as duas notas bimestrais de um aluno e determine a
#média das notas semestral. Usando a média calculada, o programa deve imprimir a
#seguinte mensagem: “Aprovado”, “Reprovado” ou em “Exame” (a média é 7 para
#Aprovação, menor que 3 para Reprovação e as demais em Exame).


nota1 = input("Digite a nota 1: ")
nota2 = input("Digite a nota 2: ")
media = nota1 + nota2 / 2

if media >= 7 :
   print ("Aprovado")
elif media <= 3 :
    print ("Reprovado")
else :
    print ("Exame")
   
   
