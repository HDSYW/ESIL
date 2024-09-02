function Dt = adjustDt(dt,f,Y,direction,pinlv)
A=f.*Y;

kn=zeros(length(Y),1);

A = A(A>0); % ѡ�����д������Ԫ��
sorted_A = sort(A); % ����ѡԪ������
n = numel(sorted_A); % ����Ԫ�ظ���
top_half = sorted_A(1:round(n/2)); % ȡǰһ��Ԫ��
bottom_half = sorted_A(round(n/2)+1:end); % ȡ��һ��Ԫ��

% �ҵ�ǰ50%��������ԭ����A�е�����
top_half_idx = find(ismember(f.*Y, top_half));
% �ҵ���50%��������ԭ����A�е�����
bottom_half_idx = find(ismember(f.*Y, bottom_half));

if direction==1
    kn(top_half_idx)=1;
    nois=pinlv*kn;
end
if direction==0
    kn(bottom_half_idx)=1;
    nois=pinlv*kn;
end
Dt = dt+nois;

end

