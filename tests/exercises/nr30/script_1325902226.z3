(declare-const A Int) (declare-const B Int) (declare-const C Int)  (assert (and (= ( + ( + A B) C)  180) (and ( and (distinct A B) (distinct B C))  (distinct C A))))(check-sat) (get-model)
