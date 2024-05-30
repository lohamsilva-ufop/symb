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
                [(LPAREN statements RPAREN) $2]
                [(statement statements) (cons $1 $2)])
    (statement [(LPAREN statement RPAREN) $2]
               [(DEFINE-FUN expr arg type expr) (define-const-vars $2 $3 $4 $5)]
               [(ERROR expr) (error $2)]
               [(SAT) (sat-unsat 'sat)]
               [(UNSAT) (sat-unsat 'unsat)])
    (arg [(LPAREN expr RPAREN) $2])
    (expr  [(LPAREN SUBTRACT NUMBER RPAREN) (value (- $3))]
           [(LPAREN expr type RPAREN expr) (cons $2 $5)]
           [(NUMBER) (value $1)]
           [(STRING) (value $1)]
           [(expr EXC expr) (cons $1 $3)]
           [(DIV NUMBER) (value $2)]
           [(IDENTIFIER) (evar $1)]
           [() '()])
    (type [(INT) (type 'Int)]
          [(REAL) (type 'Real)]
          [(BOOLEAN) (type 'Boolean)]))))
(define (parse ip)
  (imp-parser (lambda () (next-token ip))))

(provide parse)



