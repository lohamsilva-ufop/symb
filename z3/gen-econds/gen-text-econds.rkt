#lang racket
(require "../../syntax.rkt"
         "definitions.rkt"
          "../gen-atr/gen-atr-script.rkt"
          "../out/interp.rkt"
          "../out/parser.rkt"
          "gen-text-div-or-mod.rkt")

(require racket/date)
(require racket/hash)

(define (create-script-file text-script)
   (let*  ([path-file (string->path (string-append "script_" (~a (random (date->seconds (current-date)))) ".z3"))]
           [out (open-output-file path-file
                                  #:mode 'text
                                  #:exists 'replace)])
     (begin
      (displayln text-script out)
      (close-output-port out)
      path-file)))

(define (execute-script text-script ast nexec hasht)
  (begin
  (let*  ([script-file (create-script-file text-script)]
          [cmd (string-append "z3 " (path->string script-file))]
          [res (with-output-to-string (lambda () (system cmd)))])
           (begin
           (displayln text-script)
           (displayln res)
         (outz3-interp (parse (open-input-string res)) text-script ast nexec hasht)))))

(define (build-text-script str ast nexec hasht)
 (execute-script (string-append
     str
     "(check-sat) "
     "(get-model)") ast nexec hasht))

(define (eval-expr-gen-econds e)
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
   [(diff e1 e2)  (string-append "(distinct " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")] 
   [(eand e1 e2) (string-append "( and " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(eor e1 e2)  (string-append "( or " (eval-expr-gen-atr e1) " " (eval-expr-gen-atr e2) ")")]
   [(enot e1) (string-append "( not " (eval-expr-gen-atr e1) ")")]
   [(evar e1) (~a e1)]
   [(value val) (~a val)]))

(define (check-econd node )
  (match node
    [(lt e1 e2)   (string-append "(< " (~a (eval-expr-gen-econds e1)) "  " (~a (eval-expr-gen-econds e2)) ")")]
    [(bt e1 e2)   (string-append "(> " (~a (eval-expr-gen-econds e1)) "  " (~a (eval-expr-gen-econds e2)) ")")]
    [(lte e1 e2)   (string-append "(<= " (~a (eval-expr-gen-econds e1)) "  " (~a (eval-expr-gen-econds e2)) ")")]
    [(bte e1 e2)   (string-append "(>= " (~a (eval-expr-gen-econds e1)) "  " (~a (eval-expr-gen-econds e2)) ")")]
    [(eeq e1 e2)   (string-append "(= " (~a (eval-expr-gen-econds e1)) "  " (~a (eval-expr-gen-econds e2)) ")")]
    [(eand e1 e2)   (string-append "(and " (~a (eval-expr-gen-econds e1)) "  " (~a (eval-expr-gen-econds e2)) ")")]
    [(eor e1 e2)   (string-append "(or " (~a (eval-expr-gen-econds e1)) "  " (~a (eval-expr-gen-econds e2)) ")")]
    [(enot e1)    (string-append "(not " (~a (eval-expr-gen-econds e1))")")]))


(define (gen-econds-node-false tree str-cond )
  (match tree
    ['() str-cond]
    [ (list (tree-econds x y z)) (let*
                            ([new-str-x (string-append str-cond "(not " (check-econd x ) ") " (verify-node-mod-div x))]
                             [new-str-y (gen-econds-node-false y new-str-x )]
                             [new-str-z (gen-econds-node-false z new-str-y )])
                              new-str-z)]
    [ (tree-econds x y z) (let*
                            ([new-str-x (string-append str-cond "(not " (check-econd x ) ") " (verify-node-mod-div x))]
                             [new-str-y (gen-econds-node-false y new-str-x )]
                             [new-str-z (gen-econds-node-false z new-str-y )])
                              new-str-z)]))

(define (gen-econds-node tree str-cond )
  (match tree
    ['() str-cond]
    [ (list (tree-econds x y z)) (let*
                            ([new-str-x (string-append str-cond (check-econd x) (verify-node-mod-div x))]
                             [new-str-y (gen-econds-node y new-str-x )]
                             [new-str-z (gen-econds-node z new-str-y )])
                              new-str-z)]
    [ (tree-econds x y z) (let*
                            ([new-str-x (string-append str-cond (check-econd x) (verify-node-mod-div x))]
                             [new-str-y (gen-econds-node y new-str-x )]
                             [new-str-z (gen-econds-node z new-str-y )])
                              new-str-z)]))


(define (gen-text-each-element-list node-x node str str-assign ast nexec hasht)
  ;(displayln node-x)
  (cond
    [(equal? node '()) (let
                         ([new-hasht (build-text-script (string-append str-assign " (assert (and  " node-x " " str "(not " node ")))") ast nexec hasht)])
                          (cons new-hasht ""))]
    [else                (let*
                         ([new-hasht (build-text-script (string-append str-assign  " (assert (and " node-x " " str node "))") ast nexec hasht)]
                          [new-str (string-append str "(not "  node ")")])
                          (cons new-hasht new-str))]))

(define (return-x node)
  (match node
    [(tree-econds x y z) (check-econd x)]
    [(list (tree-econds x y z)) (check-econd x)]))

(define (build-list-econd-block node-x tree str str-assign ast nexec hasht)
  (match tree
    ['() hasht]
    [(list (tree-econds x '() z)) (let*
                            ([pair-hasht-str (gen-text-each-element-list node-x (check-econd x) str str-assign ast nexec hasht)]
                             [new-str (cdr pair-hasht-str)]
                             [new-hasht (car pair-hasht-str)])
                             (build-list-econd-block node-x z new-str str-assign ast nexec new-hasht))]
    [(tree-econds x '() z) (let*
                            ([pair-hasht-str (gen-text-each-element-list node-x (check-econd x) str str-assign ast nexec hasht)]
                             [new-str (cdr pair-hasht-str)]
                             [new-hasht (car pair-hasht-str)])
                             (build-list-econd-block node-x z new-str str-assign ast nexec new-hasht))]
    [(list (tree-econds x y '())) (let*
                            ([pair-hasht-str (gen-text-each-element-list node-x (check-econd x) str str-assign ast nexec hasht)]
                             [new-str (cdr pair-hasht-str)]
                             [new-hasht (car pair-hasht-str)])
                             (build-list-econd-block node-x y new-str str-assign ast nexec new-hasht))]
    [(tree-econds x y '()) (let*
                            ([pair-hasht-str (gen-text-each-element-list node-x (check-econd x) str str-assign ast nexec hasht)]
                             [new-str (cdr pair-hasht-str)]
                             [new-hasht (car pair-hasht-str)])
                             (build-list-econd-block node-x y new-str str-assign ast nexec new-hasht))]
    [(list (tree-econds x y z)) (displayln z)(let
                                  ([h1 (build-list-econd-block (check-econd x) y str str-assign ast nexec hasht)])
                                 
                                  
                                   (build-list-econd-block (check-econd x) z str str-assign ast nexec h1)


                                    
                         ) #;(let*
                            ([pair-hasht-str (gen-text-each-element-list node-x (check-econd x) str str-assign ast nexec hasht)]
                             [new-str (cdr pair-hasht-str)]
                             [new-hasht (car pair-hasht-str)]
                             [two-new-hasht (build-list-econd-block node-x y new-str str-assign ast nexec new-hasht)])
                             (build-list-econd-block node-x z new-str str-assign ast nexec two-new-hasht))]
    [(tree-econds x y z) #;(let
                            
                                  ([h1 (build-list-econd-block (check-econd x) y str str-assign ast nexec hasht)])
                                   (build-list-econd-block (check-econd x) z str str-assign ast nexec h1))


                                    
                         (let*
                            ([pair-hasht-str (gen-text-each-element-list node-x (check-econd x) str str-assign ast nexec hasht)]
                             [new-str (cdr pair-hasht-str)]
                             [new-hasht (car pair-hasht-str)]
                             [two-new-hasht (build-list-econd-block node-x y new-str str-assign ast nexec new-hasht)])
                             (build-list-econd-block node-x z new-str str-assign ast nexec two-new-hasht))]))

(define (build-script-path lista node-x str-assign ast)
  (match lista
    ['() '()]
    [(cons li rest) (begin
                     (let
                         ([str-script (string-append
                                       str-assign
                                      " (assert (and (not " node-x ") " li "))")])
                       (build-text-script str-script ast))
                     (build-script-path rest node-x str-assign ast))]))


(define (text-x-y-z x y z ast nexec )
  (let*
    ([node-x (check-econd x )]
     [node-y (gen-econds-node y "" )]
     [node-z (gen-econds-node z "" )]
     [str-assign (car (get-assign ast "" (make-immutable-hash)))]
     [str-script-false-y (string-append
                         str-assign
                        " (assert (and "node-x " " (gen-econds-node-false y "" )  "))")]
     [str-script-false-z (string-append
                         str-assign
                        " (assert (and (not " node-x ") " (gen-econds-node-false z "" )  "))")]
   
      [hasht1 (build-list-econd-block node-x y "" str-assign ast nexec (make-immutable-hash))]
      [hasht2 (build-text-script str-script-false-y ast nexec hasht1)]
      [hasht3 (build-list-econd-block node-x z "" str-assign ast nexec hasht2)]
      [hasht4 (build-text-script str-script-false-z ast nexec hasht3)])
      hasht4))
      
(define (text-only-x-z x z ast nexec )
  (let*
    ([node-x (check-econd x )]
     [node-z (gen-econds-node z "" )]
     [str-assign (car (get-assign ast "" (make-immutable-hash)))]
     [str-script-true (string-append
                         str-assign
                        " (assert " node-x ")"
                        (verify-node-mod-div x))]
     [str-script-false-z (string-append
                         str-assign
                        " (assert (and (not " node-x ") " (gen-econds-node-false z "" )  "))")]
     [hasht1 (build-text-script str-script-true ast nexec (make-immutable-hash))]
     [hasht2 (build-list-econd-block (string-append "(not " node-x ")") z "" str-assign ast nexec hasht1)]
     [hasht3 (build-text-script str-script-false-z ast nexec hasht2)])
     hasht3))

(define (text-only-x-y x y ast nexec)
  (let*
    ([node-x (check-econd x )]
     [node-y (gen-econds-node y "" )]
     [str-assign (car (get-assign ast "" (make-immutable-hash)))]
     [str-script-false-y (string-append
                         str-assign
                        " (assert (and "node-x " " (gen-econds-node-false y "" )  "))")]
     [str-script-false (string-append
                         str-assign
                        " (assert (not " node-x "))"
                          (verify-node-mod-div x))]
      [hasht1 (build-list-econd-block node-x y "" str-assign ast nexec (make-immutable-hash))]
      [hasht2 (build-text-script str-script-false-y ast nexec hasht1)]
      [hasht3 (build-text-script str-script-false ast nexec hasht2)])
      hasht3))


(define (text-only-x x ast nexec )
(let*
    ([node (check-econd x )]
     [str-assign (car (get-assign ast "" (make-immutable-hash)))]
     [str-script-true (string-append
                         str-assign
                        ; (return-define-const x)
                        " (assert " node ")"
                        (verify-node-mod-div x))]
     [str-script-false (string-append
                         str-assign
                       ;  (return-define-const x)
                        " (assert (not " node "))"
                        (verify-node-mod-div x))]
     [hasht1 (build-text-script str-script-true ast nexec (make-immutable-hash))]
     [hasht2 (build-text-script str-script-false ast nexec hasht1)])
     hasht2))

;(define (gen-text-asserts text)
  
(define (gen-text x y z ast nexec str-assert)  
  (cond
    [(and (equal? '() y) (equal? '() z))        (text-only-x x ast nexec)]
    [(and (not (equal? '() y)) (equal? '() z))  (text-only-x-y x y ast nexec )]
    [(and (equal? '() y) (not (equal? '() z)))  (text-only-x-z x z ast nexec )]
    [(and (not (equal? '() y)) (not (equal? '() z))) (text-x-y-z x y z ast nexec )]))

(provide gen-text)