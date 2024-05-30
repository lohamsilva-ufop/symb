(declare-const A Int) (declare-const B Int)  (assert (= (and ( mod A B) (not (= B 0)))  0))(check-sat) (get-model)
