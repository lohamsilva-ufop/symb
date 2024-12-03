def Fatorial(n):
    fat = 1
    while n > 1:
        fat *= n
        n -= 1
    return fat

num = int(input("Informe o número que deseja calcular o Fatorial: "))
while num <= 0:
    num = int(input("Número inválido, defina outro: "))

print(f"O Fatorial de {num} é: {Fatorial(num):.0f}")
