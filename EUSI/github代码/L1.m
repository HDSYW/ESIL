function  [P]=L1(X,Y)%���� 
m=length( Y);
zheng=X(Y==1,:);%ȥ����������
[n,~]=size(zheng);
S=sum(zheng,1)/n;% �������������� ÿһάƽ��ֵ
% SS=repmat(S,m, 1);
SS=S';
    P=dist(X,SS);%����X�;���SS֮���ŷʽ����: ����,X������,Ӧ��SS��������ȡ� ����ʱ,�������Xÿһ�к�SS��ÿһ�е�ŷʽ���롣
    P=P*P';%����������������ֵ�ľ���
Y= repmat(Y,1,m); 
Y=Y.*Y';
P=Y.*P;
end