(declare-const numero Int)  (assert (and (not (= ( mod numero 10)  0)) (= ( mod numero 5)  0)))(check-sat) (get-model)
