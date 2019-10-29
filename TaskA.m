clc
close all
%% TASK A
if(1)
% Recreate Figure 6.4
ReCreateFig_6_4
% Slice Sampling
a=[250,18,1];
b=[250,7,1];
nheads=17;
nflips=20;
N=[100,500,1000];
for i=1:length(N)
    figure('Name',['Number of random samples = ',num2str(N(i))],'Color','c');
    for j=1:length(a)
        subplot(1,3,j)
        x=slicesample(1,N(i),a(j),b(j),nflips,nheads);
        [binheight,bincenter] = hist(x,50);
        h = bar(bincenter,binheight,'hist');
        h.FaceColor = 'g';
    end
end
% Highest Density Interval (95%)
elseif(1)
y=[1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1 ,1 ,1];
z=sum(y);
N=length(y);
a=[250,18.25,1];
b=[250,6.75,1];
figure;
for j=1:length(a)
    expect_prob=(z+a(j))/(N+a(j)+b(j));
    %
    [p] = Beta_ExpLogPosterior(z,N,0:0.01:1,a(j),b(j),'normal');
    subplot(1,3,j)
    plot(0:0.01:1,p,'LineWidth',2,'color','#D95319');
    title(['Expected Probability = ',num2str(expect_prob)]);
    c_post=cumsum(p);
    [cl indexl] = min(abs(c_post-0.05));
    hdi=[p(indexl),p(indexl)];
    hold on;
    plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':');
    hold off;
    %
%     x=slicesample(1,1000,a(j),b(j),N,z);
%     pd = fitdist(x,'Beta');
%     expect_probS=(z+pd.a)/(N+pd.a+pd.b);
%     subplot(1,3,j)
%     h = histogram(x,'Normalization','probability');
%     h.BinWidth=0.01;
%     p=h.BinCounts;
%     title(['Expected Probability (Sampling)= ',num2str(expect_probS)]);
%     c_post=cumsum(p)./sum(p);
%     [cl indexl] = min(abs(c_post-0.05));
%     hdi=[p(indexl)/sum(p),p(indexl)/sum(p)];
%     hold on;
%     plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':');
%     hold off
    %
    %based on the figures: conf intr: 0.47-0.54   0.63-0.87   0.56-0.93
end
%
s=cumsum(p(51:end));
prb=s(end)*100;
disp(['The probability Theta>0.5: ',num2str(prb)]);
%
% s=sum(p(5:end));
% prb=(s/sum(p))*100;
% disp(['The probability Theta>0.5: ',num2str(prb)]);
%
x1=slicesample(1,1000,a(3),b(3),N,z);
pd = fitdist(x1,'Beta');
expect_probS=(z+pd.a)/(N+pd.a+pd.b);
figure;
h = histogram(x1,'Normalization','probability');
h.BinWidth=0.01;
h.FaceColor='c';
p1=h.BinCounts;
v1=h.Values;
c_post=cumsum(p1)./sum(p1);
[cl indexl] = min(abs(c_post-0.05));
hdi=[p1(indexl)/sum(p1),p1(indexl)/sum(p1)];
hold on;
plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':','Color','b');
Z= [1, 0, 0, 0, 0, 0, 0, 1, 1, 0];
z2=sum(Z);
N2=length(Z);
x2=slicesample(1,1000,a(3),b(3),N2,z2);
pd = fitdist(x2,'Beta');
expect_probS=(z2+pd.a)/(N2+pd.a+pd.b);
hold on
h = histogram(x2,'Normalization','probability');
h.BinWidth=0.01;
h.FaceColor='g';
p2=h.BinCounts;
v2=h.Values;
c_post=cumsum(p2)./sum(p2);
[cl indexl] = min(abs(c_post-0.05));
hdi=[p2(indexl)/sum(p2),p2(indexl)/sum(p2)];
hold on;
plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':','Color','#77AC30');
ind1=find(v1==0.005);
prob1=sum(v1(ind1:end))/sum(v1);
prob1=prob1*100;
display(['Q2b1:',num2str(prob1)]);
x3=x1-x2;
figure;
h = histogram(x1,'Normalization','probability');
h.BinWidth=0.01;
h.FaceColor='c';
p3=h.BinCounts;
v3=h.Values;
c_post=cumsum(p3)./sum(p3);
[cl indexl] = min(abs(c_post-0.05));
hdi=[p3(indexl)/sum(p3),p3(indexl)/sum(p3)];
hold on;
plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':','Color','b');
ind2f=find(v3(1:(length(v3)/2))>0.004);
ind2l=find(v3((length(v3)/2):end)<0.005);
prob2=sum(v3(min(ind2f):(max(ind2l)+(length(v3)/2)-1)))/sum(v3);
prob2=prob2*100;
display(['Q2b2:',num2str(prob2)]);
figure;
h = histogram(abs(x3),'Normalization','probability');
h.BinWidth=0.01;
h.FaceColor='b';
end