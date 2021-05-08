P = dlmread('coords.txt');
Q = P(:,1);
R = P(:,2);
S = P(:,3);
figure; plot3(Q,R,S,'.-');
X = P.'
X = (P - repmat(mean(X),size(X,1),1))
X = (P - repmat(mean(P),[100 1])) ./ repmat(std(P),[100 1])
Cxx = cov(X)
[V, D] = eig(Cxx)