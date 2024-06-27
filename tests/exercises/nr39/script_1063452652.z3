(declare-const prato Int) (declare-const sobremesa Int) (declare-const bebida Int)  (assert (and (= prato  1) (not (= prato  2))(not (= prato  3))(= prato  4)))(check-sat) (get-model)
