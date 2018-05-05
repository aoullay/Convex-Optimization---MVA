clear all;

%% Testing the Barrier method %%

tol = 1e-4; % precision
m = 100; n = 50; % m = number of constraints / n = X size 
x_0 = zeros(n,1);  % initialization
t = 1;
A = randn(m,n);
b = 1 + abs(randn(m,1));
Q=eye(n);
p=randn(n,1);
mu=20;  % shrink amplitude

x_sol = barr_method(Q,p,A,b,x_0,mu,tol);



