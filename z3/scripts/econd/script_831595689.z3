(declare-const numero1 Int) (declare-const numero2 Int) (declare-const adicao Int) (assert (= adicao ( + numero1 numero2))) (assert (not (> adicao  20)))(check-sat) (get-model)
