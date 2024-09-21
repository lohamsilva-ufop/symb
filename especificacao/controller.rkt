#lang racket

(require "syntax.rkt"
         "../python/parse-python/lex+yacc.rkt"
         "../interp.rkt"
         "../z3/gen-econds/gen-script.rkt"
         "../z3/gen-econds/definitions.rkt")

(define (consolidade-table table-inputs)
  (make-immutable-hash (hash-map table-inputs (lambda (k v) (cons k (reverse v))))))

(define (correction list-out-gabarito list-out-ex-alunos)
  (if (equal? list-out-gabarito list-out-ex-alunos)
      (displayln "O exercício está correto. ")
      (displayln "O exercício está incorreto. ")))

(define (percorre-path-student path list-files-path nexc table-inputs list-outs-gab  qtd-rep)
  (match list-files-path
    ['() (begin
           (displayln "Correção Finalizada. ")
            table-inputs)]
    [(cons f rest)
     (if (string-suffix? (~a f) ".bak")
         (percorre-path-student path rest nexc table-inputs list-outs-gab qtd-rep)  
       (let* ([path-file (string-append path "/" (~a f))]
             [pair-ex-student (control-execute-students nexc path-file table-inputs  qtd-rep)])
       (begin
        (display "Arquivo: ")
        (displayln f)
        (displayln "Saídas do gabarito: ")
        (displayln (reverse list-outs-gab))
        (displayln "Saídas após a execução do aluno com as entradas do gabarito: ")
        (displayln (reverse (cdr pair-ex-student)))
        (display "Correção: ")
        (correction list-outs-gab (cdr pair-ex-student))
        (displayln "===========================================")
        (percorre-path-student path rest nexc (car pair-ex-student) list-outs-gab qtd-rep))))]))

(define (control-execute-students nexec path-exercise table-inputs qtd-rep)
  (let ([ast  (build-ast-from-file path-exercise)]
         [iteration (if (equal?  (hash-values table-inputs) '())
                      -1
                      (length (car (hash-values table-inputs))))])
       (if (equal? iteration -1)
       (imp-interp ast nexec table-inputs table-inputs '() qtd-rep)    
       (imp-interp ast iteration table-inputs table-inputs '() qtd-rep))))

(define (execute-gab nexec path-gabarito qtd-rep)
  (let*
      ([ast  (build-ast-from-file path-gabarito)]
       [get-tree-econds (get-eifs ast)]
       [table (execute-gen-script-econds ast get-tree-econds "" nexec (make-immutable-hash))]
       [table-inputs (consolidade-table table)]
       [iteration (if (equal?  (hash-values table-inputs) '())
                      -1
                      (length (car (hash-values table-inputs))))])
       (if (equal? iteration -1)
       (imp-interp ast nexec table-inputs table-inputs '() qtd-rep)    
       (imp-interp ast iteration table-inputs table-inputs '() qtd-rep))))

(define (execution-controller cfg)
  (match cfg
   [(config numero-execucoes gabarito dir-aluno-exercicios qtd-repeticoes)
       (let*
           ([nexec (value-value numero-execucoes)]
            [path-gab (value-value gabarito)]
            [path-alunos (value-value dir-aluno-exercicios)]
            [qtd-rep (value-value qtd-repeticoes)]
            [pair-gab (execute-gab nexec path-gab qtd-rep)]
            [table-inputs-gab (car pair-gab)]
            [list-outs-gab (cdr pair-gab)]
            [list-files-path (directory-list path-alunos)])
              (begin
              (if (hash-empty? table-inputs-gab)
                  (displayln "")
                  (begin (display "Tabela de entradas geradas pelo gabarito: ")
                  (displayln table-inputs-gab)
                  (displayln "")))
              (percorre-path-student path-alunos list-files-path nexec table-inputs-gab list-outs-gab  qtd-rep)))]))
       
(provide execution-controller)