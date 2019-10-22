function [returnVal] = Int_simp(f,a,b,N)

%Simpsons Rule
h = (b-a)/N;
X = a:h:b;

w=4*ones(length(X),1);
w(1) = 1;
w(end) = 1;
evens = 2:2:N;
w(evens) = 2;
w=h/3*w;

fv = f(X);

returnVal = fv*w;

end