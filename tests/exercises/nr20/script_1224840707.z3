(declare-const numero1 Int) (declare-const numero2 Int)  (assert (> numero1  numero2))(check-sat) (get-model)
