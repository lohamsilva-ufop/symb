(declare-const numero Int)  (assert (= ( mod numero 10)  0))(check-sat) (get-model)
