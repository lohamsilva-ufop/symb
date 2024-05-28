(declare-const numero Int) (assert (= numero 4)) (assert (>= numero  0))(check-sat) (get-model)
