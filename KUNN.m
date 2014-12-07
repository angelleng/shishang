x = [1,0,0,0,0,1,1,0,1,0;
    0,1,1,1,0,1,0,0,1,0;
    1,0,0,1,0,0,1,0,0,0;
    0,0,0,1,1,1,0,0,1,0;
    1,0,1,0,1,0,1,0,1,0;
    0,1,0,1,0,1,0,1,0,0;
    1,1,1,0,1,0,0,0,0,0;
    0,1,1,0,0,1,1,0,0,0;
    1,0,0,1,0,0,1,1,1,0;
    1,1,1,0,0,1,0,1,0,0];
tmp = sum(M, 2); 
tmp2 = sum(M); 
M = M(tmp > 0, tmp2 > 0); 
x = M; 
k = 5;
[m,n] = size(x);
sim_users = zeros(m,m);
sim_items = zeros(n,n);
sum_column = sum(x);
sum_row = sum(x,2);
for u = 1:m-1
    for v = u+1:m
        sim_users(u, v) = (x(u,:) ./ sqrt(sum_column)) * x(v,:)'/sqrt(sum(x(u,:)) * sum(x(v,:))); 
        sim_users(v, u) = sim_users(u, v); 
    end
end
for i = 1:n-1
    for j = i+1:n
        sim_items(i, j) = (x(:,i) ./ sqrt(sum_row))' * x(:,j)/sqrt(sum(x(:,i)) * sum(x(:,j)));
        sim_items(j, i) = sim_items(i, j); 
    end
end
KNN_users = zeros(m,k);
for u = 1:m
    [~,sortIndex_users] = sort(sim_users(u,:),'descend');
    KNN_users(u,:) = sortIndex_users(1:k);    
end
KNN_items = zeros(n,k);
for i = 1:n
    [~,sortIndex_items] = sort(sim_items(i,:),'descend');
    KNN_items(i,:) = sortIndex_items(1:k);    
end
result = zeros(m,n);
for u = 1:m
    for i = 1:n
        su = 0; si = 0;
        for t = 1:k
            index_v = KNN_users(u,t);
            temp_j = 0;
            for j = 1:n
                if x(u,j) == 1 && x(index_v,j) ==1
                    temp_j = temp_j+1/sqrt(sum_column(1,j));
                end
            end
            su = su+x(index_v,i)*temp_j/sqrt(sum_row(index_v,1));
            index_j = KNN_items(i,t);
            temp_v = 0;
            for v = 1:m
                if x(v,i) == 1 && x(v,index_j) == 1
                    temp_v = temp_v+1/sqrt(sum_row(v,1));
                end
            end
            si = si+x(u,index_j)*temp_v/sqrt(sum_column(1,index_j));
        end
        result(u,i) = (su+si)/sqrt(sum_row(u,1)*sum_column(1,i));
    end    
end
