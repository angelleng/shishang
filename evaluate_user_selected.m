%%%%%% EVALUATION -Random Selected Setup %%%%%
% Input: T: matrix, training data, rows-user, columns-items, P: matrix, prediction data 

% Input: T: test data, in form of user-item pair listing; P: predicted
% data, in form of user-item pair listing. 

function [HR10, ARHR10, AUC] = main() % main(T, P) 
fileID = fopen('u1.base');
C = textscan(fileID, '%d %d %d %d'); 
fclose(fileID);
T = [C{1}, C{2}, C{3}]; 
%%  sample matrix for testing purpose 
% T = zeros(10, 15); 
% P = zeros(10, 15); 
% tp = [1:10]; 
% 
% P = repmat(1:15, n, 1);
% T(1, [3,4,5]) = 1; 
% T(4, [2,4,7,15,13]) = 1;  
% T(5, [3,5,8,14,12]) = 1;  
% T(7, [2,4,7,15,13]) = 1;  
% T(8, [2,4,8,10,13]) = 1;  

%% Calculate HR10, ARHR10 and AUC^{AMAN} 
T(T(:, 3) < 4, 3) = 0; 
T(T(:, 3) > 3, 3) = 1; 
userset = unique(T(:,1)); 

nofitems = sum((repmat(T(:,1), 1, size(userset, 1))) == (repmat(userset', size(T, 1), 1)));

test = mat2cell(T, nofitems); 
exclude = find(cellfun(@(i) sum(i(:, 3)), test) < 2); 
tmp = true(size(userset,1), 1); 
tmp(exclude) = 0; 
test = test(tmp);  

P = T; 
P(:, 3) = randperm(size(P,1)); 
pred = mat2cell(P, nofitems); 
pred = pred(tmp); 

n = size(test); 

testpreference = cellfun(@(i) randsample(find(i(:,3) == 1), 1), test, 'UniformOutput', false); 

% function a = findrank(i, j) 
%     [~, B] = sort(i(:, 3)); 
%     a = find(B == j); 
% end

ddd = cellfun(@findrank, pred, testpreference);  
HR10 = 1/size(test, 1)*sum(ddd < 10);
ARHR10 = 1/size(test, 1)*sum((ddd < 10)./sum(ddd)); 
ARHR10 
AUC = 1/size(test, 1)*sum( cellfun(@(i) size(unique(i(:,2),1) - ddd) ./ (size(test, 2) - 1)); 

% 
% [n,m] = size(T) %n: number of users, m: number of items 
% T_t = T(sum(T, 2) > 1,:); % select users with more than one preferences 
% P_t = P(sum(T, 2) > 1,:); 
% 
% C = num2cell(T_t, 2); 
% 
% tmp = cellfun(@(i) find(i > 0), C, 'UniformOutput', false); 
% testind = cellfun(@(i) randsample(i, 1), tmp); % generating 
% 
% indices = sub2ind(size(T_t), 1:size(testind), testind') 
% P_t(indices) 
% 
% [A,B] = sort(P_t, 2, 'descend')
% 
% P_t(indices)' > A(:, 10) 
% 
% HR10 = 1/size(T_t, 1)*sum(P_t(indices)' > A(:, 10)); 
% HR10
% 
% rank = find(B == repmat(testind, 1, size(T, 2)));
% 
% [a, b] = ind2sub([5, 15], rank);
% rank = sortrows([a, b]);
% rank = rank(:, 2); 
% 
% sub2ind(size(T_t), a, b);
% 
% ARHR10 = 1/size(T_t, 1)*sum((P_t(indices)' > A(:, 10))./ rank); 
% ARHR10
% 
% AUC = 1/size(T_t, 1)*sum((size(T_t, 2) - rank) ./ (size(T_t, 2) - 1)); 
% 
% 
% 
