P = dlmread('coords.txt');

Q = P(:,1);
R = P(:,2);
S = P(:,3);
figure; plot3(Q,R,S,'.-');

[M,N] = size(P);

% subtract off the mean for each dimension (centering)
mn =  mean(P,2);

%% 
% If you don't center the data, the first eigenvector (i.e the one with 
% largest eigenvalue) will be roughly collinear to the mean vector.
% 
% Since PCA is constrained to give an orthogonal basis set, all other directions 
% will be orthogonal to teh mean vector. These are not the directions
% 
% of maximum variance. Removing the mean gives the correct covariance and 
% eigendecomposition.

% Normalization by mean subtraction

X = P.'

% calculate the covariance matrix
Cxx = cov(X);

% find the eigenvectors and eigenvalues
[V, D] = eig(Cxx);

%% Load data and reshape

[M,N,numImages]=size(P);
numPixels=M*N;
S = reshape(P,numPixels,numImages);

%% Labels for images

% Image labels
labels= zeros(1, numImages);
labels(1:500)=1;
labels(501:end)=7;

%% SVD and reconstructing the covariance

% SVD
[w1,w2,w3] = svd(X,'econ');
lambdas = diag(w2'/(numImages-1)); % eigenvalues of Cxx
W = w1*(w2*w2')*w1'/(numImages-1); % columns of U form an orthonormal basis set for Q
%% These directions are constrained to be orthogonal.
%% Variance explained per PC

% Variance explained per PC
Var_expl =100 * cumsum(lambdas)./sum(lambdas);

figure(1);
subplot(1,2,1)
plot(V, 'DisplayName', 'V')
title('Scree plot')
xlabel('Eigenvalue #')
ylabel('Eigenvalue magnitude')

subplot(1,2,2)
plot(D, 'DisplayName', 'D')
title('Cumulative variance explained')
xlabel('Eigenvalue #')
ylabel('Cumulative % Variance')
%% 
% The first 2 components capture approxiamtely 37% of the data variance 
%% 
% These images represent the pixel intensity patterns or features that capture 
% most of the variability in the image. Pixels with high intensities will in general 
% covariate well.
%% Rotate mean subtracted data and visualize projections

Y1 = W'*X;
figure
plot(Y1, 'DisplayName', 'Y1')
hold on
xlabel('PC1', 'fontsize', 20)
ylabel('PC2', 'fontsize', 20)
%set(gcf, 'color', 'w')
%set(gca, 'fontsize', 16)
hold off
box off

Y2 = W*W'*X;
figure
plot(Y2, 'DisplayName', 'Y2')
hold on
xlabel('PC1', 'fontsize', 20)
ylabel('PC2', 'fontsize', 20)
%set(gcf, 'color', 'w')
%set(gca, 'fontsize', 16)
hold off
box off