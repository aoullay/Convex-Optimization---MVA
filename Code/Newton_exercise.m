clear all;
close all;

%% Testing the Newton method : Line search and dampedNewton 


tol = 1e-3;
m = 100; n = 50;
x_0 = zeros(n,1); t = 1;
A = randn(m,n);
b = 1 + abs(randn(m,1));
Q=eye(n);
p=randn(n,1);



f = @(x,t) phi (x , t ,Q, p ,A, b) ;
g = @(x,t) grad (x , t ,Q, p ,A, b) ; % same
h = @(x,t) hessian (x , t ,Q, p ,A, b) ; % same


% Perform a newtonLS
xstar1= newtonLS(x_0,t,f,g,h,A,b,tol);

% Perform a damped Newton
%xstar2 = dampedNewton(x_0,t,f,g,h,A,tol);





