(declare-const numero Int)  (assert (not (= ( mod numero 5)  0)))(check-sat) (get-model)
