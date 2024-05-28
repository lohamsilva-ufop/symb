#12) A prefeitura de Contagem abriu uma linha de crédito para os funcionários estatutários.
#O valor máximo da prestação não poderá ultrapassar 30% do salário bruto. Fazer um
#programa que permita entrar com o salário bruto e o valor da prestação, e informar se o empréstimo pode ou não ser concedido. 

salario = input("Digite o salario: ")
prestacao = input("Digite o valor da prestacao: ")
proporcao = salario * 30 / 100

if prestacao < proporcao:
   print ("O emprestimo pode ser concedido")
else:
   print ("O emprestimo não pode ser concedido")
 