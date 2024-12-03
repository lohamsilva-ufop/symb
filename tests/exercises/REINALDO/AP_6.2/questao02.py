import math

def variacaoEntropia(TI, TF):
    TIk = TI + 273
    TFk = TF + 273
    VE = 8.314 * math.log(TFk / TIk)
    return VE

exp = int(input('Informe a quantidade de experimentos: '))
for e in range(exp):
    print(f'\nExperimento {e+1}:')
    ti = float(input('. Informe a temperatura inicial (Celsius): '))
    tf = float(input('. Informe a temperatura final (Celsius): '))
    ve = variacaoEntropia(ti, tf)
    print(f'. A variação de entropia é {ve:.3f} J/(mol K)')