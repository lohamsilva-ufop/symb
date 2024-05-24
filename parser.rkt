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
   (precs
    (nonassoc NOT EQ LT)
    (left ADD SUBTRACT)
    (left PRODUCT DIVISION AND))
   (grammar
    (statements [() '()]
                [(statement statements) (cons $1 $2)])
    (statement [(IDENTIFIER ASSIGN expr SEMI) (eassign (evar $1) $3)]
               [(PRINT expr SEMI) (sprint $2)]
               [(READ IDENTIFIER SEMI) (read-v (evar $2))]
               [(IF expr THEN block ELSE block) (eif $2 $4 $6)]
               [(WHILE expr DO block) (ewhile $2 $4)]
               [(FOR init TO expr DO block) (efor $2 $4 $6)]
               [(INPUT IDENTIFIER SEMI) (input (evar $2))])
    (init [(IDENTIFIER ASSIGN expr) (eassign (evar $1) $3)])
    (block [(BEGIN statements END) $2])
    (expr  [(NUMBER) (value $1)]
           [(IDENTIFIER) (evar $1)]
           [(FALSE) (value #f)]
           [(TRUE) (value #t)]
           [(expr ADD expr) (add $1 $3)]
           [(expr SUBTRACT expr) (minus $1 $3)]
           [(expr PRODUCT expr) (mult $1 $3)]
           [(expr DIVISION expr) (divv $1 $3)]
           [(expr MOD expr) (mod $1 $3)]
           ;[(SQRT LPAREN expr RPAREN) (esqrt $3)]
           [(expr LT expr) (lt $1 $3)]
           [(expr BT expr) (bt $1 $3)]
           [(expr LTE expr) (lte $1 $3)]
           [(expr BTE expr) (bte $1 $3)]
           [(expr EQ expr) (eeq $1 $3)]
           [(expr AND expr) (eand $1 $3)]
           [(expr OR expr) (eor $1 $3)]
           [(NOT expr) (enot $2)]
           [(LPAREN expr RPAREN) $2]))))

(define (parse ip)
  (imp-parser (lambda () (next-token ip))))

(provide parse)
