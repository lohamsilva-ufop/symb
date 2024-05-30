#lang racket

(require parser-tools/yacc
         "lexer.rkt"
         "syntax.rkt")

(define imp-parser
  (parser
   (start statements)
   (end EOF)
   (tokens value-tokens var-tokens syntax-tokens)
   (src-pos)
   (error
    (lambda (a b c d e)
      (begin
        (printf "a = ~a\nb = ~a\nc = ~a\nd = ~a\ne = ~a\n"
                a b c d e) (void))))
   (grammar
    (statements [() '()]
                [(statement LPAREN statements RPAREN) (cons $1 $3)]
                [(statement statements) (cons $1 $2)])
    (statement [(LPAREN DEFINE-FUN expr LPAREN RPAREN type expr RPAREN) (define-const-vars $3 $6 $7)]
               [(LPAREN DEFINE-FUN expr LPAREN expr RPAREN type expr RPAREN) (define-arg-fun $3 $5 $8)]
               [(SAT) (sat-unsat 'sat)]
               [(UNSAT) (sat-unsat 'unsat)])  
    (expr  [(LPAREN SUBTRACT NUMBER RPAREN) (value (- $3))]
           [(LPAREN expr EXC expr type RPAREN expr) (cons $2 $5)]
           [(LPAREN expr EXC expr type RPAREN) $2]
           [(NUMBER) (value $1)]
           [(DIV NUMBER) (value $2)]
           [(IDENTIFIER) (evar $1)])
    (type [(INT) (type 'Int)]
          [(BOOLEAN) (type 'Boolean)]))))
(define (parse ip)
  (imp-parser (lambda () (next-token ip))))

(provide parse)
