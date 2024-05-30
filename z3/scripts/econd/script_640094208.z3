(declare-const peso Int) (declare-const altura Int) (declare-const imc Int) (assert (= imc ( * ( / peso altura) altura))) (assert (< imc  20))(check-sat) (get-model)
