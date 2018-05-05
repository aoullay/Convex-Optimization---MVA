function [ Hessian ] = hessian(x ,t,Q, p ,A, b)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

contrainte = b-A*x;
Hessian = t*Q + A'*diag(1./contrainte.^2)*A;



end

