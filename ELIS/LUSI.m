function [PredY,model] = LUSI(TestX,DataTrainX,DataTrainY,Para)
gam = Para.p1;%kp
tao =Para.p3;
tao1 = 1-Para.p3;
% tao =1;
% tao1 = 1;
X = DataTrainX;
Y = DataTrainY;
Y(Y==-1,1)=0;
% KerX = kernel(X',X',Para.kpar.type,Para.kpar.par1);
%[KerTstX] = kernel(X',TestX',Para.kpar.type,Para.kpar.par1); % ?????有问题
KerX = kernelfun(X,Para.kpar,X);%% X 为列向量 Para.kpar 有两个 分别是kt 和kcV = Para.Vtrn; 'rbf''lin'
[KerTstX] = kernelfun(X,Para.kpar,TestX);
V = Para.Vtrn;
P = Para.P;



Ab = inv((tao1*V+tao*P)*KerX+gam*eye(length(Y)))*(tao1*V+tao*P)*Y;%% 换一种求解方式求解Ab，Ac
Ac = inv((tao1*V+tao*P)*KerX+gam*eye(length(Y)))*(tao1*V+tao*P)*(ones(length(Y),1));
%c = (ones(1,length(Y))*(tao1*V+tao*P)*(Y-KerX*Ab))/((ones(1,length(Y))*(tao1*V+tao*P)*(ones(length(Y),1)-(ones(1,length(Y))*(tao1*V+tao*P)*KerX*Ac))));
c = (ones(1,length(Y))*(tao1*V+tao*P)*(Y-KerX*Ab))/(ones(1,length(Y))*(tao1*V+tao*P)*ones(length(Y),1)-ones(1,length(Y))*(tao1*V+tao*P)*KerX*Ac);
A = Ab-c*Ac;
%[KerTstX] = kernelfun(X,Para.kpar,TestX);
FTrn = (A'*KerX)'+c;%% Y.Trn output
FTst = (A'*KerTstX)'+c;%%Y.test output
ftst = FTst-0.5;
ftrn = FTrn-0.5;
 f = (A'*KerTstX)'+c;



PredY.tst = sign(ftst);
PredY.trn = sign(ftrn);
model.alpha = A;
model.w = A'*X;
model.b = c;
model.ftrn = ftrn;
model.P = P;
model.f = f;
model.trnX = DataTrainX;
model.K = KerX;%train kernel

% if Para.drw == 1
%     drw.ds = f;
%     drw.ss1 = drw.ds - 1;
%     drw.ss2 = drw.ds + 1;
%     model.drw = drw;
%     model.twin = 0;
% end
end
