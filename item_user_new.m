<<<<<<< HEAD
x = [1,0,0,0,0,0,1,0,1;
    0,1,1,1,0,0,0,0,1;
    1,0,0,1,0,0,1,0,0;
    0,0,0,1,1,0,0,0,1;
    1,0,1,0,1,0,1,0,1;
    0,1,0,1,0,0,0,0,0;
    1,1,1,0,1,0,0,0,0;
    0,0,0,0,0,0,0,0,0;
    1,0,0,1,0,0,0,0,0;
    1,1,1,0,0,0,0,0,0];
load data
=======
% x = [1,0,0,0,0,1,1,0,1;
%     0,1,1,1,0,1,0,0,1;
%     1,0,0,1,0,0,1,0,0;
%     0,0,0,1,1,1,0,0,1;
%     1,0,1,0,1,0,1,0,1;
%     0,1,0,1,0,1,0,0,0;
%     1,1,1,0,1,0,0,0,0;
%     0,0,0,0,0,0,0,0,0;
%     1,0,0,1,0,0,0,0,0;
%     1,1,1,0,0,1,0,0,0];
load('data.mat');
test_file = fopen('u1.test');
C = textscan(test_file,'%d %d %d %d');
fclose(test_file);
>>>>>>> FETCH_HEAD

x = M_before;
% k = 5;
% [m,n] = size(x);
% sim_users = zeros(m,m);
% sim_items = zeros(n,n);
% sum_column = sum(x);
% sum_row = sum(x,2);
% 
% tic
% for u = 1:m-1
%     for v = u+1:m
%         sim_users(u,v) = x(u,:) * x(v,:)' / sqrt(sum(x(u,:)) * sum(x(v,:)));
%         sim_users(v,u) = sim_users(u,v);
%     end
% end
% 
% sim_users = (x * x')./sqrt(sum_row * sum_row'); 
% 
% 
% size(sum_row * sum_row')
% size(x * x')
% size(sum(x)' * sum(x))
% 
% sim_users(isnan(sim_users)) = 0;
% toc
% 
% tic 
% for i = 1:n-1
%     for j = i+1:n 
%         sim_items(i,j) = x(:,i)' * x(:,j) / sqrt(sum(x(:,i)) * sum(x(:,j)));
%         sim_items(j,i) = sim_items(i,j);
%     end
% end
% sim_items(isnan(sim_items)) = 0; 
% 
% toc
% 
% fprintf('Similarity calculated\n'); 
% 

<<<<<<< HEAD
sim_users = (x * x')./sqrt(sum_row * sum_row'); 
sim_users(isnan(sim_users)) = 0;

sim_items = (x' * x) ./sqrt(sum_column' * sum_column); 
sim_items(isnan(sim_items)) = 0; 

=======
for u = 1:m-1
    for v = u+1:m
        if sqrt(sum(x(u,:)) * sum(x(v,:))) > 0
            sim_users(u,v) = x(u,:) * x(v,:)' / sqrt(sum(x(u,:)) * sum(x(v,:))); 
            sim_users(v,u) = sim_users(u,v); 
        end
    end
end
for i = 1:n-1
    for j = i+1:n
        if sqrt(sum(x(:,i)) * sum(x(:,j))) > 0
            sim_items(i,j) = x(:,i)' * x(:,j) / sqrt(sum(x(:,i)) * sum(x(:,j)));
            sim_items(j,i) = sim_items(i,j);
        end
    end
end

KNN_users = zeros(m,k);
>>>>>>> FETCH_HEAD

KNN_users = zeros(m,k); 

for u = 1:m 
    [~,sortIndex_users] = sort(sim_users(u,:),'descend');
<<<<<<< HEAD
    KNN_users(u,:) = sortIndex_users(1:k);
=======
    KNN_users(u,:) = sortIndex_users(1:k); 
>>>>>>> FETCH_HEAD
end

KNN_items = zeros(n,k);

for i = 1:n
    [~,sortIndex_items] = sort(sim_items(i,:),'descend');
<<<<<<< HEAD
    KNN_items(i,:) = sortIndex_items(1:k);
=======
    KNN_items(i,:) = sortIndex_items(1:k);    
>>>>>>> FETCH_HEAD
end

item_result = zeros(20000,3);
user_result = zeros(20000,3);

<<<<<<< HEAD
item_result = zeros(m,n);
user_result = zeros(m,n);

for u = 1:m
    for i = 1:n
        su = 0;
        si = 0;
        
        % to calculate item_base result
        [hang1,lie1] = find(KNN_items == i);
        for v = 1:m 
            % following three rows to calculate the first Sigma
            temp_sum_column = (1 ./ sqrt(sum_column(1,:)) .* x(u,:) .* x(v,:))';
            temp_s_c_cleared = temp_sum_column(hang1,:);
            temp_j = nansum(temp_s_c_cleared);
            % the second sigma
            if sum_column(1,i) > 0
                si = si + x(v,i) * temp_j / sqrt(sum_column(1,i));
            end
        end
        item_result(u,i) = si;
        
        % to calculate user_base result.
        temp_s = x(:,i);
        index = KNN_users(u,:);
        t = temp_s(index',:);
        su = length(sum_column) / 5 * sum(t);
        user_result(u,i) = su; 
    end
=======
for iter = 1:20000
    u = C{1}(iter); i = C{2}(iter);
    si = 0;        
    % to calculate item_base result
    [hang1,lie1] = find(KNN_items == i);
    for v = 1:m
        % following three rows to calculate the first Sigma
        temp_sum_column = (1 ./ sqrt(sum_column(1,:)) .* x(u,:) .* x(v,:))';
        temp_s_c_cleared = temp_sum_column(hang1,:);
        temp_j = nansum(temp_s_c_cleared);
        % the second sigma
        if sum_column(1,i) > 0
            si = si + x(v,i) * temp_j / sqrt(sum_column(1,i));
        end
    end
    item_result(iter,1) = u; item_result(iter,2) = i;
    item_result(iter,3) = si;

    % to calculate user_base result. 
    temp_s = x(:,i);
    index = KNN_users(u,:);
    t = temp_s(index',:);
    su = length(sum_column) / 5 * sum(t);
    user_result(iter,1) = u; user_result(iter,2) = i;
    user_result(iter,3) = su;
>>>>>>> FETCH_HEAD
end
