%%%%%% 545 Final %%%%%% 

%% Baseline: Pop 
M = M_before; 
[a, b] = sort(sum(M), 'descend'); 
popularity = sum(M); 
pop = T; 
pop(:, 3) = popularity(pop(:,2)); 

%% Evaluating performances 
fileID = fopen('u1.test'); 
C = textscan(fileID, '%d %d %d %d'); 
fclose(fileID); 
user = C{1}; 
item = C{2}; 
rating = C{3}; 

T = [user, item, rating > 3]; 

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

scores1 = []; 
for i = 1:10 
[a, b, c] = evaluate_user_selected(T, Pnew); 
scores1 = [scores1; a, b, c]; 
end 

scores2 = []; 
for i = 1:10 
[a, b, c] = evaluate_user_selected(T, random);
scores2 = [scores2; a, b, c]; 
end 

scores3 = []; 
for i = 1:10 
[a, b, c] = evaluate_user_selected(T, result);
scores3 = [scores3; a, b, c]; 
end 

scores4 = [];
for i = 1:10 
[a, b, c] = evaluate_user_selected(T, pop);
scores4 = [scores4; a, b, c]; 
end 

mean(scores1) 
mean(scores2)
mean(scores3) 
mean(scores4)











