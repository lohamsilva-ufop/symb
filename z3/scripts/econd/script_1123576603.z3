(declare-const numero Int) (assert (= numero 4)) (assert (not (>= numero  0)))(check-sat) (get-model)
