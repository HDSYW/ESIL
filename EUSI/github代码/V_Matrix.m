function [V,v] = V_Matrix(X,CDFx,Sigma,v_ker) %要确定核 和 分布
                                              % theta 核  不要参数
                                              %经验分布 不要参数
                                              %Sigma 核参数
%%v= 每一维度的 v矩阵
  
[nsamp,nfea] = size(X);
%=======Uniform Distribution=========
if strcmp(CDFx,'uniform')
    %X = mapminmax(X',0,1)';
    alpha = 0.05;
    V = zeros(nsamp,nsamp);
    for d = 1:nfea
        [a,b,~,~] = unifit(X(:,d),alpha);
        for i = 1:nsamp
            for j = 1:nsamp
                if strcmp(v_ker,'theta_ker')
                                 x{d} = max(X(i,d),X(j,d));
                                cdf{d} = (x{d}-a)/(b-a);
                                v{d}(i,j) = 1- cdf{d};
                elseif strcmp(v_ker,'gussian_ker')
                %v{d}(i,j) = -(pi^(1/2)*exp(-X(i,d)^2/(4*Sigma^2))*exp(-X(j,d)^2/(4*Sigma^2))*exp((X(i,d)*X(j,d))/(2*Sigma^2))*(erf(((X(i,d)*1i + X(j,d)*1i)/(2*Sigma^2) - (a*1i)/Sigma^2)/(-1/Sigma^2)^(1/2))*1i - erf(((X(i,d)*1i + X(j,d)*1i)/(2*Sigma^2) - (b*1i)/Sigma^2)/(-1/Sigma^2)^(1/2))*1i))/(2*(a - b)*(-1/Sigma^2)^(1/2));

                Xave = (X(i,d)+X(j,d))/2;
                c = (b-a)/2;
                v{d}(i,j) = exp(-((X(i,d)-X(j,d))^2)/(Sigma^2))*(erf((c+Xave)/Sigma)+erf((c-Xave)/Sigma));
                %syms x;
                %Fx = exp(-0.5*(1/Sigma^2)*(x-X(i,d))^2)*exp(-0.5*(1/Sigma^2)*(x-X(j,d))^2);
                %v1{d}(i,j) = 1/(b-a)*int(Fx,x,a,b);
                %v{d} = double(v1{d});
                end
            end
        end
        %V = V.*v{d};
        V = V + v{d};
    end
%=============Normal Distribution==========
elseif strcmp(CDFx,'normal')
    alpha = 0.05;
    V = ones(nsamp,nsamp);
    X = zscore(X);
    for d = 1:nfea
        [mu,sigma,~,~] = normfit(X(:,d),alpha);
        for i = 1:nsamp
            for j = 1:nsamp
                x{d} = max(X(i,d),X(j,d));
                cdf{d} = normcdf(x{d},mu,sigma);
                v{d}(i,j) = 1- cdf{d};
            end
        end
        %V = V.*v{d};
        V = V + v{d};
    end
%===========Emprical Distribution=================
elseif strcmp(CDFx,'empirical')
    V = ones(nsamp,nsamp);
    for d =1:nfea
        v0 = zeros(nsamp,nsamp);
        for i = 1:nsamp
            for j = 1:nsamp
                for l = 1:nsamp
                    x = max(X(i,d),X(j,d));
                    if X(l,d) >= x
                        v0(i,j) = v0(i,j)+1/nsamp;
                    else
                        v0(i,j) = v0(i,j);
                    end
                    v{d} = v0;
                end
            end
        end
        %V = V.*v{d};
        V = V + v{d};
    end
end
end





