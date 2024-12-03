(declare-const C Int) (assert (= C ( + A B)))(declare-const A Int)  (assert (> A  0))(check-sat) (get-model)
