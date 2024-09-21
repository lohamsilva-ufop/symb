#lang racket

;; expression syntax

(struct config
  (numero-execucoes gabarito dir-exercicios qtd-repeticoes)
  #:transparent)

(struct value
  (value)
  #:transparent)

(provide (all-defined-out))

;(struct config
;  (numero-execucoes gabarito exercicio-aluno)
;  #:transparent)