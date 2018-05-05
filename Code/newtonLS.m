function [xstar,xhist] = newtonLS(x_0,t,f,g,h,A,b,tol)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here


MAXITERS = 200;
ALPHA = 0.01;
BETA = 0.5;
MU = 100;
NTTOL = 1e-6;
m = size(A,1);
x = x_0;
histobj=[];

for iter = 1:MAXITERS
    
    v = -h(x,t)\g(x,t); fprime =g(x,t)'*v;
    xhist(:,iter)=v;
    
    s = 1; 
    
    while (min(b-A*(x+s*v)) <= 0)
        s = BETA*s;
    end;

    while (f(x+s*v,t) >= f(x,t) + ALPHA*s*fprime)
        s=BETA*s;
    end;

    x = x+s*v;
    
    if (-fprime < NTTOL)
        gap = m/t;
        if (gap < tol)
            break;
        end;
        t = MU*t;
         
    end;
    
    
    
    histobj=[histobj,[iter;m/t]]; % Bookkeeeping
   
    
   
end;

xstar=x;

%Gaps vs # of iterations 
gaps = histobj(2,:); 
niter = histobj(1,:);
%total_iter = cumsum(niter);
figure(4); semilogy(niter,gaps,'-','LineWidth',2,...
    'MarkerFaceColor',[.49 1 .63],...
    'MarkerSize',6);
title('Duality gap vs number of Newton iterations')
hold on;