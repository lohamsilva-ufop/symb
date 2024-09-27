(declare-const Si Real) (declare-const v Real) (declare-const t Real) (declare-const S Int) (assert (= S ( + Si ( * v t)))) (assert (< Si  0))(check-sat) (get-model)
