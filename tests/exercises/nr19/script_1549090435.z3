(declare-const numero Int)  (assert (and (not (= numero  5)) (not (= numero  20))(not (= numero  400))(and ( >= numero 500)  ( <= numero 1000))))(check-sat) (get-model)
