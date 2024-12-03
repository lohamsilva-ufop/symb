def calculaJ(C, m):
    if C <= 10000:
        j = 0.1
    else:
        j = 0.07
    J = C * j * m
    return J, int(j * 100)

T = float(input('Forneça o capital Total para empréstimo: '))
C = float(input('Forneça o capital emprestado: '))
while C <= T:
    m = int(input('Forneça a quantidade de meses para quitação: '))
    J, j = calculaJ(C, m)
    print(f'Taxa de juros aplicada: {j:.0f}%.')
    print(f'Juros devido: {J:.2f}.')
    print(f'Valor total: {C+J:.2f}.')
    T = T - C
    C = float(input('Forneça o capital emprestado: '))
print(f'Empréstimo negado, capital total é de R$ {T:.2f}.')
