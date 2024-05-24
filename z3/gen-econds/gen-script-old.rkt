#lang racket

(require "../syntax.rkt"
         "../interp.rkt"
         "../out/parser.rkt"
         "../gen-evars/gen.rkt"
         "definitions.rkt"
          "../gen-atr/gen-atr-script.rkt")

(require racket/date)

(define (create-script-file text-script)
   (let*  ([path-file (string->path (string-append "../../python/z3/scripts/econd/script_" (~a (random (date->seconds (current-date)))) ".z3"))]
           [out (open-output-file path-file
                                  #:mode 'text
                                  #:exists 'replace)])
     (begin
      (displayln text-script out)
      (close-output-port out)
      path-file)))

(define (gen-script text-script)
  (begin
  (let*  ([script-file (create-script-file text-script)]
          [cmd (string-append "z3 " (path->string script-file))]
          [res (with-output-to-string (lambda () (system cmd)))])
           (begin
           (displayln text-script)
         (displayln res)
           ))))

(define (split-econds str)
  ;(displayln str)
  (let*
      ([init (substring str 0 9)]
       [end  (string-replace str init "")])
    (cons init end)))

(define (check-variables node)
   (match node
         [(lt e1 e2) (let* ([type "int"]
                            [varx (evar-id e1)])
                       (cons varx type))]

         [(bt e1 e2) (let* ([type "int"]
                            [varx (evar-id e1)])
                       (cons varx type))]))

(define (check-econd node)
  (match node
    [(lt e1 e2)   (string-append "(< " (evar-id e1) "  " (~a (value-value e2)) ")")]
    [(bt e1 e2)   (string-append "(> " (evar-id e1) "  " (~a (value-value e2)) ")")]
    [(lte e1 e2)   (string-append "(<= " (evar-id e1) "  " (~a (value-value e2)) ")")]
    [(bte e1 e2)   (string-append "(>= " (evar-id e1) "  " (~a (value-value e2)) ")")]
    [(eeq e1 e2)   (string-append "(= " (evar-id e1) "  " (~a (value-value e2)) ")")]))

(define (gen-str-variables node )
  (let*
      ([res (check-variables (car node) )]
       [evar (car res)]
       [type (cdr res)])
  (string-append "(declare-const " evar " " (string-titlecase (~a type)) ") " )))
                           

(define (gen-script-true-block tree str-cond)
  (match tree
    ['() '()]
    [ (tree-econds x y z) (let
                            ([new-str-cond (string-append str-cond (check-econd x))])
                            (begin
                            (gen-script-eifs-then y new-str-cond)))]))
                            

(define (gen-script-else-block tree str-cond)
  (match tree
    ['() '()]
    [ (tree-econds x y z) (let
                            ([new-str-cond (string-append str-cond (check-econd x))])
                            (begin
                            (gen-script-eifs-else z new-str-cond)))]))
   
(define (gen-script-eifs-then florest str-cond)
  (match florest
    ['() str-cond]
    [(cons f rest) (let([ new (gen-script-true-block f str-cond)])
                      (gen-script-eifs-then rest new))]))

(define (gen-script-eifs-else florest str-cond)
  (match florest
    ['null str-cond]
    ['() str-cond]
    [(cons f rest) (let([ new (gen-script-else-block f str-cond)])
                      (gen-script-eifs-else rest new))]))

(define (analise-end-then end)
  (if (equal? 8 (string-length end))
       end
      (string-append "(and " end ")")))

(define (execute-gen-script-econds ast florest str-cond env)
  
  (let
    ([str-then (gen-script-eifs-then florest str-cond)]
     [str-else (gen-script-eifs-else florest str-cond)])
    (if (equal? str-then str-else)
        (let* 
        ([str-text-script-then
           (string-append
           (get-assign ast "" env)
          " (assert " str-then ")"
          "(check-sat) "
         "(get-model)")]

          [str-text-script-else
           (string-append
           (get-assign ast ""  env)
          " (assert (not " str-then "))"
          "(check-sat) "
         "(get-model)")])

          (begin
            (gen-script str-text-script-then)
            (gen-script str-text-script-else)))
        (gen-script-eifs-more-then-one ast str-then "" florest  env))))
        
        

(define (gen-script-eifs-more-then-one ast str-then str-cond florest env)
   (let*
    ([init-then (car (split-econds str-then))]
     [end-then  (cdr (split-econds str-then))]
     [str-else (gen-script-eifs-else florest str-cond)]
     [init-else (car (split-econds str-else))]
     [end-else (cdr (split-econds str-else))]
     
     [str-text-script-then-true
      (string-append
       (get-assign ast ""  env)
        " (assert (and " str-then "))"
        "(check-sat) "
        "(get-model)")]

     [str-text-script-then-false
      (string-append
       (get-assign ast ""  env)
        " (assert (and " init-then "  (not " (analise-end-then end-then) ")))"
        "(check-sat) "
        "(get-model)")]

     
     [str-text-script-else-true
      (string-append
       (get-assign ast ""  env)
        " (assert (and (not " init-else ") " (analise-end-then end-else) "))"
        "(check-sat) "
        "(get-model)")]

     [str-text-script-else-false
      (string-append
       (get-assign ast ""  env)
        " (assert (and (not " init-else ") (not " (analise-end-then end-else) ")))"
        "(check-sat) "
        "(get-model)")])

     (displayln str-then)
     (displayln init-then)
     (displayln end-then)
     (displayln str-else)
     (displayln init-else)
     (displayln end-else)
     
     
    (begin
    (gen-script str-text-script-then-true)
    (gen-script str-text-script-then-false)
    (gen-script str-text-script-else-true)
    (gen-script str-text-script-else-false))))


(provide (all-defined-out))