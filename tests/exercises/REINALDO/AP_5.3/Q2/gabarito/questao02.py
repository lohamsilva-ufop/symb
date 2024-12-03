import math

def calculaF(x, y):
    if x <= 30:
        f = x ** 2 + 2 * y - 3
    elif x <= 60:
        f = math.sin(0.0175*x) * math.cos(0.0175*y)
    elif x <= 90:
        f = 1 / x**(-2) + y
    else:
        f = math.pi
    return round(f, 2)
    
ini = int(input('Digite o valor inicial: '))
while not (-150 <= ini <= 50):
    ini = int(input('Digite o valor inicial: '))
fim = int(input('Digite o valor final: '))
while fim <= ini:
    fim = int(input('Digite o valor final: '))
passo = int(input('Digite o passo: '))
while passo <= 0:
    passo = int(input('Digite o passo: '))

for x in range(ini, fim+1, passo):
    print()
    for y in range(ini, fim+1, passo):
        print(f'{calculaF(x, y): 10.2f}', end='')