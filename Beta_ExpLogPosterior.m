function [p] = Beta_ExpLogPosterior(z,N,thetas,a,b,type)
if(strcmpi(type,'explog')==1)
    p=exp(((z+a-1)*log(thetas))+(((N-z+b-1))*log(ones(size(thetas,1),size(thetas,2))-thetas))-(log(beta(z+a,N-z+b))));
else
    p=(((thetas).^(z+a-1)).*((ones(size(thetas,1),size(thetas,2))-thetas).^(N-z+b-1)))./sum(((thetas).^(z+a-1)).*((ones(size(thetas,1),size(thetas,2))-thetas).^(N-z+b-1)));
end
end