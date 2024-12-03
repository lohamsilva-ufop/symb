(declare-const B Int) (declare-const C Int) (assert (= C ( + A 1)))(declare-const C Int) (assert (= C ( + B 2))) (assert (< B  0))(check-sat) (get-model)
