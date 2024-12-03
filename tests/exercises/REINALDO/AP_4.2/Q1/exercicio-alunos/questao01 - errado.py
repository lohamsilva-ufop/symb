C = float(input('Informe o capital emprestado: '))
m = int(input('Informe a quantidade de meses para quitação: '))

if C >= 10000:
    j = 0.1
else:
    j = 0.07
    
J = C * j * m

print("Taxa de juros aplicada: ", j*0.01)
print("Juros devido: ", J)
print("Valor total: ", C+J)
