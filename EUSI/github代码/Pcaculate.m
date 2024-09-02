function P = Pcaculate(X,Y,ptype)
Ptype = num2str(ptype);
Y(Y==-1,1)=0;%%
switch  Ptype
    case '1'
        P =diag(Y)*diag(Y)';%9
    case '2'
        P =eye(length(Y))*(eye(length(Y)))';%8
    case '3'
        P =X*X';%2
    case '4'%10
        r_p = X*pca(X);%通过某种线性投影，将高维的数据映射到低维的空间中，并期望在所投影的维度上数据的信息量最大（方差最大），以此使用较少的数据维度，同时保留住较多的原数据点的特性。
        P = r_p(:,1)*r_p(:,1)';
    case  '5'
        [P]=L1(X,Y);%5
    case  '6'
        [P]=L2(X,Y);%6
    case  '7'
        [P]=L3(X,Y);%7
    case'8'
        D1 = X(:,1);
        P = D1*D1';%4
    case'9'
        P =   ones(length(Y),1)*ones(length(Y),1)';%1
    case'10'
        P =   Y*Y';%3
end
P=matrixnormalized(P);
    end