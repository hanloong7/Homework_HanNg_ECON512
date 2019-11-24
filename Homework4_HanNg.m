% GOOD! YOU GET A CHECK PLUS!
%% Problem Set 4 ECON512 by Han Ng
clear all;
%% Question (a) 

%part 1 (MC)
X= haltonseq(500,2);
X = (X(:,1).^2 + X(:,2).^2<=1);
area_QMC = 4*sum(X)/length(X)

%part 2 (Newton-Coates with simpsons rule)
% DOES THIS USE NEWTON-COATES?
f = @(x,y) 1.*(x.^2+y.^2<=1)
area = 4* integral2(f,0,1,0,1)

%Don't know how to fix y and integrate over x
%fx = @(x) Int_simp(f(x,y),0,1,500)
%area = Int_simp(fx,0,1,500)
%% Question (b) 

% OK!

%parameters 
%(I allow lower and upper bound of integral to change from 0,1)
% ARE YOU DOING THE CORRECT NORMALIZATION FOR THE HALTON SEQUENCE?
lb = 0;
ub = 1;
f = @(x) sqrt(1-x.^2);

%Q1 and Q2
QMC = 4*QMC_cal(f,lb,ub,haltonseq(500,1))
NC = 4*Int_simp(f,lb,ub,1000) % WHY DONT YOU USE QNWTRAP?
RealArea = 4*integral(f,lb,ub)

repmax = 200;

clear QMC;
for n = 1:4
   N = 10^n; 
   
   NC(n) = (Int_simp(f,lb,ub,N) - integral(f,lb,ub)).^2; 
   QMC(n) = (QMC_cal(f,lb,ub,haltonseq(N,1))-integral(f,lb,ub)).^2;
   
   
   for r = 1:repmax
     X = lb + (ub-lb)*rand(N,1);
     X = sqrt(1-X.^2);
     Area(r) = (ub-lb)*mean(X);
   end
   PMC(n) = mean((Area - integral(f,lb,ub)).^2);
end

[PMC' QMC' NC']

%NC>QMC>PMC
