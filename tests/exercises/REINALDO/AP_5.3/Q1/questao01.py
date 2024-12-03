def imprimeRetangulo(alt, larg):
    for i in range(alt):
        for j in range(larg):
            print('*', end='')
        print()  # (quebra de linha)


continuar = input("Informe se deseja imprimir um retângulo (s/n):")

while continuar == "s":
    # Lendo o valor do lado
    a = int(input("\nInforme a altura do retângulo: "))
    l = int(input("Informe a largura do retângulo: "))
    # Relendo valores de x e y até que eles sejam válidos
    while a <= 0 or l <= 0 or a >= l:
        print('Entrada inválida.\n')
        a = int(input("Informe a altura do retângulo: "))
        l = int(input("Informe a largura do retângulo: "))

    print()  # (linha em branco para saída ficar idêntica)

    imprimeRetangulo(a, l)

    print()
    continuar = input("Informe se deseja imprimir outro retângulo (s/n):")
