function [xnew,gap] = dampedNewtonStep(t,x,f,g,h)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

lambda2 = g(x,t)'*(h(x,t)\g(x,t))  ;

xnew  = x - (h(x,t)\g(x,t))/(1+sqrt(lambda2)) ;


gap = lambda2/2;  % a revoir : calcul ?????
end

