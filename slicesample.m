function smpl = slicesample(siz,number,a,b,nflips,nheads)
smpl = [];
w = 0.01*rand(1,siz);
u = 1;
x = (0.5).*ones(1,siz);
for i = 1:number
%   if(mod(i,100)==0)
%       i
%   end
smpl(i,:) = x;
p = Beta_ExpLogPosterior(nheads,nflips,x,a,b,'explog');
up = rand(1,1)*p;
r = rand(1,1);
xl = x - r*w;
xr = x + (1-r)*w;
iter=0;
while ( Beta_ExpLogPosterior(nheads,nflips,xl,a,b,'explog') > u && iter<100)
    xl = xl - w;
    iter=iter+1;
end
iter=0;
while ( Beta_ExpLogPosterior(nheads,nflips,xr,a,b,'explog') > u && iter<100)
    xr = xr + w;
    iter=iter+1;
end
xp = rand(1,1)*(xr-xl) + xl;
while( Beta_ExpLogPosterior(nheads,nflips,xp,a,b,'explog') < up)
    xp = rand(1,1)*(xr-xl) + xl;
    if  Beta_ExpLogPosterior(nheads,nflips,xp,a,b,'explog') >up
        break;
    else
        if xp>x 
            xr = xp;
        else
            xl = xp;
        end
    end
end
x = xp;
u = up;
end