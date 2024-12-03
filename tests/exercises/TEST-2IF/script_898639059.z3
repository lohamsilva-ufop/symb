(declare-const C Int) (declare-const C Int) (assert (= C ( + A B))) (assert (not (> C  0)))(check-sat) (get-model)
