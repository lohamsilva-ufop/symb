(declare-const media Real) (declare-const frequencia Int)  (assert (and (not (< frequencia  75)) (< media  6)))(check-sat) (get-model)
