#lang racket

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(define-tokens value-tokens (NUMBER STRING))
(define-tokens var-tokens (IDENTIFIER))
(define-empty-tokens syntax-tokens
  (EOF
   SAT
   UNSAT
   ERROR
   SUBTRACT
   LPAREN
   RPAREN
   EXC
   DIV
   DEFINE-FUN
   INT
   REAL
   BOOLEAN))

(define next-token
  (lexer-src-pos
   [(eof) (token-EOF)]
   [(:+ #\newline whitespace)
    (return-without-pos (next-token input-port))]
   ["("  (token-LPAREN)]
   [")"  (token-RPAREN)]
   ["!"  (token-EXC)]
   ["/"  (token-DIV)]
   [#\- (token-SUBTRACT)]
   ["sat" (token-SAT)]
   ["unsat" (token-UNSAT)]
   ["error" (token-ERROR)]
   ["define-fun" (token-DEFINE-FUN)]
   ["Int" (token-INT)]
   ["Real" (token-REAL)]
   ["Boolean" (token-BOOLEAN)]
   [(:: alphabetic (:* (:+ alphabetic numeric)))
    (token-IDENTIFIER lexeme)]
   [(:: numeric (:* numeric))
    (token-NUMBER (string->number lexeme))]
   [(:: numeric (:* numeric) "." (:: numeric (:* numeric)))
    (token-NUMBER (string->number lexeme))]
   [(:seq #\" (complement (:seq any-string #\" any-string)) #\")
    (token-STRING (substring lexeme 1 (sub1 (string-length lexeme))))]))

(provide next-token value-tokens var-tokens syntax-tokens)
