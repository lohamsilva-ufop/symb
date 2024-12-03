(declare-const C Int) (declare-const C Int) (assert (= C ( + A B))) (assert (< C  0))(check-sat) (get-model)
