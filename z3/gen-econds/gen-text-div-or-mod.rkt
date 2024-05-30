#lang racket
(require "../../syntax.rkt")

(define (check-evar-value node)
  (match node
    [(evar e1) (string-append "(assert (not ( = "(~a e1) " 0))) ")]
    [(value val) ""]))

(define (expr-div-node e)
  (match e
    [(divv e1 e2) (check-evar-value e2)]
    [(mod e1 e2)  (check-evar-value e2)]
    [(add e1 e2)  ""]
    [(minus e1 e2) ""]
    [(mult e1 e2) ""]
    [(esqrt e1)   ""]
    [(lt e1 e2)   ""]
    [(bt e1 e2)   ""]
    [(lte e1 e2)  ""]
    [(bte e1 e2)  ""]
    [(eeq e1 e2)  ""]
    [(eand e1 e2) ""]
    [(eor e1 e2)  ""]
    [(enot e1) ""]
    [(evar e1) ""]
    [(value val) ""]))

(define (verify-node-mod-div  node)
  (match node
    [(lt e1 e2)    (expr-div-node e1)]
    [(bt e1 e2)    (expr-div-node e1)]
    [(lte e1 e2)   (expr-div-node e1)]
    [(bte e1 e2)   (expr-div-node e1)]
    [(eeq e1 e2)   (expr-div-node e1)]
    [(eand e1 e2)  (expr-div-node e1)]
    [(eor e1 e2)   (expr-div-node e1)]
    [(enot e1)    (expr-div-node e1)]))

(provide verify-node-mod-div expr-div-node)
