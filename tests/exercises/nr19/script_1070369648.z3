(declare-const numero Int)  (assert (and (not (= numero  5)) (not (= numero  20))(not (= numero  400))(and ( >= numero 500)  ( <= numero 1000))))(assert (not (= numero 500))) (check-sat) (get-model)
