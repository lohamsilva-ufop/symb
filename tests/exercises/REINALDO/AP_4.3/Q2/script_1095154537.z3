(declare-const media Real) (declare-const frequencia Int)  (assert (and (not (< frequencia  75)) (not (< media  6)) ))(check-sat) (get-model)
