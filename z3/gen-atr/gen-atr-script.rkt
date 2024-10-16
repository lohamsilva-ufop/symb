#lang racket

(require "../../syntax.rkt"
         "../../interp.rkt"
         "../gen-econds/gen-text-div-or-mod.rkt")

(require racket/date)

(define (eval-expr-gen-atr e)
 ; (displayln e)
  (match e
   [(add e1 e2)  (string-append "( + " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(minus e1 e2)(string-append "( - " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(mult e1 e2) (string-append "( * " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(divv e1 e2) (string-append "( / " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(esqrt e1)   (string-append "(Sqrt (" (eval-expr-gen-atr e1) ")")]
   [(epow e1 e2) (string-append "( ^ " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(mod e1 e2)  (string-append "( mod " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(lt e1 e2)   (string-append "( < " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(bt e1 e2)   (string-append "( > " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(lte e1 e2)  (string-append "( <= " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(bte e1 e2)  (string-append "( >= " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(eeq e1 e2)  (string-append "( = " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(diff e1 e2) (string-append "(distinct " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(eand e1 e2) (string-append "( and " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(eor e1 e2)  (string-append "( or " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(enot e1) (string-append "( not " (eval-expr-gen-atr e1) ")")]
   [(evar e1) (~a e1)]
   [(value val) (~a val)]))


(define (build-str-input v str-assign )
  (string-append
   str-assign
   (string-append "(declare-const " (evar-id v) " Int) ")))

(define (build-str-input-type t v str-assign)
  (match t
    [(value "int")  (string-append
                       str-assign
                     (string-append "(declare-const " (evar-id v) " Int) "))]

    [(value "float")  (string-append
                       str-assign
                     (string-append "(declare-const " (evar-id v) " Real) "))]

    [(value "double")  (string-append
                       str-assign
                     (string-append "(declare-const " (evar-id v) " Real) "))]

     [(value "boolean")  (string-append
                       str-assign
                     (string-append "(declare-const " (evar-id v) " Boolean) "))]))

(define (build-str-assign v e1 str-assign )
  (string-append
   str-assign
   (string-append "(declare-const " (evar-id v) " Int) ")
  "(assert (= " (evar-id v) " " (eval-expr-gen-atr e1) "))"
  (expr-div-node e1)))

(define (eval-init init str-assign)
  (match init
    [(eassign v e1) (build-str-assign v e1 str-assign)]
    [(evar v) (build-str-assign v (value 0) str-assign)]
    [(cons e v) (eval-init e str-assign)]))

(define (get-assign ast str-assign )
   (match ast
    ['() str-assign]
    [(cons (input v1) astrest) (get-assign astrest (build-str-input v1 str-assign )  )]
    [(cons (input-with-type t v1) astrest) (get-assign astrest (build-str-input-type t v1 str-assign )  )]
    [(cons (eassign v e1) astrest) (get-assign astrest (build-str-assign v e1 str-assign )  )]
    [(cons (sprint e1) astrest) (get-assign astrest str-assign)]
    [(cons (read-v v1) astrest) (get-assign astrest str-assign)]
    [(cons (efor init stop block) astrest) (get-assign astrest (eval-init init str-assign))]
    [(cons (ewhile expr block) astrest) (get-assign astrest str-assign)]
    [(cons (eif econd then-block else-block) astrest) (get-assign astrest str-assign  )]
    [(eif econd then-block else-block) str-assign]))

(provide (all-defined-out))