(declare-const C Real) (declare-const m Int) (declare-const J Int) (assert (= J ( * ( * C j) m))) (assert (<= C  10000))(check-sat) (get-model)
