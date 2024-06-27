(declare-const prato Int) (declare-const sobremesa Int) (declare-const bebida Int)  (assert (and (= prato  3) (not (= prato  4))(and ( = sobremesa 1)  ( = bebida 1))))(check-sat) (get-model)
