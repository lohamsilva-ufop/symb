#31) Dados três valores A, B e C, construa um programa para verificar se estes valores
#podem ser valores dos lados de um triângulo, e se for, classificá-los (imprimi-los)
#segundo os ângulos. (Triângulo Retângulo = 90º, Triângulo Obtusângulo > 90º ,
#Triângulo Acutângulo < 90º) . 


A = input("Digite o primeiro lado do triangulo: ")
B = input("Digite o segundo lado do triangulo: ")
C = input("Digite o terceiro lado do triangulo: ")

if A + B + C == 180 :
    if A == 90 or B == 90 or C == 90:
        print("Triângulo Retângulo")
    elif A > 90 or B > 90 or C > 90:
        print("Triângulo Obtusângulo")
    else:
        print("Triângulo Acutângulo")
else:
    print ("Não é um triângulo")
   
   
   