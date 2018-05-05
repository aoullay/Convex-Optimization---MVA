function [ G ] = grad(x,t,Q, p ,A, b)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

contrainte = b-A*x;
G =t*(Q*x+p) + A'*(1./contrainte);


end
