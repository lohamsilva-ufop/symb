#lang racket
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

(define (execute-script text-script)
  (begin
  (let*  ([script-file (create-script-file text-script)]
          [cmd (string-append "z3 " (path->string script-file))]
          [res (with-output-to-string (lambda () (system cmd)))])
           (begin
           (displayln text-script)
         (displayln res)))))

(define (build-text-script str)
 (execute-script (string-append
     str
     "(check-sat) "
     "(get-model)")))

(provide all-defined-out)