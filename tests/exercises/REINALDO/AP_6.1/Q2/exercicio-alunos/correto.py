# programa principal
qtd = int(input('Digite a quantidade de percursos: '))
for p in range(qtd):
    print("Percurso ", p+1, ": ")
    M = float(input('  - Digite o tamanho em metros: '))
    FT = 0.3048 * M
    YD = 0.9144 * M
    print("  - Tamanho em pés...: ", FT)
    print("  - Tamanho em jardas: ", YD)