(declare-const Si Int)  (assert (not (< #(struct:evar i)  #(struct:value 5))))(check-sat) (get-model)
