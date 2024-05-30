(declare-const A Int) (declare-const B Int)  (assert (= ( mod A B) (assert (not (= B 0)))  0))(check-sat) (get-model)
