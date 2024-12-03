(declare-const A Int) (declare-const C Int) (assert (= C ( + A 1)))(declare-const C Int) (assert (= C ( + B 2))) (assert (> A  0))(check-sat) (get-model)
