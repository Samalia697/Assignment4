function [] = ReCreateFig_6_4()
thetas=0:0.01:1;
y=[ones(1,17),zeros(1,3)];
N=20;
z=17;
likelihood=Bernoulli_ExpLogLikelihood_Function(y,thetas);
 %Column 1: a=b=250
a=250;
b=250;
prior1=Beta_Distribution(a,b,thetas);
posterior1=Beta_ExpLogPosterior(z,N,thetas,a,b,'explog');
figure;
%
subplot(3,3,1);
area(thetas,prior1);
title('Prior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|250,250)');
%
subplot(3,3,4);
area(thetas,likelihood);
title('Likelihood (Bernoulli)');
xlabel('\theta');
ylabel('(D|\theta)');
%
subplot(3,3,7);
area(thetas,posterior1);
title('Posterior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|117,103)');
 %Column 2: a=18.25 b=6.75
a=18.25;
b=6.75;
prior2=Beta_Distribution(a,b,thetas);
posterior2=Beta_ExpLogPosterior(z,N,thetas,a,b,'explog');
%
subplot(3,3,2);
area(thetas,prior2);
title('Prior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|18.25,6.75)');
%
subplot(3,3,5);
area(thetas,likelihood);
title('Likelihood (Bernoulli)');
xlabel('\theta');
ylabel('(D|\theta)');
%
subplot(3,3,8);
area(thetas,posterior2);
title('Posterior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|35.25,9.75)');
 %Column 3: a=b=1
a=1;
b=1;
prior3=Beta_Distribution(a,b,thetas);
posterior3=Beta_ExpLogPosterior(z,N,thetas,a,b,'explog');
%
subplot(3,3,3);
area(thetas,prior3);
title('Prior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|1,1)');
%
subplot(3,3,6);
area(thetas,likelihood);
title('Likelihood (Bernoulli)');
xlabel('\theta');
ylabel('(D|\theta)');
%
subplot(3,3,9);
area(thetas,posterior3);
title('Posterior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|18,4)');
end