(declare-const numero Int)  (assert (= ( mod numero 3)  0)) (assert (not ( = 3 0)) )(check-sat) (get-model)
