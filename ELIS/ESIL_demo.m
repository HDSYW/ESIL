
clear;clc;
%Demo
% sum(logical(Y==1))/sum(logical(Y==-1));
load('Credit/Australian.mat')
ESILF1=[];
ESILAUC=[];
ESILGmeans=[];
for time=1:3
rng(time)

%% 数据中有NaN值 清洗数据
nanRows = any(isnan(X), 2);
X = X(~nanRows, :);
Y = Y(~nanRows);
%% normalization
X = mapminmax(X',0,1);
X =X';

%%
testRatio = 0.8;
trainIndices = crossvalind('HoldOut', size(X, 1), testRatio);
testIndices = ~trainIndices;
trnX = X(trainIndices, :);
trnY = Y(trainIndices, :);
tstX = X(testIndices, :);
tstY = Y(testIndices, :);

%% Ensemble Stastical Invariants Learning
Vkerneltype = 'gussian_ker';%'theta_ker''gussian_ker'
Vkernelc = 8;
Vcdf = 'uniform';
[V] = V_Matrix(trnX,Vcdf,Vkernelc,Vkerneltype);
V = V/max(max(V));
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lp.kpar.type = 'rbf';%'linear'
Lp.kpar.par1 =2;
Lp.p1 =8;
Lp.p3 = 0.5;
Bestf =[0];
for m =  1:100
    if m ==  1   %% find best lusi with lower erorate
        [F,pid] = F1(tstX,trnX,trnY,V,Lp);
        P = F.lusi.P;% P_matrix
    else
        dt = Dt (F.Y.trn,trnY) ;
        dt = adjustDt(dt,F.lusi.ftrn,trnY,1,0.5);
        p =Pchoice(F.lusi.ftrn,trnX,trnY,dt);
        lamda=F.trnero^2;
        %   lamda=1/bestf;
        P = P+lamda*p;
        Lp.P = P/m;
        F =  weakLUSI(tstX,trnX,trnY,V,Lp);
        
    end
    Pid(1,m) = pid;
    trnero(1,m) = F.trnero;
    tstero(1,m) = 1-sum(logical(F.Y.tst==tstY))/length(tstY);
    LSboost_predY=F.Y.tst;
end
  [~, ~, Lsf1,  Lsgmeans, LsAUC, ~] = evaluate_classification(tstY, LSboost_predY);
 ESILF1= [ESILF1 Lsf1 ];
 ESILGmeans= [ESILGmeans Lsgmeans ];
 ESILAUC= [ESILAUC  LsAUC];

end
Ave_AUC= mean(ESILAUC);
Ave_F1= mean(ESILF1);
Ave_Gmeans= (ESILGmeans);
Std_AUC=std(ESILAUC);
Std_F1=std(ESILF1);
Std_AUC=std(ESILGmeans);
