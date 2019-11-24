A=[1;2;3]
A=repelem(A,3)


B = [1;2;3]
B = repmat(B,3,1)

mu = 0.1;
beta = 0.5;
sigma = [1,0.5;0.5,1];
z=randn(10,2);

A = repmat([mu beta],10,1) + z*sigma
B = A(:,1);
A = A(:,2);