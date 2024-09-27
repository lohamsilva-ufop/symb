(declare-const Si Int) (declare-const i Int) (assert (= i 0)) (assert (not (< i  5)))(check-sat) (get-model)
