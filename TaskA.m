clc
close all
%% TASK A

%Question 1
if(0)
    % Recreate Figure 6.4
    ReCreateFig_6_4
    % Slice Sampling
    a=[250,18,1];
    b=[250,7,1];
    nheads=17;
    nflips=20;
    N=[100,500,1000];
    for i=1:length(N)
        figure('Name',['Number of random samples = ',num2str(N(i))]);
        for j=1:length(a)
            subplot(1,3,j)
            x=slicesample(1,N(i),a(j),b(j),nflips,nheads);
            [binheight,bincenter] = hist(x,50);
            h = bar(bincenter,binheight,'hist');
            h.FaceColor = 'g';
        end
    end

%Question 2
elseif(1)
    
    %Question 2 part a,i
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
        x_ax=0:0.01:1;
        plot(x_ax,p,'LineWidth',2,'color','#D95319');
        title(['Expected Probability = ',num2str(expect_prob)]);
        c_post=cumsum(p);
        [cl indexl] = min(abs(c_post-0.05));
        hdi=[p(indexl),p(indexl)];
        hold on;
        plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':');
        hold off;
        %
    end

    figure;
    for j=1:length(a)
        x=slicesample(1,1000,a(j),b(j),N,z);
        pd = fitdist(x,'Beta');
        expect_probS=(z+pd.a)/(N+pd.a+pd.b);
        subplot(1,3,j)
        h = histogram(x,'Normalization','probability');
        h.BinWidth=0.01;
        ph=h.BinCounts;
        title(['Expected Probability (Sampling)= ',num2str(expect_probS)]);
        c_post=cumsum(ph)./sum(ph);
        [cl indexl] = min(abs(c_post-0.05));
        hdi=[ph(indexl)/sum(ph),ph(indexl)/sum(ph)];
        hold on;
        plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':');
        hold off
        %
    end
    
    %Question 2 part a,ii
    s=sum(p(ceil(length(x_ax)/2):end));
    prb=s*100;
    disp(['The probability Theta>0.5: ',num2str(prb)]);
    x1=slicesample(1,1000,a(3),b(3),N,z);
    pd = fitdist(x1,'Beta');
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
    s=sum(p1(3:end));%based on Figure 8 in the report in the run that 
                    %only 3 bins was related to the thetas equal or 
                    %less than 0.5 the probability was 
    prb=(s/sum(p1))*100;
    disp(['The probability Theta>0.5: ',num2str(prb)]);
    
    %Question 2 part b,1
    figure;
    h = histogram(x1,'Normalization','probability');
    h.BinWidth=0.01;
    h.FaceColor='c';
    p1=h.BinCounts;
    v1=h.Values;
    c_post=cumsum(p1)./sum(p1);
    [cl indexl] = min((c_post-0.05));
    hdi=[p1(indexl)/sum(p1),p1(indexl)/sum(p1)];
    hold on;
    plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':','Color','b');
    Z= [1, 0, 0, 0, 0, 0, 0, 1, 1, 0];
    z2=sum(Z);
    N2=length(Z);
    x2=slicesample(1,1000,a(3),b(3),N2,z2);
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
    prob2=(sum(v1(12:end))+(sum(v2(1:end-12))))/(sum(v1)+sum(v2));%based on the index of bins in Figure 9 in the report
    prob2=prob2*100;
    display(['Q2b1:',num2str(prob2)]);
    
    %Question 2 part b,2
    figure;
    x3=x1-x2;
    h = histogram((x3),'Normalization','probability');
    h.BinWidth=0.01;
    h.FaceColor='b';
    p3=h.BinCounts;
    v3=h.Values;
    c_post=cumsum(p3)./sum(p3);
    [cl indexl] = min((c_post-0.05));
    hdi=[p3(indexl)/sum(p3),p3(indexl)/sum(p3)];
    hold on;
    plot([0,1],hdi,'color','b','LineWidth',2,'LineStyle',':','Color','b');
    prob2=sum(v3(8:end-5))/(sum(v3));%based on the index of bins in Figure 10 in the report
    prob2=prob2*100;
    display(['Q2b2:',num2str(prob2)]);
    
    %Question 2 part b,3
    %is answered in the report
end