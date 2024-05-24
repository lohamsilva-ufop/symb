#lang racket
(require racket/date)
(require "syntax.rkt"
         "parser.rkt"
         "../simbolic-table.rkt"
         "new-script.rkt"
         "../gen-script/script-generator.rkt"
         "../gen-atr/gen-atr-script.rkt")

(define (create-script-file text-script)
   (let*  ([path-file (string->path (string-append "../../z3/scripts/econd/script_" (~a (random (date->seconds (current-date)))) ".z3"))]
           [out (open-output-file path-file
                                  #:mode 'text
                                  #:exists 'replace)])
     (begin
      (displayln text-script out)
      (close-output-port out)
      path-file)))

(define (execute-script text-script)
  (begin
  (let*  ([script-file (create-script-file text-script)]
          [cmd (string-append "z3 " (path->string script-file))]
          [res (with-output-to-string (lambda () (system cmd)))])
           (begin
           (displayln text-script)
           (displayln res)
           res))))

(define (build-text-script str ast)
 (execute-script (string-append
    (get-assign ast "")
     str
     "(check-sat) "
     "(get-model)")))


(define (build-script table-in-list str)
  (match table-in-list
    ['() str]
    [(cons first rest) (let
                           ([new-str (string-append "(assert (not (= " (~a (car first)) " " (~a (cdr first)) "))) "  str)])
                             (build-script rest new-str))])) 

#;(define (update-value-table script iteration ast)
  (let* ([table-in-list (hash->list temp-table)]
         [new-str (build-script table-in-list "")]
         [res (build-text-script new-str ast)])
   (repeat-script res ast (- iteration 2))))

;pegou o valor, chamou update-value-table

#;(define (insert-value-table ev v)
  (begin
   ;não sei por que existe temp-table, mas a variavel e valor são enviados para insert-sim 
  (hash-set!  temp-table (evar-id ev) (value-value v))
  (insert-simbolic-table (evar-id ev) (value-value v))
  ;tabela inserindo só um valor até aqui
  ))


#;(define (eval-prog blk ast)
  (match blk
    ['() '()]
    [(cons s blks) (begin
                     (eval-stmt s)
                     (eval-prog blks ast))]))

#;(define (eval-stmts blk script ast  nexec)
  (match blk
    ['() (update-value-table script nexec ast)]
    [(cons s blks) (begin
                     (eval-stmt s)
                     (eval-stmts blks script ast  nexec))]))


(define (insert-value-table ev v symb-table-input-gab)
  (if (hash-has-key? symb-table-input-gab (evar-id ev))
      
      (let* ([old-value (hash-ref symb-table-input-gab (evar-id ev))]
             [new-hash (hash-set symb-table-input-gab (evar-id ev) (cons (value-value v) old-value))])
              new-hash)

      (let ([new-hash (hash-set symb-table-input-gab (evar-id ev) (list (value-value v)))])
            new-hash)))

(define (eval-stmt s symb-table-input-gab)
  (match s
    [(define-const-vars ev t v) (insert-value-table ev v symb-table-input-gab)]
    [(sat-unsat v) symb-table-input-gab]))

(define (eval-stmts prog text-script ast nexec symb-table-input-gab)
  (match prog
    ['() symb-table-input-gab]
    [(cons s rest) (let
                     ([new-symb-table-input-gab (eval-stmt s symb-table-input-gab)])
                     (eval-stmts rest text-script ast nexec new-symb-table-input-gab))]))

(define (outz3-interp prog script ast nexec symb-table-input-gab)
  (eval-stmts prog script ast nexec symb-table-input-gab))

(provide outz3-interp)
