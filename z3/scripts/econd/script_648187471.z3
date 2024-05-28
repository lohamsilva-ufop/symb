(declare-const numero Int)  (assert (= ( mod numero 5)  0))(check-sat) (get-model)
