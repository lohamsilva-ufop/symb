#lang racket

(require "definitions.rkt"
         "gen-text-econds.rkt"
         "gen-text-florest-econds.rkt")
(require racket/hash)

(define (gen-script-eifs node ast nexec str-assert)
  (match node
    ['() '()]
    [ (tree-econds x y z) (gen-text x y z ast nexec str-assert)]))

(define (gen-script-florest-eifs node ast nexec str-assert)
  (match node
    ['() '()]
    [ (tree-econds x y z) (gen-florest-text x y z ast nexec str-assert)]))
  
(define (execute-florest ast florest str nexec table)
  (match florest
    ['() table]
    [(cons node rest) (let*
                        ([new-table (gen-script-florest-eifs node ast nexec "")]
                         [n2 (hash-union table new-table)])
                         ;(displayln n2)
                        (execute-florest ast rest str nexec n2))]))

(define (execute-node ast florest str nexec table)
  (match florest
    ['() table]
    [(cons node rest) (let
                        ([new-table (gen-script-eifs node ast nexec "")])
                        (execute-node ast rest str nexec new-table))]))

(define (execute-gen-script-econds ast florest str nexec table)
  (if (> (length florest) 1)
      (execute-florest ast florest str nexec table)
      (execute-node ast florest str nexec table)))

(provide (all-defined-out))