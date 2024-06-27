(declare-const prato Int) (declare-const sobremesa Int) (declare-const bebida Int)  (assert (and (= prato  1) (not (= prato  2))(= prato  3)))(check-sat) (get-model)
