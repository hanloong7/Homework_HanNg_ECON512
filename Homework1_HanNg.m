
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
D = inv(A'*A)*b
E = sum(A(1,:)*b(1) + A(2,:)*b(2) + A(3,:)*b(3))


F = A;
F(2,:) = [];
F(:,3) = [];
F

x = inv(A)*b

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
