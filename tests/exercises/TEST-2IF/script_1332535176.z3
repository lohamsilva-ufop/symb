(declare-const A Int) (declare-const B Int)  (assert (not (> A  0)))(check-sat) (get-model)
