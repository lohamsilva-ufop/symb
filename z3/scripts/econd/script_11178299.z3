(declare-const numero Int)  (assert (= ( mod numero 3)  0))(check-sat) (get-model)
