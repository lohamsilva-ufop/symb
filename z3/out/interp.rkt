#lang racket
(require racket/date)
(require "syntax.rkt"
         "parser.rkt")

(define (create-script-file text-script)
   (let*  ([path-file (string->path (string-append "script_" (~a (random (date->seconds (current-date)))) ".z3"))]
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

(define (build-text-script str)
 (execute-script (string-append
     str
     "(check-sat) "
     "(get-model)")))

(define (build-script table-in-list str)
  (match table-in-list
    ['() str]
    [(cons first rest) (let*
                           ([replace (string-replace str "(check-sat) (get-model)" "")]
                            [new-str (string-append replace "(assert (not (= " (~a (car first)) " " (~a (car (cdr first))) "))) ")])
                             (build-script rest new-str))]))

(define (repeat-script text-script nexec symb-table-input-gab)
  (if (equal? nexec 0)
      symb-table-input-gab
 (let* ([table-in-list (hash->list symb-table-input-gab)]
         [new-str (build-script table-in-list text-script)]
         [res (build-text-script new-str)]
         [new-symb-table-input-gab (eval-second-stmts-prog (parse (open-input-string res)) text-script symb-table-input-gab)])
  (repeat-script new-str (- nexec 1) new-symb-table-input-gab))))

(define (eval-second-stmts-prog blk script symb-table-input-gab)
  (match blk
    ['()  symb-table-input-gab]
    [(cons s blks) (let
                     ([new-symb-table-input-gab (eval-stmt s symb-table-input-gab)])
                     (eval-second-stmts-prog blks script new-symb-table-input-gab))]))

(define (insert-value-table ev v symb-table-input-gab)
  (if (hash-has-key? symb-table-input-gab (evar-id ev))
      
      (let* ([old-value (hash-ref symb-table-input-gab (evar-id ev))]
             [new-hash (hash-set symb-table-input-gab (evar-id ev) (cons (value-value v) old-value))])
              new-hash)
      (let ([new-hash (hash-set symb-table-input-gab (evar-id ev) (list (value-value v)))])
            new-hash)))

(define (eval-stmt s symb-table-input-gab)
  (match s
    [(define-const-vars ev arg t v) (if (equal? arg '())
                                        (insert-value-table ev v symb-table-input-gab)
                                         symb-table-input-gab)]
    [(sat-unsat v)  (if (equal? v 'unsat)
                        (begin
                          (displayln "Não foi possivel satisfazer a expressão! Tente novamente. ")
                          (displayln "")
                          symb-table-input-gab)
                          symb-table-input-gab)]
    [(error e) symb-table-input-gab]))

(define (eval-stmts prog text-script ast nexec symb-table-input-gab)
  (match prog
    ['() (if (equal? nexec 1)
             symb-table-input-gab
             (repeat-script text-script ( - nexec 1) symb-table-input-gab))]
    [(cons s rest) (let
                     ([new-symb-table-input-gab (eval-stmt s symb-table-input-gab)])
                     (eval-stmts rest text-script ast nexec new-symb-table-input-gab))]))

(define (outz3-interp prog script ast nexec symb-table-input-gab)
  (eval-stmts prog script ast nexec symb-table-input-gab))

(provide outz3-interp)
