# Symb
### Ferramenta de Correção Automática de Exercícios utilizando Execução Simbólica (Teste)

A ferramenta automática de exercício de programação introdutória denominada **Symb** tem o objetivo de auxiliar os docentes na avaliação, classificação e gerenciamento de exercícios de programação de computadores. 

O diferencial da ferramenta, é que não se faz necessária a inserção de casos de teste manualmente por parte dos professores, pois utiliza-se a abordagem de correção através da análise estática de um programa de gabarito do professor para a geração de casos de teste automatizados e a correção utilizando Execução Simbólica. 

A técnica de Execução Simbólica visa explorar múltiplos fluxos de execução de um programa, que pode auxiliar na verificação de propriedades a serem atestadas na correção de exercícios. Com a ferramenta, o professor somente indica a localização de seu gabarito, o diretório que contém os exercícios dos alunos e a quantidade de execuções, pretendo-se simplificar o trabalho do docente para elaborar exercícios e feedback rápido sobre suas possíveis soluções para exercícios propostos. 

## Instalação
### A) Windows  
1) Baixe este projeto em sua máquina, e descompacte em algum diretório de sua preferência; 
2) Instale a versão mais recente do Java. [Link de instalação](https://www.java.com/pt-BR/download/manual.jsp)
3) Instale a versão mais recente do Racket. [Link de instalação:](https://download.racket-lang.org/)
4) Baixe o Z3 Theorem Prover: [Link de instalação](https://github.com/Z3Prover/z3/releases). Em "Assets" procure pela versão do Windows 32 ou 64 bits, baixe e descompate a pasta em C:/Arquivos de programas;
5) Pressione Windows + R e digite: sysdm. cpl;
6) Na caixa de diálogo, clique em "Avançado" -> "Variáveis de Ambiente" -> Em "Variáveis do Sistema", Clique em "Novo".
7) Digite como: "nome da variável:" JAVA_TOOL_OPTIONS - Digite como "Valor da Variável:" -Dfile.encoding=UTF8 -> Clique em OK;
8) Na janela anterior, procure pela variável Path e clique em "Editar" -> "Novo" -> "Procurar";
9) Selecione a pasta raiz de instalação do Racket na pasta "C:/Arquivos de Programas/Racket";
10) Clique novamente em "Novo" -> "Procurar";
11) Selecione a pasta descompactada com os arquivos de instalação do Z3. Obrigatoriamente, selecione até a pasta /bin. 
12) Clique em "Ok" -> "Ok" -> "Ok";
13) Abra a pasta do projeto symb e clique em windows-bin;
14) E por fim, clique no executável Symb.jar para executar o programa.

### B) Linux
1) Baixe este projeto em sua máquina, e descompacte em algum diretório de sua preferência. Altere as permissões para leitura, execução e gravação; 
2) Instale a versão mais recente do Java. Siga as orientações de instalação para Linux. [Link de instalação](https://www.java.com/pt-BR/download/manual.jsp)
3) Instale a versão mais recente do Racket (8.3 ou superior). [Link de instalação:](https://download.racket-lang.org/) ou utilize o comando: 'apt-get install racket'
4) Baixe o Z3 Theorem Prover: [Link de instalação](https://github.com/Z3Prover/z3/releases). Siga as orientações para a instalação, ou utilize o comando: 'apt-get install z3'
5) Abra o terminal, vá até o diretório raiz do projeto, onde você descompactou (passo 1). Digite: `raco pkg install`
6) E por fim, clique no executável Symb.jar para executar o programa (Não esqueça de verificar as permissões do arquivo).

### C) Mac OS  
Em breve!

## Limitações

