(declare-const numero Int)  (assert (and (not (= numero  5)) (not (= numero  20))(= numero  400)))(check-sat) (get-model)
