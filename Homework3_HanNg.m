%% Econ 512 Problem Set 3 by Han Ng

%%% you forgot to do time comparisons. You get Check!
clear all;
close;
load hw3.mat;

maxinit = 100;
init = randn(6,maxinit);


for i = 1:maxinit
   
   %Q1 (Nelder Mead simplex method)
   logL = @(beta) -sum(-exp(X*beta) + y.*(X*beta)); % NICELY DROPPING THE THIRD TERM
   betaQ1 = fminsearch(logL,init(:,i));
   
   %Q2 (BFGS)
   options2 = optimoptions('fminunc','Algorithm','quasi-newton',...
              'SpecifyObjectiveGradient', true, 'Display', 'iter')
             
   betaQ2 = fminunc(@(beta) qfunc_ps3(X,y,beta),init(:,i),options2); % NICE GOING BY PROVIDING THE GRADIENT. 
   % DO YOU MEAN qfunc_HOMEWORK3.m?
   
   %Q3 (NLS) Q4 (NM) 
   RSS = @(beta) sum((y-exp(X*beta)).^2);
    
   betaQ3 = lsqnonlin(@(beta) RSS(beta),init(:,i));
   betaQ4 = fminsearch(RSS,init(:,i));
   
   b1(:,i) = betaQ1;
   b2(:,i) = betaQ2;
   b3(:,i) = betaQ3;
   b4(:,i) = betaQ4;
end


 %%% where are the time comparisons?
hold on; 

plot(b3(1,:))
plot(b1(1,:))
plot(b4(1,:))
plot(b2(1,:))
title('Beta 0 include all Q');
legend('Q3beta','Q1beta','Q4beta','Q2beta');
xlabel('Iterations');
ylabel('Beta Values');

pause;
close;

hold on;
plot(b3(2,:))
plot(b1(2,:))
plot(b4(2,:))
plot(b2(2,:))
title('Beta 1 include all Q');
legend('Q3beta','Q1beta','Q4beta','Q2beta');
xlabel('Iterations');
ylabel('Beta Values');

pause;
close;
%From visual inspection it is clear that, 4 and 3 are the worst performers,
%with 4 being the worst. 

%In order to compare 1 and 2, i drop 3 and 4 because they are too volatile.

hold on;
plot(b1(1,:))
plot(b2(1,:))
title('Beta 0 dropping Q3,4');
legend('Q1beta','Q2beta');
xlabel('Iterations');
ylabel('Beta Values');

pause;
close;

hold on;
plot(b1(2,:))
plot(b2(2,:))
title('Beta 1 dropping Q3,Q4');
legend('Q1beta','Q2beta');
xlabel('Iterations');
ylabel('Beta Values');

pause;
close;

hold on;
plot(b1(3,:))
plot(b2(3,:))
title('Beta 2 dropping Q3,Q4');
legend('Q1beta','Q2beta');
xlabel('Iterations');
ylabel('Beta Values');


hold off;

%Overall with the exception of Beta0, where Q2 outperforms Q1, it seems
%like Q1 consistently outperforms Q2 for all other Beta. 
%My final ranking for robustness is 1>2>3>4, where 1 is the most robust.