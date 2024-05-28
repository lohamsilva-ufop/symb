(declare-const numero Int) (declare-const numero2 Int)  (assert (not (= numero  5)))(check-sat) (get-model)
