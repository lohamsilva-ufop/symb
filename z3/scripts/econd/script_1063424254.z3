(declare-const numero Int)  (assert (not (>= numero  4)))(check-sat) (get-model)
