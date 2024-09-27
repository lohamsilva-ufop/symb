(declare-const Si Int) (assert (= Si 3)) (assert (not (> Si  0)))(check-sat) (get-model)
