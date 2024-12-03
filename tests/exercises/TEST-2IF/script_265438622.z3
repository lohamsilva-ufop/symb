(declare-const C Int) (assert (= C ( + A B)))(declare-const B Int)  (assert (< B  0))(check-sat) (get-model)
