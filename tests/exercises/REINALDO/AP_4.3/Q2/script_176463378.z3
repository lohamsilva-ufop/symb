(declare-const media Real) (declare-const frequencia Int)  (assert (< frequencia  75))(check-sat) (get-model)
