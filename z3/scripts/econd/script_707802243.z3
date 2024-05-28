(declare-const numero Int)  (assert (and ( = ( mod numero 3) 0)  ( = ( mod numero 7) 0)))(check-sat) (get-model)
