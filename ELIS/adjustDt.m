function Dt = adjustDt(dt,f,Y,direction,pinlv)
A=f.*Y;

kn=zeros(length(Y),1);

A = A(A>0); % 选择所有大于零的元素
sorted_A = sort(A); % 对所选元素排序
n = numel(sorted_A); % 计算元素个数
top_half = sorted_A(1:round(n/2)); % 取前一半元素
bottom_half = sorted_A(round(n/2)+1:end); % 取后一半元素

% 找到前50%的数据在原向量A中的索引
top_half_idx = find(ismember(f.*Y, top_half));
% 找到后50%的数据在原向量A中的索引
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

