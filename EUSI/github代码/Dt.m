function Dt = Dt (F,Y) %output Dt which correct is 0,uncorrect is 1;
id =  logical(F==Y);
 Dt = ones(length(Y),1)-id;
end
