M14 = float(input("Informe a média móvel dos últimos 14 dias: "))
A6 = int(input("Informe o somatório dos casos dos últimos 6 dias: "))
H = int(input("Informe a quantidade de casos de hoje: "))
M7 = A6 + H / 7
d = M7 - M14
Taxa = d / M14 * 100
if Taxa > 0:
    print("Casos diminuindo em", Taxa)
else:
    if Taxa <= 15:
        print("Casos estáveis em ",Taxa)
    else:
        print("Casos aumentando em ",Taxa)