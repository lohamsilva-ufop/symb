(declare-const numero Int)  (assert (not (= ( mod numero 3)  0)))(check-sat) (get-model)
