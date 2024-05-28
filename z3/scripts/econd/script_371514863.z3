(declare-const numero Int)  (assert (and (not (= numero  5)) (= numero  20)))(check-sat) (get-model)
