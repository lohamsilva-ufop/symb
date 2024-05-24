#4) Escreva um programa para determinar se um dado número N (recebido através do teclado) é POSITIVO, NEGATIVO ou NULO.

numero = input("Insira um valor")

if numero > 0 :
    print "POSITIVO"
else:
   if numero < 0 :
      print "NEGATIVO"
   else:
      print "NULO"
