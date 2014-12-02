x = [1,0,0,0,0,1,1,0,1,0;
    0,1,1,1,0,1,0,0,1,0;
    1,0,0,1,0,0,1,0,0,1;
    0,0,0,1,1,1,0,0,1,1;
    1,0,1,0,1,0,1,0,1,0;
    0,1,0,1,0,1,0,1,0,1;
    1,1,1,0,1,0,0,0,0,1;
    0,1,1,0,0,1,1,0,0,1;
    1,0,0,1,0,0,1,1,1,0;
    1,1,1,0,0,1,0,1,0,1];
[m,n] = size(x);
sim_users = zeros(m,m);
sim_items = zeros(n,n);
sum_column = sum(x);
sum_row = sum(x,2);
for u = 1:m-1
    for v = u+1:m
        for i = 1:n
            sim_users(u,v) = sim_users(u,v)+x(u,i)*x(v,i)/sqrt(sum_row(u,1)*sum_row(v,1)*sum_column(1,i));
            sim_users(v,u) = sim_users(u,v);
        end
    end
end
for i = 1:n-1
    for j = i+1:n
        for u = 1:m
            sim_items(i,j) = sim_items(i,j)+x(u,i)*x(u,j)/sqrt(sum_column(1,i)*sum_column(1,j)*sum_row(u,1));
            sim_items(j,i) = sim_items(i,j);
        end
    end
end
KNN_users = zeros(m,5);
for u = 1:m
    [values_users,sortIndex_users] = sort(sim_users(u,:),'descend');
    KNN_users(u,:) = sortIndex_users(1:5);    
end
KNN_items = zeros(n,5);
for i = 1:n
    [values_items,sortIndex_items] = sort(sim_items(i,:),'descend');
    KNN_items(i,:) = sortIndex_items(1:5);    
end
[index_row,index_column] = find(~x);
for s = 1:length(index_row)
    su = 0; si = 0;
    for t = 1:5
        index_v = KNN_users(index_row(s,1),t);
        temp_j = 0;
        for j = 1:n
            if x(index_row(s,1),j) == 1 && x(index_v,j) ==1
                temp_j = temp_j+1/sqrt(sum_column(1,j));
            end
        end
        su = su+x(index_v,index_column(s,1))*temp_j/sqrt(sum_row(index_v,1));
        index_j = KNN_items(index_column(s,1),t);
        temp_v = 0;
        for v = 1:m
            if x(v,index_column(s,1)) == 1 && x(v,index_j) == 1
                temp_v = temp_v+1/sqrt(sum_row(v,1));
            end
        end
        si = si+x(index_row(s,1),index_j)*temp_v/sqrt(sum_column(1,index_j));
    end
    x(index_row(s,1),index_column(s,1)) = (su+si)/sqrt(sum_row(index_row(s,1),1)*sum_column(1,index_column(s,1)));
end