## Organização do projeto
1) O projeto está divido em quatro módulos: raiz, especificacao, z3 e outz3
2) Em seu diretório raiz, os arquivos interp.rkt, lexer.rkt, parser.rkt, syntax.rkt, reader.rkt e main.rkt, fazem parte da linguagem symb, que interpretará o programa.
3) O arquivo Symb.java é o executável da ferramenta;
4) O arquivo windows-bin.bat importa o módulo symb no racket para instalação via Windows
5) O diretório especificacao possui os arquivos referente ao modulo de especificacao;
6) O diretório z3 possui os arquivos referente ao modulo de z3 (geração de scripts);
7) O diretório z3/outz3 possui os arquivos referente ao modulo de outz3;
8) O diretório tests possui 21 exercícios de programação introdutória já testados. Possuem a localização do gabarito, um exercício correto e outro incorreto.

## Como os módulos do programa funcionam?
### A) O início de tudo: O módulo especificacao - arquivo especificacao/controller.rkt

Ao executar o arquivo de especificação, a função `execution-controller` (especificacao/controller.rkt) é chamada (no reader);

A função recebe como parâmetro a árvore de sintaxe da especificação: quantidade de execuções, caminho do gabarito e caminho da pasta com os exercícios dos alunos;
Ao capturar esses parâmetros, a função execute-gab é chamada;

Ao ser executada, a função retorna um par: a tabela hash de entrada geradas pelo Z3 do gabarito (table-inputs-gab) e a lista de saídas após a execução dessas entradas (list-outs-gab);
Após isso, função `percorre-path-student` é chamada;

A função recebe como parâmetro, o caminho do diretório dos exercícios dos alunos, a lista com os nomes dos arquivos do diretório (retornada pela função `directory-list`), a tabela hash com as entradas e a lista de saída do gabarito;

A função `percorre-path-student`  tem duas funções principais: percorrer a pasta com os exercícios dos alunos, selecionando cada arquivo recursivamente e invocar a função para a correção (correction). Para cada arquivo selecionado, a função `control-execute-students` é chamada;

A função `control-execute-students` ao ser executada, retorna a lista de saídas da execução do programa (com base nas entradas geradas pelo gabarito). Invoca-se a função `correction`, para que a correção possa ser realizada;

A função `correction` recebe como parâmetro: a lista de saídas do gabarito e a lista de saída do exercício do aluno. Compara-se ambas as listas, para verificar se são iguais. Se sim, o exercício está correto. Senão, o exercício está incorreto;

A função `percorre-path-student` continua recursivamente o processo, até que a correção finaliza. 

### B) Para o procedimento de execução do gabarito:
No arquivo especificacao/controller.rkt, a função `execute-gab` recebe como parâmetro: o número de execuções informado pelo usuário e a localização do arquivo.

A árvore de sintaxe do arquivo de gabarito é construído, por meio da função `build-ast-from-file`, presente no parser da linguagem Python (/python/parse-python/lex+yacc.rkt). O parser converte a linguagem Python para uma linguagem intermediária, denominada IMP. 

A árvore de sintaxe é então submetida a função `get-eifs`, que retorna uma estrutura de dados denominada `tree-econds`. Essa estrutura é uma árvore, que possui em todos os seus nós, as expressões lógicas dos comandos IF-THEN-ELSE, que permitem acessar todos os seus caminhos. Exemplo:

```
IF (x>3) THEN 
   print (“maior) 
ELSE 
   IF (x = 3) THEN
      print (“Igual”)
   ELSE
     print (“menor)
```

Estrutura: `(tree-econds (expressão-princial) (expressões THEN) (expressões-ELSE))`

`(tree-econds (x>3) ‘() (tree-econds (x = 3) ‘() ‘()))`

**definitions.rkt**
A função `get-eifs` está localizada em (/z3/gen-econds/definitions.rkt). A função ao receber a árvore de sintaxe do programa IMP como parâmetro, percorre cada comando recursivamente, até que encontre a estrutura eif. Ao encontrar, transforma cada expressão lógica em uma estrutura tree-econds, respeitando a posição: IF-THEN-ELSE.

