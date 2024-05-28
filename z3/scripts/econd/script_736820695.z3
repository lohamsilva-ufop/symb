(declare-const numero Int) (declare-const numero2 Int)  (assert (not (= numero2  400)))(check-sat) (get-model)
