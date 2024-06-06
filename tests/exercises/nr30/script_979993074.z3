(declare-const A Int) (declare-const B Int) (declare-const C Int)  (assert (not (= ( + ( + A B) C)  180)))(check-sat) (get-model)
