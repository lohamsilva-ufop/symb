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


(define (eval-expr-define-const e)
  (match e
      [(evar e1) (string-append "(declare-const " (~a e1) " Int) ")]
      [(value val) ""]))

(define (return-define-const node)
  (match node
    [(lt e1 e2)  (string-append (eval-expr-define-const e1) (eval-expr-define-const e2))]
    [(bt e1 e2)  (string-append (eval-expr-define-const e1) (eval-expr-define-const e2))] 
    [(lte e1 e2) (string-append (eval-expr-define-const e1) (eval-expr-define-const e2))]
    [(bte e1 e2) (string-append (eval-expr-define-const e1) (eval-expr-define-const e2))]
    [(eeq e1 e2) (string-append (eval-expr-define-const e1) (eval-expr-define-const e2))]
    [(eand e1 e2)(string-append (eval-expr-define-const e1) (eval-expr-define-const e2))]
    [(eor e1 e2) (string-append (eval-expr-define-const e1) (eval-expr-define-const e2))]
    [(enot e1)   (eval-expr-define-const e1)]))


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
    [(evar v) (build-str-assign (evar v) (value 0) str-assign)]
    [(cons e v) (eval-init e str-assign)]))

(define (get-florest-assign ast str-assign )
   (match ast
    ['() str-assign]
   ; [(cons (input v1) astrest) (get-florest-assign astrest (build-str-input v1 str-assign )  )]
   ; [(cons (input-with-type t v1) astrest) (get-florest-assign astrest (build-str-input-type t v1 str-assign )  )]
    [(cons (input v1) astrest) (get-florest-assign astrest str-assign)]
    [(cons (input-with-type t v1) astrest) (get-florest-assign astrest str-assign)]
    [(cons (eassign v e1) astrest) (get-florest-assign astrest (build-str-assign v e1 str-assign )  )]
    [(cons (sprint e1) astrest) (get-florest-assign astrest str-assign)]
    [(cons (read-v v1) astrest) (get-florest-assign astrest str-assign)]
    [(cons (efor init stop block) astrest) (get-florest-assign astrest (eval-init init str-assign))]
    [(cons (ewhile expr block) astrest)
     (let  ([new-str (get-florest-assign block str-assign)])
     (get-florest-assign astrest new-str))]
    [(cons (eif econd then-block else-block) astrest)

     (let*  ([new-str1 (get-florest-assign then-block str-assign)]
             [new-str2 (get-florest-assign else-block new-str1)])
            (get-florest-assign astrest new-str2))




     ]
    [(eif econd then-block else-block) str-assign]))

(provide (all-defined-out))