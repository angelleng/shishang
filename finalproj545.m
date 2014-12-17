%%%%%% 545 Final %%%%%% 



%% Evaluating performances 
fileID = fopen('u1.test'); 
C = textscan(fileID, '%d %d %d %d'); 
fclose(fileID); 
user = C{1}; 
item = C{2}; 
rating = C{3}; 

T = [user, item, rating > 3]; 

%% Baseline: Pop 
M = M_before; 
[a, b] = sort(sum(M), 'descend'); 
popularity = sum(M); 
pop = T; 
pop(:, 3) = popularity(pop(:,2)); 


fileID = fopen('wALS_output.txt'); 
C = textscan(fileID, '%d %d %f %d'); 
fclose(fileID); 
user = C{1}; 
item = C{2}; 
rating = C{3}; 

P = zeros(20000, 3); 
length(user) 
P(:,1) = user; 
P(:, 2) = item; 
P(:, 3) = rating; 

Pnew = dlmread('wALS_output.txt', '\t'); 
random = T; 
random(:, 3) = randperm(20000); 
load KUNN_output 

scores_WALS = []; 
for i = 1:50 
[a, b, c] = evaluate_user_selected(T, Pnew); 
scores_WALS = [scores_WALS; a, b, c]; 
end 

scores_random = []; 
for i = 1:50 
[a, b, c] = evaluate_user_selected(T, random);
scores_random = [scores_random; a, b, c]; 
end 

scores_KUNN = []; 
for i = 1:50 
[a, b, c] = evaluate_user_selected(T, result);
scores_KUNN = [scores_KUNN; a, b, c]; 
end 

scores_POP = [];
for i = 1:50 
[a, b, c] = evaluate_user_selected(T, pop);
scores_POP = [scores_POP; a, b, c]; 
end 


scores_item = [];
for i = 1:50 
[a, b, c] = evaluate_user_selected(T, item_result);
scores_item = [scores_item; a, b, c]; 
end 

scores_user = [];
for i = 1:50 
[a, b, c] = evaluate_user_selected(T, user_result);
scores_user = [scores_user; a, b, c]; 
end 

mean(scores_random)
mean(scores_WALS) 
mean(scores_KUNN) 
mean(scores_POP)
mean(scores_item) 
mean(scores_user)









