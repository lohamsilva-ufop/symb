(declare-const A Int) (declare-const B Int)  (assert (= ( / A B)  0)) (assert (not ( = B 0)) )(check-sat) (get-model)
