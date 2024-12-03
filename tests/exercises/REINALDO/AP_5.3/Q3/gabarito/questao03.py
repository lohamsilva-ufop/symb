print('Caixa aberto!')
fechar = 'não'
totalGeral = 0
qtdPedidos = 0
while fechar != 'sim':
    totalPedido = 0
    numItems = int(input('\nDefina a quantidade de itens do pedido: '))
    for i in range(numItems):
        preco = float(input(f'. Defina o preço do item {i+1}: '))
        totalPedido = totalPedido + preco
    entrega = input('. Defina a cobrança do delivery: ')
    if entrega == 'sim':
        totalPedido = totalPedido + 15
    print(f'. Valor do pedido: R$ {totalPedido:.2f}.')
    totalGeral = totalGeral + totalPedido
    qtdPedidos = qtdPedidos + 1
    fechar = input('Defina o fechamento do caixa: ')
print('\nCaixa fechado!')
print(f'Número de pedidos: {qtdPedidos}.')
print(f'Valor total vendido: R$ {totalGeral:.2f}.')

