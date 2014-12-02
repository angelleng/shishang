%%%%%% EVALUATION %%%%%
% Input: T: matrix, training data, rows-user, columns-items, P: matrix, prediction data 
function [HR10, ARHR10, AUC] = main(T, P) 
T = zeros(10, 15); 
P = zeros(10, 15); 
tp = [1:10]; 

P = repmat(1:15, n, 1);
T(1, [3,4,5]) = 1; 
T(4, [2,4,7,15,13]) = 1;  
T(5, [3,5,8,14,12]) = 1;  
T(7, [2,4,7,15,13]) = 1;  
T(8, [2,4,8,10,13]) = 1;  
[n,m] = size(T) %n: number of users, m: number of items 
T_t = T(sum(T, 2) > 1,:); 
P_t = P(sum(T, 2) > 1,:); 

C = num2cell(T_t, 2); 

tmp = cellfun(@(i) find(i > 0), C, 'UniformOutput', false); 
testind = cellfun(@(i) randsample(i, 1), tmp); 

[[1:size(testind)]',testind]

indices = sub2ind(size(T_t), 1:size(testind), testind')
P_t(indices)

[A,B] = sort(P_t, 2, 'descend')

P_t(indices)' > A(:, 10) 

HR10 = 1/size(T_t, 1)*sum(P_t(indices)' > A(:, 10)); 
HR10

rank = find(B == repmat(testind, 1, size(T, 2)))

[a, b] = ind2sub([5, 15], rank)
rank = sortrows([a, b])
rank = rank(:, 2); 

sub2ind(size(T_t), a, b)

ARHR10 = 1/size(T_t, 1)*sum((P_t(indices)' > A(:, 10))./ rank); 
ARHR10









