(declare-const n Int) (declare-const i Int) (assert (= i 0)) (assert (not (< n  1)))(check-sat) (get-model)
