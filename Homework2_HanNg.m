%% Econ 512 Problem Set 2 by Han Ng
clear all

% Define demand functions for A,B, and outside goods

Di = @(qi,pi,qj,pj) exp(qi - pi)/(1 + exp(qi - pi) + exp(qj - pj));
D0 = @(qi,pi,qj,pj) 1/(1 + exp(qi - pi) + exp(qj - pj));

%% Problem 1

q = 2;
p = 1;

DA = Di(q,p,q,p)
DB = Di(q,p,q,p)

%% Problem 2

DA = @(pA,pB) Di(2,pA,2,pB);
DB = @(pB,pA) Di(2,pB,2,pA);

f = @(pA,pB) [DA(pA,pB)*(1-pA*(1-DA(pA,pB)));DB(pB,pA)*(1-pB*(1-DB(pB,pA)))];

f= @(p) [DA(p(1),p(2))*(1-p(1)*(1-DA(p(1),p(2))));DB(p(2),p(1))*(1-p(2)*(1-DB(p(2),p(1))))];

p=[1;1];
fval = f(p);
iJac = inv(myJac(f,p));

maxit = 100;
tol = 1e-6;
tic
for iter = 1:maxit
    fnorm = norm(fval);
    fprintf('iter %d: p(1) = %f, p(2) = %f, norm(f(x)) = %.8f\n', iter, p(1), p(2), norm(fval));
    if norm(fval) < tol
        break
    end
    d = - (iJac * fval);
    p = p + d;
    fOld = fval;
    fval = f(p);
    u = iJac*(fval - fOld);
    iJac = iJac + ((d-u)*(d'*iJac))/(d'*u);
end
toc

%% Problem 3

DA = @(pA,pB) Di(2,pA,2,pB);
DB = @(pB,pA) Di(2,pB,2,pA);


f= @(p) [DA(p(1),p(2)); DB(p(2),p(1))];
p=[0;0];
Jac = myJac(f,p);
maxit = 100;
tol = 1e-8;


for it = 1:maxit
    
    fval = f(p);
    
    %Use secant method to find p(1);
    FOC1 = @(x) Jac(1,1)*x + DA(x,p(2));
    new_p1 = secant(FOC1,randn(1));
    
    %In spirit of Gauss-Seidel;
    FOC2 = @(x) Jac(2,2)*x + DB(x,new_p1);
    new_p2 = secant(FOC2,randn(1));
    
    %Update Jacobian;
    Jac(1,1) = (DA(new_p1,p(2)) - DA(p(1),p(2)))/(new_p1 - p(1));
    Jac(2,2) = (DB(new_p2,p(1)) - DB(p(2),p(1)))/(new_p2 - p(2));
    
    dp = p - [new_p1; new_p2];
    p = [new_p1; new_p2];
    
    if norm(dp) < tol
        fprintf('Converged: p(1) = %.4f, p(2) = %.4f, iter = %d\n', p(1), p(2), it);
        break
    else
        fprintf('iter %d: p(1) = %f, p(2) = %f, norm(f(x)) = %.8f\n', it, p(1), p(2), norm(dp));
    end        
end

%% Problem 4

tol = 1e-8;
DA = @(pA,pB) Di(2,pA,2,pB);
DB = @(pB,pA) Di(2,pB,2,pA);

p=[0;0];

h = @(p) [1/(1-DA(p(1),p(2))); 1/(1-DB(p(2),p(1)))];
f= @(p) [DA(p(1),p(2))*(1-p(1)*(1-DA(p(1),p(2))));DB(p(2),p(1))*(1-p(2)*(1-DB(p(2),p(1))))];

maxit = 100;
count = 0;
tic
for it = 1:maxit
    pnew = h(p);
    fval = pnew - p;
    fprintf('iter %d: p(1) = %f, p(2) =%f, norm(f(x)) = %.8f\n', it, p(1),p(2), norm(fval));
    if norm(fval)<tol
        break
        
    else
        p = pnew;
    end
end
toc

%% Problem 5

vA = 2;
count = 0;
for vB = 0:.2:3
    count = count + 1;
    DA = @(pA,pB) Di(vA,pA,vB,pB);
    DB = @(pB,pA) Di(vB,pB,vA,pA);
    
    f= @(p) [DA(p(1),p(2))*(1-p(1)*(1-DA(p(1),p(2))));DB(p(2),p(1))*(1-p(2)*(1-DB(p(2),p(1))))];
    p=[1;1];
    fval = f(p);
    
    iJac = inv(myJac(f,p));

    maxit = 100;
    tol = 1e-6;
    
    for iter = 1:maxit
        fnorm = norm(fval);
        %fprintf('iter %d: p(1) = %f, p(2) = %f, norm(f(x)) = %.8f\n', iter, p(1), p(2), norm(fval));
        if norm(fval) < tol
           break
        end
        d = - (iJac * fval);
        p = p + d;
        fOld = fval;
        fval = f(p);
        u = iJac*(fval - fOld);
        iJac = iJac + ((d-u)*(d'*iJac))/(d'*u);
    end
    price1(:,count) = p(1);
    price2(:,count) = p(2);
end

x=[0:0.2:3];
hold on;
plot(x,price1);
plot(x,price2);
legend('p1','p2');
xlabel('v2');
ylabel('p1,p2');
hold off;