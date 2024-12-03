def ValorProporcional(Q, P):
    V = Q * P / 100
    return round(V)

qtdF = int(input('Informe a quantidade de mulheres: '))
qtdM = int(input('Informe a quantidade de homens: '))
vegF = ValorProporcional(qtdF, 20)
vegM = ValorProporcional(qtdM, 10)
print(f'{vegF} alunas preferem refeição vegetariana.')
print(f'{vegM} alunos preferem refeição vegetariana.')
print(f'A porcentagem de estudantes que preferem refeição vegetariana é {(vegF+vegM)/(qtdF+qtdM)*100:.1f}%.')