def impostoRenda(bruto):
    if bruto <= 1500:
        ir = 0
    elif bruto <= 2500:
        ir = 0.05
    elif bruto <= 4500:
        ir = 0.1
    else:
        ir = 0.2
    return bruto * ir

bruto = float(input('Digite o salário bruto: '))
ir = impostoRenda(bruto)
inss = 0.1 * bruto
liquido = bruto - ir - inss
print(f'(-)IR: R$ {ir:.2f}')
print(f'(-)INSS: R$ {inss:.2f}')
print(f'FGTS: R$ {0.11 * bruto:.2f}')
print(f'Total de descontos: R$ {ir+inss:.2f}')
print(f'Salário Líquido: R$ {liquido:.2f}')
