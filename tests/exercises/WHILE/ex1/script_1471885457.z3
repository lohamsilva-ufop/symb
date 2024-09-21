(declare-const A Int) (declare-const B Int) (declare-const contador Int) (assert (= contador 0)) (assert (not (> A  B)))(check-sat) (get-model)
