function A=matrixnormalized(X)
lb=min(min(X));
ub=max(max(X));
if ub == lb
    A=X/lb;
else

X1=X-lb;
A=X1./(ub-lb);
end
end