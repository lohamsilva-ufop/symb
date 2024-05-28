#lang racket

(require "definitions.rkt"
         "gen-text-econds.rkt")

(define (gen-script-eifs node ast nexec)
  (match node
    ['() '()]
    [ (tree-econds x y z) (gen-text x y z ast nexec)]))
  
(define (execute-gen-script-econds ast florest str nexec)
  (match florest
    ['() str]
    [(cons node rest) (gen-script-eifs node ast nexec)]))

(provide (all-defined-out))