(declare-const n Int) (declare-const i Int) (assert (= i 0)) (assert (<= i  n))(check-sat) (get-model)
