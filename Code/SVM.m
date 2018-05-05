
%clear all;
%close all;

%% Data loading %%
load('fisheriris.mat')
% Removing setosa %
inds = ~strcmp(species,'setosa');
%Add a dimension
X = meas(inds,1:4);
X(:,5)=ones(size(X,1),1); 

%Mapping
yLABELS = species(inds);
y=zeros(length(yLABELS),1);
idx1=strcmp(yLABELS,{'versicolor'});
y(idx1)=1;
idx_1=strcmp(yLABELS,{'virginica'});
y(idx_1)=-1;


% %Plot
% colors = 'rb';
% h = gscatter(X(:,1), X(:,3), yLABELS,colors,'o');
% for n = 1:length(h)
%   set(h(n), 'MarkerFaceColor', colors(n));
% end
% xlabel('Sepal length');
% ylabel('Sepal width');

%Splitting the data 

[trainInd,~,OptionaltestInd] = dividerand(size(X,1),0.8,0,0.2);

X_train=X(trainInd,:);
y_train=y(trainInd);
X_test=X(OptionaltestInd,:);
y_test=y(OptionaltestInd);



%% Optimisation %%

tau=0.01;
mu=100;
tol=0.001;
t=0.1;
nSamples=size(X_train,1);
x_0=ones(nSamples,1)/(2*nSamples*tau); % stricly feasible point
[Q,p,A,b] = transform_svm_dual(tau,X_train,y_train);
f = @( x,t ) phi (x,t ,Q, p ,A, b) ;
g = @( x ,t) grad (x,t ,Q, p ,A, b) ; % same
h = @( x,t) hessian (x,t ,Q, p ,A, b) ; % 

        %Barrier Method
lambda_sol = barr_method(Q,p,A,b,x_0,mu,tol);

        %Newton line search 
%lambda_sol=newtonLS(x_0,t,f,g,h,A,b,tol); % solution for  the dual


%% Prediction %%
A = bsxfun(@times, X_train, lambda_sol.*y_train);
w_sol=sum(A,1);
y_prediction_test = 2*double(X_test*w_sol' > 0 )-1;
y_prediction_train = 2*double(X_train*w_sol' > 0 )-1;

%% Performance %%
accuracy_test= mean(double(y_test==y_prediction_test));
accuracy_train = mean(double(y_train==y_prediction_train));
fprintf('Iris Data set - accuracy_test : %d .\n',accuracy_test);
fprintf('Iris Data set - accuracy_train : %d .\n',accuracy_train);





%% From now it's only for the Optional part  : random data set %%
m1 = [5,-3];
sigma1 = [1,1.5;1.5,3];
r1 = mvnrnd(m1,sigma1,100);
r1(:,3)=ones(size(r1,1),1);
y1=ones(size(r1,1),1);

m2 = [-5,-1];
sigma1 = [1,0;0,4];
r2 = mvnrnd(m2,sigma1,100);
r2(:,3)=ones(size(r2,1),1);
y2=-ones(size(r2,1),1);

OptionalX=[r1;r2];
Optionaly=[y1;y2];

%Splitting the data 

[OptionaltrainInd,~,OptionaltestInd] = dividerand(size(OptionalX,1),0.8,0,0.2);

OptionalX_train=OptionalX(OptionaltrainInd,:);
Optionaly_train=Optionaly(OptionaltrainInd);
OptionalX_test=OptionalX(OptionaltestInd,:);
Optionaly_test=Optionaly(OptionaltestInd);


%% Optimisation %%

tau2=0.1;
mu2=50;
tol2=0.001;
t2=0.1;
nSamples=size(OptionalX_train,1);
x_02=ones(nSamples,1)/(2*nSamples*tau2); % stricly feasible point
[Q2,p2,A2,b2] = transform_svm_dual(tau2,OptionalX_train,Optionaly_train);

lambda_sol2 = barr_method(Q2,p2,A2,b2,x_02,mu2,tol2);
tmp = bsxfun(@times, OptionalX_train, lambda_sol2.*Optionaly_train);
w_sol2=sum(tmp,1);



% Plot first class
Feature1_Train=OptionalX_train(:,1);
Feature2_Train=OptionalX_train(:,2);
figure(6)
scatter(Feature1_Train(Optionaly_train== 1), Feature2_Train(Optionaly_train == 1), 20, [0.4,0.7,0.9], 'filled')
% Plot second class.
hold on;
scatter(Feature1_Train(Optionaly_train == -1), Feature2_Train(Optionaly_train == -1), 20, [0.9,0.7,0.5], 'filled')



[x1,x2] = meshgrid(min(min(Feature1_Train),min(Feature2_Train))-0.5:0.1:max(max(Feature1_Train),max(Feature2_Train)) + 0.5); %# Create a mesh of x and y points
f = w_sol2(1)*x1 + w_sol2(2)*x2 + w_sol2(3);
contour(x1,x2,f,[0 0],'red','linewidth',2); hold on;
xlabel('x1'); 
ylabel('x2'); 
legend('1','-1','Decision Boundary')
title('SVM result')