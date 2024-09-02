function [model] = weakLUSI(tstX,X,Y,V,Lp)
Lp.Vtrn= V;
[PredY,modelL] = LUSI(tstX,X,Y,Lp);%gam = Para.p1; (0,1)   ÑµÁ·Îó²î
                                             % tao =Para.p3;
                                              % tao1 = 1 - Para.p3;
                                                % X = DataTrainX;
                                                  % Y = DataTrainY
                                                    % KerX = kernelfun(X,Para.kpar,X);
                                                       % V = Para.Vtrn;
model.trnero = 1-sum(logical(PredY.trn == Y))/length(Y);

model.Y = PredY;
model.lusi  = modelL;
end


