#39) Criar um programa que informe a quantidade total de calorias de uma refeição a partir
#do usuário que deverá informar o prato, a sobremesa e a bebida 

#Prato Calorias Sobremesa Calorias Bebida Calorias
#Vegetariano 180 cal Abacaxi 75 cal Chá 20 cal
#Peixe 230 cal Sorvete diet 110 cal Suco de laranja 70 cal
#Frango 250 cal Mouse diet 170 cal Suco de melão 100 cal
#Carne 350 cal Mouse chocolate 200 cal Refrigerante diet 65 cal

prato = input("Digite o numero do prato: ")
sobremesa = input("Digite o numero da sobremesa: ")
bebida = input("Digite o numero da bebida: ")


if prato == 1:
    if sobremesa  == 1 and bebida == 1 :
        print ("Quantidade de calorias: ", 180+75+20)
    elif sobremesa  == 1 and bebida == 2 :
        print ("Quantidade de calorias: ", 180+75+70)
    elif sobremesa  == 1 and bebida == 3 :
            print ("Quantidade de calorias: ", 180+75+100)
    elif sobremesa  == 1 and bebida == 4 :
            print ("Quantidade de calorias: ", 180+75+65)
    else :
        if sobremesa  == 2 and bebida == 1 :
            print ("Quantidade de calorias: ", 180+110+20)
        elif sobremesa  == 2 and bebida == 2 :
            print ("Quantidade de calorias: ", 180+110+70)
        elif sobremesa  == 2 and bebida == 3 :
            print ("Quantidade de calorias: ", 180+110+100)
        elif sobremesa  == 2 and bebida == 4 :
            print ("Quantidade de calorias: ", 180+110+65)
        else :
            if sobremesa  == 3 and bebida == 1 :
                print ("Quantidade de calorias: ", 180+170+20)
            elif sobremesa  == 3 and bebida == 2 :
                print ("Quantidade de calorias: ", 180+170+70)
            elif sobremesa  == 3 and bebida == 3 :
                print ("Quantidade de calorias: ", 180+170+100)
            elif sobremesa  == 3 and bebida == 4 :
                print ("Quantidade de calorias: ", 180+170+65)
            else :
                if sobremesa  == 4 and bebida == 1 :
                    print ("Quantidade de calorias: ", 180+200+20)
                elif sobremesa  == 4 and bebida == 2 :
                    print ("Quantidade de calorias: ", 180+200+70)
                elif sobremesa  == 4 and bebida == 3 :
                    print ("Quantidade de calorias: ", 180+200+100)
                else :
                    if sobremesa  == 4 and bebida == 4 :
                        print ("Quantidade de calorias: ", 180+200+65)
