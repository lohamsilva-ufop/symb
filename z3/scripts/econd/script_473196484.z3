(declare-const numero Int)  (assert (not (= numero  5)))(check-sat) (get-model)
