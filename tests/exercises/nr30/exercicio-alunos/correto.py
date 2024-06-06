#30)Dado três valores, A, B e C, construa um programa para verificar se estes valores
#podem ser valores dos lados de um triângulo, e se for, se é um triangulo escaleno, um
#triangulo eqüilátero ou um triangulo isósceles. 


A = input("Digite o primeiro lado do triangulo: ")
B = input("Digite o segundo lado do triangulo: ")
C = input("Digite o terceiro lado do triangulo: ")

if A + B + C == 180 :
    if A != B and B != C and C != A :
        print ("O triangulo é escaleno")
    else:
        if A == B or B == C or A == C :
            print ("O triangulo é isósceles")
else :
    print ("Não São valores dos lados de um triângulo")
   
   
   