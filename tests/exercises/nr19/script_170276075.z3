(declare-const numero Int)  (assert (= numero  5))(assert (not (= numero 5))) (check-sat) (get-model)
