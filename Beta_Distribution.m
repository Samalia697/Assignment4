function [p] = Beta_Distribution(a,b,thetas)
p=((thetas.^(a-1)).*((ones(size(thetas,1),size(thetas,2))-thetas).^(b-1)))./beta(a,b);
end

