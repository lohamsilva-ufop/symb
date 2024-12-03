#lang racket

(require "syntax.rkt")
(define (eval-assign env v e table  list-out)
  ;(displayln v)
   (let ([nenv (hash-set env (evar-id v) (eval-expr env e))])
   (cons nenv (cons table  list-out))))

(define (search-value env v)
 ; (displayln v)
  (let ([value (hash-ref env (evar-id v))]) value))

(define (read-value env v1 table list-out)
  (if (not (equal? (hash-ref table (evar-id v1)) '()))
   (let* ([list-values (hash-ref table (evar-id v1))]
         [value (car list-values)]
         [nenv (hash-set env (evar-id v1) value)]
         [new-table (hash-set table (evar-id v1) (cdr list-values))])
     (cons nenv (cons new-table list-out)))
     (cons env (cons table list-out))))
     
(define (eval-if env econd then-block else-block table  list-out qtd-rep)
  (let ([result-econd (eval-expr env econd)])
     (if result-econd
         (eval-stmts env then-block table list-out qtd-rep)
         (eval-stmts env else-block table list-out qtd-rep))))


(define (eval-init env init table list-out qtd-rep)
  (match init
    [(eassign v e1) (eval-stmt env v init table list-out qtd-rep)]
    [(evar e1) (if (hash-has-key? env e1)
                   (cons env (cons table list-out))
                   (eval-stmt env (eassign init (value 0)) table list-out qtd-rep))]
    [(cons e v) (eval-init env e table list-out qtd-rep)]))

(define (return-step env init)
  (match init
    [(eassign v e1) 1]
    [(evar e1) 1]
    [(cons e v) (eval-expr env v)]))
                   
(define (return-evar ev)
  (match ev
    [(eassign v e1) v]
    [(evar v) ev]
    [(cons e v) (return-evar e)]))

(define (execute-for block init-ev stop step env table list-out)
  (if (equal? stop (search-value env init-ev))
      (cons env (cons table list-out)) 
        (let* ([triple (eval-stmts env block table list-out stop)]
             [nenv1 (car triple)]
             [comp  (cdr triple)]
             [newtable (car comp)] 
             [newlist (cdr comp)]
             [value-init (search-value nenv1 init-ev)]
             [new-value-init (+ value-init step)]
             [new-triple (eval-assign nenv1 init-ev (value new-value-init) newtable newlist)]
             [nenv2 (car new-triple)]
             [comp2 (cdr new-triple)]
             [newtable2 (car comp2)] 
             [newlist2 (cdr comp2)])
        (execute-for block init-ev stop step nenv2 newtable2 newlist2))))

(define (eval-for env init expr block table list-out qtd-rep)
  (let* ([value-init (eval-init env init table list-out qtd-rep)]
         [nenv (car value-init)]
         [init-ev (return-evar init)]
         [stop (eval-expr env expr)]
         [step (return-step env init)])
    
    (if (> qtd-rep 0)
        (execute-for block init-ev qtd-rep step nenv table list-out)
        (execute-for block init-ev stop step nenv table list-out))))

(define (execute-ewhile-with-limitation env expr block table list-out qtd-rep)
  (if (equal? qtd-rep 0)
      (cons env (cons table list-out))
      (if (eval-expr env expr)
           (let* ([triple (eval-stmts env block table list-out qtd-rep)]
             [nenv1 (car triple)]
             [comp  (cdr triple)]
             [newtable (car comp)] 
             [newlist-out (cdr comp)])
             (execute-ewhile-with-limitation nenv1 expr block newtable newlist-out (- qtd-rep 1)))
           (cons env (cons table list-out)))))

(define (execute-ewhile-normal env expr block table list-out qtd-rep)
       (if (eval-expr env expr)
           (let* ([triple (eval-stmts env block table list-out qtd-rep)]
             [nenv1 (car triple)]
             [comp  (cdr triple)]
             [newtable (car comp)] 
             [newlist-out (cdr comp)])
             (execute-ewhile-normal nenv1 expr block newtable newlist-out qtd-rep))
           (cons env (cons table list-out))))           

(define (eval-ewhile env expr block table list-out qtd-rep)
  (if (> qtd-rep 0)
      (execute-ewhile-with-limitation env expr block table list-out qtd-rep)
      (execute-ewhile-normal env expr block table list-out qtd-rep)))
             
(define (list-eval-exp env e str)
  (match e
    [(cons first '()) (string-append str " " (~a (eval-expr env first))  )]
    [(cons first rest) (let
                         ([new-str (string-append str " " (~a (eval-expr env first)))])
                         (list-eval-exp env rest new-str))]))
      
(define (eval-expr env e)
  (match e
   [(add e1 e2)  (+ (eval-expr env e1) (eval-expr env e2))]
   [(minus e1 e2)(- (eval-expr env e1) (eval-expr env e2))]
   [(mult e1 e2) (* (eval-expr env e1) (eval-expr env e2))]
   [(divv e1 e2) (/ (eval-expr env e1) (eval-expr env e2))]
   [(esqrt e1) (sqrt (eval-expr env e1))]
   [(epow e1 e2)  (expt (eval-expr env e1) (eval-expr env e2))]
   [(mod e1 e2)  (remainder (eval-expr env e1) (eval-expr env e2))]
   [(lt e1 e2)   (< (eval-expr env e1) (eval-expr env e2))]
   [(bt e1 e2)   (> (eval-expr env e1) (eval-expr env e2))]
   [(lte e1 e2)  (<= (eval-expr env e1) (eval-expr env e2))]
   [(bte e1 e2)  (>= (eval-expr env e1) (eval-expr env e2))]
   [(eeq e1 e2)  (eq? (eval-expr env e1) (eval-expr env e2))]
   [(diff e1 e2) (not (eq? (eval-expr env e1) (eval-expr env e2)))]
   [(eand e1 e2) (and (eval-expr env e1) (eval-expr env e2))]
   [(eor e1 e2)  (or (eval-expr env e1) (eval-expr env e2))]
   [(enot e1) (not (eval-expr env e1))]
   [(evar e1) (search-value env (evar e1))]
   [(cons e1 e2) (list-eval-exp env (cons e1 e2) "")]
   [(value val) val]))

(define (eval-stmt env s table list-out qtd-rep)
  ;(displayln s)
  (match s
    [(eassign v e1) (eval-assign env v e1 table list-out)]
    [(type-and-eassign t v e1) (eval-assign env v e1 table list-out)]
    [(sprint e1)
     (let* ([v (eval-expr env e1)]
            [newlist (cons v list-out)])
          (cons env (cons table newlist)))]
    [(input v1) (read-value env v1 table list-out)]
    [(input-with-type t v1) (read-value env v1 table list-out)]
    [(eif econd then-block else-block) (eval-if env econd then-block else-block table  list-out qtd-rep)]
    [(efor init expr block) (eval-for env init expr block table list-out qtd-rep)]
    [(ewhile expr block) (eval-ewhile env expr block table list-out qtd-rep)]))

(define (eval-stmts env blk table list-out qtd-rep)
  ;(displayln blk)
  (match blk
    ['() (cons env (cons table list-out))]                                   
    [(cons s blks) (begin
                     (let* ([new-triple (eval-stmt env s table list-out qtd-rep)]
                            [nenv   (car new-triple)]
                            [newtable (car (cdr new-triple))]
                            [newlist (cdr (cdr new-triple))])
                            (eval-stmts nenv blks newtable newlist qtd-rep)))]))

(define (imp-interp prog iteration table-inputs copy-table-inputs list-out qtd-rep)
  (if (equal? iteration 0)
  (cons copy-table-inputs list-out)
  (let*
       ([triple (eval-stmts (make-immutable-hash) prog table-inputs list-out qtd-rep)]
        [new-table (car (cdr triple))]
        [new-list (cdr (cdr triple))])
       (imp-interp prog (- iteration 1)  new-table copy-table-inputs new-list qtd-rep))))
 
(provide imp-interp eval-expr)