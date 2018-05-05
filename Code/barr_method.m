function [x_sol] = barr_method(Q,p,A,b,x_0,mu,tol)
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here


m = size(A,1);
t = 1;
x=x_0;
MAXITERS=200;
tol1=1e-4;

f = @(x,t) phi (x , t ,Q, p ,A, b) ;
g = @(x,t) grad (x , t ,Q, p ,A, b) ; % same
h = @(x,t) hessian (x , t ,Q, p ,A, b) ; % same


hist=[];


for k=1:MAXITERS % Inner loop
        
    [x,gap] = dampedNewtonStep(t,x,f,g,h);
        
    if (abs(gap) < tol1)
        gap_barr = m/t;
        if (gap_barr < tol)
            break;
        end;
        t = mu*t; %shrink
    end;

    hist=[hist,[k;m/t]]; % Bookkeeeping
        
end
    

x_sol=x;

%Gaps vs # of iterations 
gaps = hist(2,:); 
niter = hist(1,:);
%total_iter = cumsum(niter);
figure(5); semilogy(niter,gaps,'-','LineWidth',2,...
    'MarkerFaceColor',[.49 1 .63],...
    'MarkerSize',6);
title('Duality gap vs number of Newton iterations')
hold on;

