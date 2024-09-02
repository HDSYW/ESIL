function [F0,pid] = F1(tstX,trnX,trnY,V,Lp)
%% LUSI
bestf=1;
for i2 = 1:10
    ptype = num2str(i2);
    Lp.P = Pcaduizhao(trnX,trnY,ptype);
    
   h = weakLUSI(tstX,trnX,trnY,V,Lp);
   fval=h.trnero;
end
   % fval=((F - Y))'*((Dt*Dt').*((1-Lp.p3)*V+Lp.p3*P))*((F - Y));
    if fval<bestf
        bestf = fval;
       
        Pid = i2;
        bestF= h;
    end
    pid=Pid;
    F0=bestF;
    
    
    
    
    
%  %% vsvm  
%     
%      Lp.P = zeros(length(trnY),length(trnY));
%     h = weakLUSI(tstX,trnX,trnY,V,Lp);
%         F0 = h;
%         pid =0;

    end  