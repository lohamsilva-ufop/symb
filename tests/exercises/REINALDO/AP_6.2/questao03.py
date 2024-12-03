import math

def calculosParede(Lp, Hp):
    Ap = Lp * Hp
    if Ap <= 60000:
        tipo = 'A'
        At = 171
        G = 1000
    elif Ap <= 90000:
        tipo = 'B'
        At = 200
        G = 1200
    else:
        tipo = 'C'
        At = 300
        G = 1400
    qtdT = math.ceil(Ap / At)
    qtdA = math.ceil(Ap / G)
    return tipo, qtdT, qtdA

Lp = float(input('Defina a largura da parede (cm): '))
Hp = float(input('Defina a altura da parede (cm): '))
while Lp > 0 and Hp > 0:
    tipo, qtdT, qtdA = calculosParede(Lp, Hp)
    print(f'. O tipo de tijolo é: {tipo}')
    print(f'. A quantidade de tijolos é: {qtdT}')
    print(f'. A quantidade de argamassa é: {qtdA}')
    Lp = float(input('\nDefina a largura da parede (cm): '))
    Hp = float(input('Defina a altura da parede (cm): '))