(declare-const A Int) (declare-const C Int) (assert (= C ( + A B))) (assert (> A  0))(check-sat) (get-model)
