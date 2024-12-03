H = float(input('Digite a altura: '))
sexo = input('Digite o sexo (m ou f): ')
if sexo == 'm':
    ideal = 72.7 * H - 58
else:
    ideal = 62.1 * H - 44.7
print("O peso ideal é ", ideal)