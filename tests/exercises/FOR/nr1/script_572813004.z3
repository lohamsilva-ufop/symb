(declare-const Si Int) (declare-const i Int) (assert (= i 2)) (assert (< i  5))(check-sat) (get-model)
