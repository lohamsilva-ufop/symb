(declare-const A Int) (declare-const C Int) (assert (= C ( + A 1))) (assert (> A  0))(check-sat) (get-model)
