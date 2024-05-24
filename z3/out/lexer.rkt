#lang racket

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(define-tokens value-tokens (NUMBER))
(define-tokens var-tokens (IDENTIFIER))
(define-empty-tokens syntax-tokens
  (EOF
   SAT
   UNSAT
   SUBTRACT
   LPAREN
   RPAREN
   DEFINE-FUN
   INT
   BOOLEAN))

(define next-token
  (lexer-src-pos
   [(eof) (token-EOF)]
   [(:+ #\newline whitespace)
    (return-without-pos (next-token input-port))]
   ["("  (token-LPAREN)]
   [")"  (token-RPAREN)]
   [#\- (token-SUBTRACT)]
   ["sat" (token-SAT)]
   ["unsat" (token-UNSAT)]
   ["define-fun" (token-DEFINE-FUN)]
   ["Int" (token-INT)]
   ["Boolean" (token-BOOLEAN)]
   [(:: alphabetic (:* (:+ alphabetic numeric)))
    (token-IDENTIFIER lexeme)]
   [(:: numeric (:* numeric))
    (token-NUMBER (string->number lexeme))]))

(provide next-token value-tokens var-tokens syntax-tokens)
