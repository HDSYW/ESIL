function  [P]=L2(X,Y)
m=length( Y);
zheng=X(Y==1,:);
[n,~]=size(zheng);
S=sum(zheng,1)/n;% ����������ƽ��ֵ
SS=repmat(S,m, 1);
% SS=S';
G=X-SS;%����������ȥ����������ƽ��ֵ
G=sum(abs(G),2);
P=G*G';
% Y= repmat(Y,1,m); 
Y=Y*Y';
P=Y.*P;
end