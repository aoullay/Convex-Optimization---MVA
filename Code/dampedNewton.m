function xstar = dampedNewton(x_0,t,f,g,h,A,tol)


tol1=1e-6;
x = x_0;

MU=20;
MAXITERS=300;
m=size(A,1);


histobj=[];
%while (t <= 1e4), % Outer loop

    for k=1:MAXITERS % Inner loop
        
        [x,gap] = dampedNewtonStep(t,x,f,g,h);
        
        if (abs(gap) < tol1)
            gap_barr = m/t;
            if (gap_barr < tol)
                break;
            end;
            t = MU*t;
            
        end;

        histobj=[histobj,[k;m/t]]; %
        
    end
    
    
%end
xstar=x;

%Gaps vs # of iterations 
gaps = histobj(2,:); 
niter = histobj(1,:);
%total_iter = cumsum(niter);
figure; semilogy(niter,gaps,'-');
