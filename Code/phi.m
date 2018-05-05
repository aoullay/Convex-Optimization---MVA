function [ cost_function ] = phi(x,t,Q,p,A,b)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
contrainte=b-A*x;
cost_function = t*(.5*x'*Q*x + p'*x) - sum(log(contrainte));

end

