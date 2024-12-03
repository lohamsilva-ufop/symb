morango = float(input('Digite a quantidade de Morangos (em kg): '))
maca = float(input('Digite a quantidade de Maçãs (em kg): '))

if morango < 0 or maca < 0:
    print('Entrada inválida')
else:
    if morango <= 5:
        precoMorango = 2.5
    else:
        precoMorango = 2.2
    if maca <= 5:
        precoMaca = 1.8
    else:
        precoMaca = 1.5
    total = morango * precoMorango + maca * precoMaca
    print("O valor total da sua compra é R$ ",total)
