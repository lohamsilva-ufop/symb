#lang racket
(require racket/date)
(require "../gen-atr/gen-atr-script.rkt")

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



(provide (all-defined-out))
