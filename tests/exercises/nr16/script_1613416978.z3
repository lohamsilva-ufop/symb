(declare-const A Int) (declare-const B Int) (declare-const C Int)  (assert (and (not (and ( and ( > A B) ( > A C))  ( > B C))) (and ( and ( > A B) ( > A C))  ( > C B))))(check-sat) (get-model)
