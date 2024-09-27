(declare-const Si Int) (declare-const i Int) (assert (= i 0)) (assert (not (< i  10)))(check-sat) (get-model)
