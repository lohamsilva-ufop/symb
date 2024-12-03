#lang racket

(require "../../syntax.rkt")

(struct tree-econds (econd true-block else-block) #:transparent)

(define (return-expr init stop)
  (match init
    [(eassign v e1) (lt v stop)]
    [(evar v) (lt (evar v) stop)]
    [(cons e v) (return-expr e stop)]))

(define (get-eifs ast)
   (match ast
    ['() '()]
    [(cons (eassign v e1) astrest) (get-eifs astrest)]
    [(cons (sprint e1) astrest) (get-eifs astrest)]
    [(cons (input e1) astrest) (get-eifs astrest)]
    [(cons (input-with-type t e1) astrest) (get-eifs astrest)]
    [(cons (efor init stop block) astrest) (let* ([tr (get-eifs block)]
                                                       [tl '()]
                                                       [expr (return-expr init stop)])
                                                       (cons (tree-econds expr tr tl) (get-eifs astrest)))]
    [(cons (ewhile expr block) astrest) (let* ([tr (get-eifs block)]
                                                       [tl '()])
                                                       (cons (tree-econds expr tr tl) (get-eifs astrest)))]
    [(cons (eif econd then-block else-block) astrest)  (let* ([tr (get-eifs then-block)]
                                                       [tl (get-eifs else-block)])
                                                       (cons (tree-econds econd tr tl) (get-eifs astrest)))]
     [(eif econd then-block else-block) (begin
                                              (let* ([tr (get-eifs then-block)]
                                              [tl (get-eifs else-block)])
                                              (tree-econds econd tr tl)))]))

(provide get-eifs (struct-out tree-econds)) 