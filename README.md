# symb
Repositório de teste da ferramenta de Correção Automática de Exercícios utilizando Execução Simbólica 

Instalação

A) O início de tudo: O arquivo especificacao/controller.rkt

Ao executar o arquivo de especificação, a função execution-controller (especificacao/controller.rkt) é chamada (no reader);
A função recebe como parâmetro a árvore de sintaxe da especificação: quantidade de execuções, caminho do gabarito e caminho da pasta com os exercícios dos alunos;
Ao capturar esses parâmetros, a função execute-gab é chamada;
Ao ser executada, a função retorna um par: a tabela hash de entrada geradas pelo Z3 do gabarito (table-inputs-gab) e a lista de saídas após a execução dessas entradas (list-outs-gab);
Após isso, função percorre-path-student é chamada;
A função recebe como parâmetro, o caminho do diretório dos exercícios dos alunos, a lista com os nomes dos arquivos do diretório (retornada pela função directory-list), a tabela hash com as entradas e a lista de saída do gabarito;
A função percorre-path-student  tem duas funções principais: percorrer a pasta com os exercícios dos alunos, selecionando cada arquivo recursivamente e invocar a função para a correção (correction). Para cada arquivo selecionado, a função control-execute-students é chamada;
A função control-execute-students ao ser executada, retorna a lista de saídas da execução do programa (com base nas entradas geradas pelo gabarito). Invoca-se a função correction, para que a correção possa ser realizada;
A função correction recebe como parâmetro: a lista de saídas do gabarito e a lista de saída do exercício do aluno. Compara-se ambas as listas, para verificar se são iguais. Se sim, o exercício está correto. Senão, o exercício está incorreto;
A função percorre-path-student continua recursivamente o processo, até que a correção finaliza. 

B) Para o procedimento de execução do gabarito:
No arquivo especificacao/controller.rkt, a função execute-gab recebe como parâmetro: o número de execuções informado pelo usuário e a localização do arquivo.

A árvore de sintaxe do arquivo de gabarito é construído, por meio da função build-ast-from-file, presente no parser da linguagem Python (/python/parse-python/lex+yacc.rkt). O parser converte a linguagem Python para uma linguagem intermediária, denominada IMP. 

A árvore de sintaxe é então submetida a função get-eifs, que retorna uma estrutura de dados denominada “tree-econds”. Essa estrutura é uma árvore, que possui em todos os seus nós, as expressões lógicas dos comandos IF-THEN-ELSE, que permitem acessar todos os seus caminhos. Exemplo:

IF (x>3) THEN 
print (“maior) 
ELSE 
IF (x = 3) THEN
print (“Igual”)
ELSE
print (“menor) 

Estrutura: (tree-econds (expressão-princial) (expressões THEN) (expressões-ELSE))

(tree-econds (x>3) ‘() (tree-econds (x = 3) ‘() ‘()))

definitions.rkt
A função get-eifs está localizada em (/z3/gen-econds/definitions.rkt). A função ao receber a árvore de sintaxe do programa IMP como parâmetro, percorre cada comando recursivamente, até que encontre a estrutura eif. Ao encontrar, transforma cada expressão lógica em uma estrutura tree-econds, respeitando a posição: IF-THEN-ELSE.

gen-script.rkt 
Ao ser retornada a estrutura, a função execute-gen-script-econds é invocada. Está localizada em (/z3/gen-econds/gen-script.rkt). O objetivo da função é preparar os scripts Z3 para captar entradas, com base na estrutura do programa. A função gen-script-eifs é invocada, e ao haver o casamento de padrão com tree-econds, evoca a função gen-text, presente no arquivo (/z3/gen-econds/gen-text-econds.rkt), responsável por gerar as strings de texto dos scripts com base nas tree-econds. 

gen-text-econds.rkt
A função gen-text recebe como parâmetro os nós:  expressão-principal como x, expressão-THEN como y e expressão-ELSE como z. Além disso, há o número de execuções e a AST.

Como cada exercício possui expressões lógicas em diferentes partes do comando IF, quatro casos diferentes foram considerados para gerar os scripts:
Quando há expressão lógica somente na expressão principal. (Ex: (IF x > 8 THEN “maior que 8” ELSE “menor ou igual a 8”);
Quando há expressão lógica somente na expressão principal e na expressão THEN. Ex: 
IF x >= y + 3 THEN 
IF x = 5 THEN 
“o resultado é 5” 
ELSE 
“o resultado não é 5”
ELSE
	“o resultado é menor que 5”
Quando há expressão lógica somente na expressão principal e na expressão ELSE. Ex:
IF x>3 THEN 
print (“maior) 
ELSE 
IF x = 3 THEN
print (“Igual”)
ELSE
print (“menor) 

Quando há expressões lógicas em todas as expressões. Exemplo:
IF x>=3 THEN 
IF x = 3 THEN
print (“Igual a 3”)
ELSE
print (“diferente de 3”)  
ELSE 
IF x = 2 THEN
print (“Igual a 2”)
ELSE
print (“Menor que 3”) 

A função gen-text evoca as funções de acordo com o caso: text-only-x para gerar os scripts do 1° caso, text-only-x-y para gerar os scripts do 2° caso, text-only-x-z, para gerar os scripts do 3° caso, text-only-x-y-z para gerar os scripts do 4° caso, text-only-x-y. 

As funções evocadas por text-only possuem a mesma estrutura: 
Preparar a string com a expressão lógica do programa em expressão lógica interpretada pelo Z3 (Ex: 3>2 para (assert (> 3 2));
Preparar a string que contempla as atribuições de variáveis de um programa bem como a sua declaração a ser interpretada pelo Z3 (Ex: Int a / a = 4; para (declare-const a Int)  / (assert (= a 4)));
Evocar funções que preparam o script com a string gerada e que executam esses scripts.

As funções que preparam os scripts são: 

gen-econds-node: para cada nó tree-econds, gera a string de expressão lógica recursivamente. Analisa se há expressões lógicas para THEN (y) e para ELSE (z). Retorna uma string que contém essas expressões Z3 concatenadas. Exemplo:

SE (tree-econds (x>3) ‘() (tree-econds (x < 3) ‘() ‘(tree-econds (x > 3) ‘() ‘())))
RETORNA:  (< x 3) (> x 3)

gen-econds-node-false: realiza a mesma função que gen-econds-node, porém explorando a negação de um caminho;

build-list-econd-block: explora recursivamente os caminhos intermediários;

build-text-script: recebe como parâmetro as strings geradas (expressões lógicas e atribuições) e constroi todo o script Z3. Evoca a função execute-script que executa o script em seguida;

Cada script gerado evoca na função execute-script a função outz3-interp do arquivo (/z3/out/interp.rkt), para capturar os valores gerados, após a satisfação da propriedade do resultado da execução dos scripts gerados. 
[res (with-output-to-string (lambda () (system cmd)))]

