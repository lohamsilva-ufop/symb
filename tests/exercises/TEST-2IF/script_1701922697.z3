(declare-const B Int) (declare-const C Int) (assert (= C ( + A B))) (assert (< B  0))(check-sat) (get-model)
