(declare-const C Int) (assert (= C ( + A B)))(declare-const B Int)  (assert (not (< B  0)))(check-sat) (get-model)