**gen-script.rkt** 
Ao ser retornada a estrutura, a função `execute-gen-script-econds` é invocada. Está localizada em (/z3/gen-econds/gen-script.rkt). O objetivo da função é preparar os scripts Z3 para captar entradas, com base na estrutura do programa. A função `gen-script-eifs` é invocada, e ao haver o casamento de padrão com tree-econds, evoca a função `gen-text`, presente no arquivo (/z3/gen-econds/gen-text-econds.rkt), responsável por gerar as strings de texto dos scripts com base nas tree-econds. 

**gen-text-econds.rkt**
A função `gen-text` recebe como parâmetro os nós:  expressão-principal como x, expressão-THEN como y e expressão-ELSE como z. Além disso, há o número de execuções e a AST.

Como cada exercício possui expressões lógicas em diferentes partes do comando IF, quatro casos diferentes foram considerados para gerar os scripts:
Quando há expressão lógica somente na expressão principal. (Ex: `(IF x > 8 THEN “maior que 8” ELSE “menor ou igual a 8”)`;
Quando há expressão lógica somente na expressão principal e na expressão THEN. Ex: 

```
IF x >= y + 3 THEN 
   IF x = 5 THEN 
      “o resultado é 5” 
    ELSE 
     “o resultado não é 5”
ELSE
    “o resultado é menor que 5”
```

Quando há expressão lógica somente na expressão principal e na expressão ELSE. Ex:

```
IF x>3 THEN 
   print (“maior) 
ELSE 
   IF x = 3 THEN
      print (“Igual”)
   ELSE
      print (“menor)
``` 

Quando há expressões lógicas em todas as expressões. Exemplo:

```
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
```

A função `gen-text` evoca as funções de acordo com o caso: `text-only-x` para gerar os scripts do 1° caso, `text-only-x-y` para gerar os scripts do 2° caso, `text-only-x-z`, para gerar os scripts do 3° caso, `text-only-x-y-z` para gerar os scripts do 4° caso, `text-only-x-y`. 

As funções evocadas por `text-only` possuem a mesma estrutura: 
Preparar a string com a expressão lógica do programa em expressão lógica interpretada pelo Z3 (Ex: 3>2 para `(assert (> 3 2))`;
Preparar a string que contempla as atribuições de variáveis de um programa bem como a sua declaração a ser interpretada pelo Z3 (Ex: Int a / a = 4; para `(declare-const a Int)`  / `(assert (= a 4)))`;
Evocar funções que preparam o script com a string gerada e que executam esses scripts.

As funções que preparam os scripts são: 

**gen-econds-node:** para cada nó tree-econds, gera a string de expressão lógica recursivamente. Analisa se há expressões lógicas para THEN (y) e para ELSE (z). Retorna uma string que contém essas expressões Z3 concatenadas. Exemplo:

SE `(tree-econds (x>3) ‘() (tree-econds (x < 3) ‘() ‘(tree-econds (x > 3) ‘() ‘())))`
RETORNA:  `(< x 3) (> x 3)`

**gen-econds-node-false:** realiza a mesma função que `gen-econds-node`, porém explorando a negação de um caminho;

**build-list-econd-block:** explora recursivamente os caminhos intermediários;

**build-text-script:** recebe como parâmetro as strings geradas (expressões lógicas e atribuições) e constroi todo o script Z3. Evoca a função execute-script que executa o script em seguida;

Cada script gerado evoca na função `execute-script` a função `outz3-interp` do arquivo (/z3/out/interp.rkt), para capturar os valores gerados, após a satisfação da propriedade do resultado da execução dos scripts gerados. 
`[res (with-output-to-string (lambda () (system cmd)))]`

Em seguida, como dito anteriormente, a função `outz3-interp` é evocada, com a saída do console obtida (res), apresentada pela função `get-model` do Z3. O módulo outz3 possui um parsing, que retorna uma árvore de sintaxe de saída adequada para os próximos passos. 

**O módulo outz3**
**/z3/out/interp.rkt**
interp.rkt tem três objetivos principais:
Interpretar o resultado da saída (get-model) Z3 obtida pelo console. Essa saída possui o valor gerado pelas variáveis, se a expressão for satisfazível. Como dito anteriormente, o módulo out possui um parsing que converte a string do console, para uma árvore de sintaxe com as estruturas adequadas para capturar as entradas geradas pelas variáveis;
Inserir os valores gerados em uma tabela hash com a associação: variável . (lista de entradas);
Dependendo do número de execuções, evocar função que gera novos scripts com valores de entrada diferentes dos já existentes;

Para isso, a função `eval-stmts`, tem o objetivo de recursivamente acessar cada statment do programa. Evoca a função `eval-stmt` que analisa a *statment* repassada e ao encontrar a estrutura `declare-const-vars` evoca a função que insere na tabela hash, os valores de entrada da variável obtido na execução do script.

Ao retornar a tabela hash com os valores inseridos, a função `eval-stmts` verifica se o número de execuções é igual a 1. Se for, a tabela hash com as entradas é retornada para o `controller`. Senão, a função `repeat-script` é chamada, para gerar novos scripts com valores de entrada diferentes dos já existentes.

A função `repeat-script` de posse da tabela hash, gera um novo script com o valor obtido anteriormente. Exemplo:

```
#hash (numero . (4))
```

```
(declare-const numero Int)
(assert (> numero 3))
(assert (not (= numero 4))
(check-sat)
(get-model)
```

Resultado obtido:
```
sat

(

  (define-fun numero () Int

    5)

)

```

O valor obtido pelo script é capturado, e é gerada uma nova tabela hash com a lista de todos os valores obtidos:

```
#hash (numero . (5 4))
```

Dessa forma, o número de execuções é decrementado, para que recursivamente gere novos scripts, até que o seu valor seja 0. Exemplo:

```
(declare-const numero Int)
(assert (> numero 3))
(assert (not (= numero 4))
(assert (not (= numero 5))
(check-sat)
(get-model)
```

Resultado obtido:
```
sat

(

  (define-fun numero () Int

    6)

)

```

Novo hash obtido: 
```
#hash (numero . (6 5 4))
```

Quando o número de execuções é igual 0, a tabela hash com todos os valores obtidos é retornada para `execute-gab` (especificacao/controller.rkt)

De posse da tabela hash gerada, a função  `execute-gab` evoca o interpretador da linguagem intermediária que executará o gabarito com as entradas. A função `imp-interp` presente na pasta raiz do projeto, recebe como parâmetro a tabela de entradas. A variável iteration guarda o número de execuções que o gabarito deve ter. Esse número está associado à quantidade de valores gerados na tabela hash, pois para cada valor, um caminho do programa é explorado (Execução simbólica).

Enquanto a função `eval-stmts` recursivamente acessar cada statment do programa, `eval-stmt` evoca as funções necessárias para interpretar cada *statment* para a execução do programa. É dessa forma que as entradas da tabela hash serão utilizadas, para gerar as saídas do programa.

Em `eval-stmts`, identificado o comando `input`, evoca-se a função `read-value` que substitui a entrada de valores pelo teclado do usuário, pelas entradas da tabela hash. Dessa forma, a variável no enviroment (env) possui o valor obtido na tabela hash. Como nessa tabela, há a lista de entradas, cada entrada é computada recursivamente, como dito anteriormente. E cada uma delas, gera uma saída.

Em `eval-stmts`, identificado o comando `sprint`, que captura a saída gerada na execução do programa. Todas as saídas são inseridas em uma lista.

A função executa o programa recursivamente até que  `iteration` seja igual a 0. Se for, retorna-se para `execution-controler` (especificacao/controller.rkt), um par: a tabela hash com as entradas e as saídas obtidas, ambas do gabarito.

De posse do par (tabela de entradas x lista de saídas) do gabarito, `execution-controller` evoca a função `percorre-path-student`, na qual seus objetivos são descritos no item A) 7.

## Extensões para outras linguagens

