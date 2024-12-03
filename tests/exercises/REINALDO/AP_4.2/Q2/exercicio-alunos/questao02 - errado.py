# Entrada
peso = float(input('Digite seu peso (em kg): '))
altura = float(input('Digite sua altura (em metros): '))
sexo = input('Seu sexo é masculino (M) ou feminino (F)? ')

# Cálculo do IMC
imc = peso / altura ** 2

# Se sexo for masculino...
if sexo == 'M':
    if imc >= 25:
        print('Você não precisa perder peso para ter IMC <= 25')
    else:
        dif_peso = peso - 25 * altura ** 2
        print("Você deve perder ", dif_peso , "kg para ter IMC = 25")
# Se sexo for feminino...
else:
    if sexo == 'F':
        if imc >= 24:
            print('Você não precisa perder peso para ter IMC <= 24')
        else:
            dif_peso = peso - 24 * altura ** 2
            print("Você deve perder ", dif_peso , "kg para ter IMC = 24")
    else:
        print("A entrada contém dados não reconhecidos")
