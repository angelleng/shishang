function [ X ] = wALS( R , d)
%input
%   R: data matrix
%   d: rank
%output
%   X: low rank approximation
tic
[m,n] = size(R);
W = R;
lambda = 0.1;
alpha = 1;
delta = alpha*sum(sum(W))/sum(sum(W==0));
W(W==0) = delta;
U = zeros(m,d);
V = normrnd(0,0.01,n,d);
J_new = sum(sum(W.*((R-U*V').^2+lambda*(repmat(sum(U.*U,2),1,n)+repmat(sum(V'.*V',1),m,1)))));
while(1)
    J_old = J_new;
    for i = 1:m
        U(i,:) = R(i,:)*diag(W(i,:))*V*(V'*diag(W(i,:))*V+lambda*sum(W(i,:))*eye(d))^-1;
    end
    for j = 1:n
        V(j,:) = R(:,j)'*diag(W(:,j))*U*(U'*diag(W(:,j))*U+lambda*sum(W(:,j))*eye(d))^-1;
    end
    J_new = sum(sum(W.*((R-U*V').^2+lambda*(repmat(sum(U.*U,2),1,n)+repmat(sum(V'.*V',1),m,1)))));
    if abs(J_new-J_old) < J_old*10^-6
        break
    end
end
X = U*V';
toc
