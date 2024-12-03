#lang racket

(require "../../syntax.rkt"
         "../gen-econds/gen-text-div-or-mod.rkt")

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

(define (build-str-input v str-assign table-evars)
   (if (hash-has-key? table-evars (evar-id v))
       (cons "" table-evars)
  (cons
   (string-append
   str-assign
   (string-append "(declare-const " (evar-id v) " Int) "))
   (hash-set! table-evars (evar-id v) 0))))

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

(define (build-str-assign v e1 str-assign table-evars)
  (if (hash-has-key? table-evars (evar-id v))
      (cons
       (string-append
        str-assign
         "(assert (= " (evar-id v) " " (eval-expr-gen-atr e1) "))"
        (expr-div-node e1))
        table-evars)
  (cons
  (string-append
   str-assign
   (string-append "(declare-const " (evar-id v) " Int) ")
  "(assert (= " (evar-id v) " " (eval-expr-gen-atr e1) "))"
  (expr-div-node e1))
   (let ([new-hash (hash-set table-evars (evar-id v) e1)])
     new-hash))))

(define (eval-init init str-assign table-evars)
  ;(displayln table-evars)
  (match init
    [(eassign v e1) (build-str-assign v e1 str-assign table-evars)]
    [(evar v) (build-str-assign (evar v) (value 0) str-assign table-evars)]
    [(cons e v) (eval-init e str-assign table-evars)]))

(define (get-assign ast str-assign table-evars)
   (match ast
    ['() (cons str-assign table-evars)]
    [(cons (input v1) astrest) (let*
                                   ([new-result (build-str-input v1 str-assign table-evars)]
                                    [new-str (car new-result)]
                                    [new-table-evars (cdr new-result)])
                                   (get-assign astrest new-str new-table-evars))]
                                    
    [(cons (input-with-type t v1) astrest) (get-assign astrest (build-str-input-type t v1 str-assign ) table-evars )]
    [(cons (eassign v e1) astrest) (let*
                                   ([new-result (build-str-assign v e1 str-assign table-evars)]
                                    [new-str (car new-result)]
                                    [new-table-evars (cdr new-result)])
                                   (get-assign astrest new-str new-table-evars))]
     
    [(cons (sprint e1) astrest) (get-assign astrest str-assign table-evars) ]
    [(cons (read-v v1) astrest) (get-assign astrest str-assign table-evars) ]
    [(cons (efor init stop block) astrest) (let*
                                              ([evalued-init (car (eval-init init "" table-evars))]
                                               [new-result (get-assign block "" table-evars)]
                                               [new-str (car new-result)]
                                               [new-table-evars (cdr new-result)]
                                               [new-str2 (string-append  str-assign evalued-init new-str)])
                                               
                                               (get-assign astrest new-str2 new-table-evars))]
    ; (get-assign astrest (eval-init init str-assign)) table-evars]
    [(cons (ewhile expr block) astrest) (get-assign astrest str-assign  table-evars)]
    [(cons (eif econd then-block else-block) astrest) (get-assign astrest str-assign table-evars) ]
    [(eif econd then-block else-block) str-assign]))

(provide (all-defined-out))