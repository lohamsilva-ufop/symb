(declare-const B Int) (declare-const C Int) (assert (= C ( + C 1))) (assert (< B  0))(check-sat) (get-model)
