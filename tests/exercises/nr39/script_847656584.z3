(declare-const prato Int) (declare-const sobremesa Int) (declare-const bebida Int)  (assert (and (= prato  1) (= prato  2)))(check-sat) (get-model)
