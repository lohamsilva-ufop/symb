#lang racket

(require "parser.rkt"
         "interp.rkt"
         "syntax.rkt")

(provide (rename-out [imp-read read]
                     [imp-read-syntax read-syntax]))

(define (imp-read in)
  (syntax->datum
   (imp-read-syntax #f in)))

(define (imp-read-syntax path port)
  (datum->syntax
   #f
   `(module imp-mod racket
      ,(let ([ast (parse port)])
      (finish (imp-interp ast))))))

(define (finish env)
  (displayln "Finished!"))