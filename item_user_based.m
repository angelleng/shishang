x = [1,0,0,0,0,1,1,0,1;
    0,1,1,1,0,1,0,0,1;
    1,0,0,1,0,0,1,0,0;
    0,0,0,1,1,1,0,0,1;
    1,0,1,0,1,0,1,0,1;
    0,1,0,1,0,1,0,1,0;
    1,1,1,0,1,0,0,0,0;
    0,1,1,0,0,1,1,0,0;
    1,0,0,1,0,0,1,1,1;
    1,1,1,0,0,1,0,1,0];

k = 5;
[m,n] = size(x);
sim_users = zeros(m,m);
sim_items = zeros(n,n);
sum_column = sum(x);
sum_row = sum(x,2);

for u = 1:m-1
    for v = u+1:m
        sim_users1(u,v) = x(u,:) * x(v,:)' / sqrt(sum(x(u,:)) * sum(x(v,:))); 
        sim_users1(v,u) = sim_users1(u,v); 
    end
end
for i = 1:n-1
    for j = i+1:n
        sim_items1(i,j) = x(:,i)' * x(:,j) / sqrt(sum(x(:,i)) * sum(x(:,j)));
        sim_items1(j,i) = sim_items1(i,j);
    end
end

KNN_users = zeros(m,k);

for u = 1:m
    [~,sortIndex_users] = sort(sim_users1(u,:),'descend');
    KNN_users(u,:) = sortIndex_users(1:k);    
end

KNN_items = zeros(n,k);

for i = 1:n
    [~,sortIndex_items] = sort(sim_items1(i,:),'descend');
    KNN_items(i,:) = sortIndex_items(1:k);    
end

item_result = zeros(m,n);
user_result = zeros(m,n);

for u = 1:m
    for i = 1:n
        su = 0;
        si = 0;
        for t = 1:k
%             to calculate item_base result
            index_v = KNN_users(u,t);
            temp_j = 0;
            temp_sum_column = 1 ./ sqrt(sum_column(1 , :)) .* x(u , :)  .* x(index_v , :);
            temp_j = nansum(temp_sum_column);
            si = si + x(index_v,i) * temp_j / sqrt(sum_column(1,i));
            
%             to calculate user_base result
            index_j = KNN_items(i,t);
            temp_v = 0;
            temp_sum_row = 1 ./ sqrt(sum_row(: , 1)) .* x(: , i) .* x(: , index_j);
            temp_v = nansum(temp_sum_row);
            su = su + x(u,index_j) * temp_v / sqrt(sum_row(u,1));
        end
        item_result(u,i) = si;
        user_result(u,i) = su;
    end    
end
