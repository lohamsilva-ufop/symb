#lang interp-imp/z3/testz3

int x := 1;

if x < 10 then
begin
           if x < 20 then
           begin
           print 5 + 4;
           end

           else
           begin
           print 4 + 4;
           end
            
end
  else
       begin
           if x < 6 then
           begin
           print 5 + 4;
           end

           else
           begin
           print 4 + 4;
           end
       end        