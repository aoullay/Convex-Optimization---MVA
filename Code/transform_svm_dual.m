function [Q,p,A,b] = transform_svm_dual(tau,X,y)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

    n = size(X, 1);
    Q = (diag(y)*X*(X')*diag(y));
    p = -ones(n,1);
    A = [eye(n); -eye(n)];
    b = [ones(n,1)/(n*tau); zeros(n,1)];
end

