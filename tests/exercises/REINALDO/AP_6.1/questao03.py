def Somatorio(N):
    soma = 0
    for i in range(1, N+1):
        soma += 1/i
    return soma

def Produtorio(N):
    prod = 1
    for i in range(1, N+1):
        prod *= 2 ** (1/i)
    return prod

N = int(input('Defina a quantidade de termos (N): '))
while N > 0:
    S = Somatorio(N)
    P = Produtorio(N)
    print(f'. O valor de S é {S:.3f}')
    print(f'. O valor de P é {P:.3f}')
    N = int(input('Defina a quantidade de termos (N): '))