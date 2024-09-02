function [bestP] =Pchoice(F,X,Y,Dt)%%%  

bestf = inf;

Y(Y==-1,1)=0;%%
%F(F==-1,1)=0;%%
F=F+0.5;
for i2 = 1:10
    ptype = num2str(i2);
    p = Pcaculate(X,Y,ptype);
  
 % fval=((F - Y))'*((Dt*Dt').*(V+P+lamda*p))*((F - Y));
   % fval=((F - Y))'*((Dt*Dt').*(V+lamda*p))*((F - Y));
     fval=((F - Y)'*((Dt*Dt').*p*(F - Y)));



   % fval=((F - Y))'*((Dt*Dt').*((1-Lp.p3)*V+Lp.p3*P))*((F - Y));
    if fval<bestf
        bestf = fval;
        bestP = ((Dt*Dt')*p);
        Pid = i2;
    end
end
