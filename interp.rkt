#lang racket

(require "syntax.rkt")

;premissa1: expressao reduz ao valor
;premissa2: um novo ambiente é a composição do ambiente união (par - identificador e valor)
;a atribuição reduz para um novo ambiente (new-env)
(define (eval-assign env v e)
  (hash-set env (evar-id v) (eval-expr env e)))

;premissa: expressão reduz a um valor
;conclusao: reduz ao ambiente
(define (search-value env v)
  (let ([value (hash-ref env (evar-id v))]) value))

(define (read-value env v1)
  (let ([x (read)])
     (display (hash-set env (evar-id v1) x))))

(define (eval-if env econd then-block else-block)
  (let ([result-econd (eval-expr env econd)])
     (if result-econd
         (eval-stmts env then-block)
         (eval-stmts env else-block))))

(define (eval-if-only-then env econd then-block)
  (let ([result-econd (eval-expr env econd)])
     (if result-econd
         (eval-stmts env then-block)
          env)))

(define (eval-while env econd block)
  (let ([result-econd (eval-expr env econd)])
     (if result-econd
         (begin
           (let ([nenv (eval-stmts env block)])
           (eval-while nenv econd block)))
          env)))

(define (eval-for env block init end)
  (if (< init end)
      (begin
        (let ([nenv (eval-stmts env block)]
              [init (+ init 1)])
            (eval-for nenv block init end)))
      env))

         
;para todas as expressões:
;premissas: expressão reduz a um valor
;conclusoes: operações sobre os valores.
(define (eval-expr env e)
  (match e
   [(add e1 e2)  (+ (eval-expr env e1) (eval-expr env e2))]
   [(minus e1 e2)(- (eval-expr env e1) (eval-expr env e2))]
   [(mult e1 e2) (* (eval-expr env e1) (eval-expr env e2))]
   [(divv e1 e2) (/ (eval-expr env e1) (eval-expr env e2))]
   [(lt e1 e2)   (< (eval-expr env e1) (eval-expr env e2))]
   [(bt e1 e2)   (> (eval-expr env e1) (eval-expr env e2))]
   [(lte e1 e2)  (<= (eval-expr env e1) (eval-expr env e2))]
   [(bte e1 e2)  (>= (eval-expr env e1) (eval-expr env e2))]
   [(eeq e1 e2)  (eq? (eval-expr env e1) (eval-expr env e2))]
   [(eand e1 e2) (and (eval-expr env e1) (eval-expr env e2))]
   [(eor e1 e2)  (or (eval-expr env e1) (eval-expr env e2))]
   [(enot e1) (not (eval-expr env e1))]
   [(evar e1) (search-value env (evar e1))]
   [(value val) val]))

(define (eval-stmt env s)
  (match s
   ; [(assign t v e1) (eval-assign env v e1)]
    [(eassign v e1) (eval-assign env v e1)]
    [(sprint e1)
     (let ([v (eval-expr env e1)])
       (begin
         (displayln  v)
         env))]
    [(read-v v1) (read-value env v1)]
    [(eif econd then-block else-block) (eval-if env econd then-block else-block)]
    
    #;[(ewhile econd block) (eval-while env econd block)]
    #;[(efor (assign t v ex) e1 block)
        (let* ([nenv (eval-stmt env (assign t v ex))]
              [init (eval-expr nenv ex)]
              [end  (eval-expr nenv e1)])
          (eval-for nenv block init end))]))

(define (eval-stmts env blk)
  (match blk
    ['() env]
    [(cons s blks) (let ([nenv (eval-stmt env s)])
                       (eval-stmts nenv blks))]))

(define (imp-interp prog)
  (eval-stmts (make-immutable-hash) prog))

(provide imp-interp eval-expr)
