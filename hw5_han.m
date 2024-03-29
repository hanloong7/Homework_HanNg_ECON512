% LOOKS GOOD. YOU GET A CHECK PLUS

clear all;
load hw5.mat;
rng(1);

% Parameter
beta = 0.1;
sigma = 1;
gamma = 0;
addpath('../CEtools/');

%% Question 1,2 

hw5q1(beta,sigma,gamma,data,20)
hw5q2(beta,sigma,gamma,data,100)

%% Question 3
hw5q3_q1 = @(parm) -hw5q1(parm(1), parm(2), parm(3),data,20);
hw5q3_q2 = @(parm) -hw5q2(parm(1), parm(2), parm(3),data,100);
x0 = [0.1,1,0]';
[parm_opt_q3q1,loglval_q3q1] = fmincon(hw5q3_q1,x0)
[parm_opt_q3q2,loglval_q3q2] = fmincon(hw5q3_q2,x0)

x0=[x0;0];
GQ = [parm_opt_q3q1;loglval_q3q1];
MC = [parm_opt_q3q2;loglval_q3q2];
dis = [GQ,MC,x0];
rowNames={'beta','sigmaB','gamma','loglikelihood'};
colNames={'GQ','MC','Init'};
sTable = array2table(dis,'RowNames',rowNames ...
    ,'VariableNames',colNames)

%% Question 4

% BETTER TO MAXIMIZE OVER CHOLESKY DECOMPOSITION
hw5q4MC_run = @(parm) -hw5q4MC(parm(1),parm(2),parm(3),parm(4),parm(5),parm(6),data,100);
hw5q4GQ_run = @(parm) -hw5q4GQ(parm(1),parm(2),parm(3),parm(4),parm(5),parm(6),data,20);
x0 = [2.5,1.1,1,0.7,0,-0.5]';
%x0 =[0.1,1,0.1,1,0.8,0]';
[parm_opt_q4MC,loglval_q4MC] = fmincon(hw5q4MC_run,x0);
[parm_opt_q4GQ,loglval_q4GQ] = fmincon(hw5q4GQ_run,x0);

x0=[x0;0];
GQ = [parm_opt_q4GQ;loglval_q4GQ];
MC = [parm_opt_q4MC;loglval_q4MC];
dis = [GQ,MC,x0];

rowNames={'beta','sigmaB','mu','sigmaU','sigmaUB','gamma','loglikelihood'};
colNames={'GQ','MC','Init'};
sTable2 = array2table(dis,'RowNames',rowNames ...
    ,'VariableNames',colNames)