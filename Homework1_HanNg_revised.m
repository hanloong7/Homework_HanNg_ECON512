
%Q1
X = [1,1.5,3,4,5,7,9,10];

y1 = -2 + 0.5*X;
y2 = -2 + 0.5*X.^2;

hold on
plot(X,y1)
plot(X,y2)
hold off

%Q2
X = linspace(-10,20,200)';
S = sum(X)

%Q3

A = [2,4,6;1,7,5;3,12,4];
b = [-2;3;10];

C = A'*b
D = inv(A'*A)*b % more efficient to use
E = sum(A(1,:)*b(1) + A(2,:)*b(2) + A(3,:)*b(3))
% keep it simple: E = sum(b'*A)


F = A;
F(2,:) = [];
F(:,3) = [];
F
% keep it simple: F = A([1,3],1:2)

x = inv(A)*b % use /

%Q4

B = blkdiag(A,A,A,A,A)

%Q5

A = normrnd(10,5,[5,3])
B = A >= 10;
B = double(B)

%Q6

%Please get the data on Git
Data = csvread('datahw1.csv');
Y = Data(:,5);
X = [ones(size(Y)), Data(:,3),Data(:,4),Data(:,6)];
k = 4;

beta_hat = inv(X'*X)*X'*Y;

sigma_hat = ((Y-X*beta_hat)'*(Y-X*beta_hat))/(length(Y)-k);
V = sigma_hat*inv(X'*X);
SE = sqrt(diag(V));

%point estimate
beta_hat 

%SE
SE

% your approach assumes you have no NaNs. Consider doing:
% import data as table
dat = readtable('datahw1.csv','ReadVariableNames',false);

% give variables names
dat.Properties.VariableNames = {'firm_id','year','Export','RD','prod','cap'};
% create deletion index to remove observations with NaNs
del_ind = sum(isnan(dat{:,:}),2);
% delete rows with NaNs 
dat(del_ind>0,:) = [];

% estimate linear model by matlab econometrics toolbox (it will
% automatically ignore NaNs, but you should inspect data for it anyway)
lm1 = fitlm(dat,'prod~Export+RD+cap');
% display all the statistics of estimation 
lm1

% or display only coefficients and standard errors
fprintf('beta \t\t SE \n');
fprintf('%f \t %f \n', lm1.Coefficients.Estimate, lm1.Coefficients.SE);

