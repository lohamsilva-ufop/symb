(declare-const Si Int) (declare-const i Int) (assert (= i 10)) (assert (< i  0))(check-sat) (get-model)