else:
    if prato == 2:
        if sobremesa  == 1 and bebida == 1 :
            print ("Quantidade de calorias: ", 230+75+20)
        elif sobremesa  == 1 and bebida == 2 :
            print ("Quantidade de calorias: ", 230+75+70)
        elif sobremesa  == 1 and bebida == 3 :
                print ("Quantidade de calorias: ", 230+75+100)
        elif sobremesa  == 1 and bebida == 4 :
            print ("Quantidade de calorias: ", 230+75+65)
        else :
            if sobremesa  == 2 and bebida == 1 :
                print ("Quantidade de calorias: ", 230+110+20)
            elif sobremesa  == 2 and bebida == 2 :
                print ("Quantidade de calorias: ", 230+110+70)
            elif sobremesa  == 2 and bebida == 3 :
                print ("Quantidade de calorias: ", 230+110+100)
            elif sobremesa  == 2 and bebida == 4 :
                print ("Quantidade de calorias: ", 230+110+65)
            else :
                if sobremesa  == 3 and bebida == 1 :
                    print ("Quantidade de calorias: ", 230+170+20)
                elif sobremesa  == 3 and bebida == 2 :
                    print ("Quantidade de calorias: ", 230+170+70)
                elif sobremesa  == 3 and bebida == 3 :
                    print ("Quantidade de calorias: ", 230+170+100)
                elif sobremesa  == 3 and bebida == 4 :
                    print ("Quantidade de calorias: ", 230+170+65)
                else :
                    if sobremesa  == 4 and bebida == 1 :
                        print ("Quantidade de calorias: ", 230+200+20)
                    elif sobremesa  == 4 and bebida == 2 :
                        print ("Quantidade de calorias: ", 230+200+70)
                    elif sobremesa  == 4 and bebida == 3 :
                        print ("Quantidade de calorias: ", 230+200+100)
                    else :
                        if sobremesa  == 4 and bebida == 4 :
                            print ("Quantidade de calorias: ", 230+200+65)
    else:
        if prato == 3:
            if sobremesa  == 1 and bebida == 1 :
                print ("Quantidade de calorias: ", 250+75+20)
            elif sobremesa  == 1 and bebida == 2 :
                print ("Quantidade de calorias: ", 250+75+70)
            elif sobremesa  == 1 and bebida == 3 :
                print ("Quantidade de calorias: ", 250+75+100)
            elif sobremesa  == 1 and bebida == 4 :
                print ("Quantidade de calorias: ", 250+75+65)
            else :
                if sobremesa  == 2 and bebida == 1 :
                    print ("Quantidade de calorias: ", 250+110+20)
                elif sobremesa  == 2 and bebida == 2 :
                    print ("Quantidade de calorias: ", 250+110+70)
                elif sobremesa  == 2 and bebida == 3 :
                    print ("Quantidade de calorias: ", 250+110+100)
                elif sobremesa  == 2 and bebida == 4 :
                    print ("Quantidade de calorias: ", 250+110+65)
                else :
                    if sobremesa  == 3 and bebida == 1 :
                        print ("Quantidade de calorias: ", 250+170+20)
                    elif sobremesa  == 3 and bebida == 2 :
                        print ("Quantidade de calorias: ", 250+170+70)
                    elif sobremesa  == 3 and bebida == 3 :
                        print ("Quantidade de calorias: ", 250+170+100)
                    elif sobremesa  == 3 and bebida == 4 :
                        print ("Quantidade de calorias: ", 250+170+65)
                    else :
                        if sobremesa  == 4 and bebida == 1 :
                            print ("Quantidade de calorias: ", 250+200+20)
                        elif sobremesa  == 4 and bebida == 2 :
                            print ("Quantidade de calorias: ", 250+200+70)
                        elif sobremesa  == 4 and bebida == 3 :
                            print ("Quantidade de calorias: ", 250+200+100)
                        else :
                            if sobremesa  == 4 and bebida == 4 :
                                print ("Quantidade de calorias: ", 250+200+65)                                
        else:
            if prato == 4:
                if sobremesa  == 1 and bebida == 1 :
                    print ("Quantidade de calorias: ", 350+75+20)
                elif sobremesa  == 1 and bebida == 2 :
                    print ("Quantidade de calorias: ", 350+75+70)
                elif sobremesa  == 1 and bebida == 3 :
                    print ("Quantidade de calorias: ", 350+75+100)
                elif sobremesa  == 1 and bebida == 4 :
                    print ("Quantidade de calorias: ", 350+75+65)
                else :
                    if sobremesa  == 2 and bebida == 1 :
                        print ("Quantidade de calorias: ", 350+110+20)
                    elif sobremesa  == 2 and bebida == 2 :
                        print ("Quantidade de calorias: ", 350+110+70)
                    elif sobremesa  == 2 and bebida == 3 :
                        print ("Quantidade de calorias: ", 350+110+100)
                    elif sobremesa  == 2 and bebida == 4 :
                        print ("Quantidade de calorias: ", 350+110+65)
                    else :
                        if sobremesa  == 3 and bebida == 1 :
                            print ("Quantidade de calorias: ", 350+170+20)
                        elif sobremesa  == 3 and bebida == 2 :
                            print ("Quantidade de calorias: ", 350+170+70)
                        elif sobremesa  == 3 and bebida == 3 :
                            print ("Quantidade de calorias: ", 350+170+100)
                        elif sobremesa  == 3 and bebida == 4 :
                            print ("Quantidade de calorias: ", 350+170+65)
                        else :
                            if sobremesa  == 4 and bebida == 1 :
                                print ("Quantidade de calorias: ", 350+200+20)
                            elif sobremesa  == 4 and bebida == 2 :
                                print ("Quantidade de calorias: ", 350+200+70)
                            elif sobremesa  == 4 and bebida == 3 :
                                print ("Quantidade de calorias: ", 350+200+100)
                            else :
                                if sobremesa  == 4 and bebida == 4 :
                                    print ("Quantidade de calorias: ", 350+200+65)
        
        
   

            
        
    
