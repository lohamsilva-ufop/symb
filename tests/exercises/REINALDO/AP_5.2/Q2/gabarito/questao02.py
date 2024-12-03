partidas = int(input('Informe a quantidade de partidas: '))
mImped = 0
mFalta = 0
mCartao = 0
mTempo = 0

for p in range(partidas):
    print("Partida ", p+1)
    imped    =   int(input('. Informe impedimentos.......: '))
    falta    =   int(input('. Informe faltas.............: '))
    cartao   =   int(input('. Informe cartões............: '))
    tempo    = float(input('. Informe tempo de acréscimo.: '))
    mImped = mImped + imped
    mFalta = mFalta + falta
    mCartao = mCartao + cartao
    mTempo = mTempo + tempo

print("Impedimentos.......:", mImped / partidas)
print("Faltas.............:", mFalta / partidas)
print("Cartões............:", mCartao / partidas)
print("Tempo de acréscimo.:", mTempo / partidas)
