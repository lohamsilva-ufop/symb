(declare-const A Int) (declare-const C Int) (assert (= C ( + C 1))) (assert (> A  0))(check-sat) (get-model)
