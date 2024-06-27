(declare-const prato Int) (declare-const sobremesa Int) (declare-const bebida Int)  (assert (and (= prato  3) (= prato  4)))(check-sat) (get-model)
