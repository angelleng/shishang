fileID = fopen('u1.base'); 
C = textscan(fileID, '%d %d %d %d'); 
fclose(fileID); 
user = C{1}; 
item = C{2}; 
rating = C{3}; 

n = size(unique(user), 1); 

m = max(unique(item)); 

M = zeros(n, m); 

ind = sub2ind([n, m], user, item); 
M(ind) = rating > 3; 

M_before = M; 

tmp = sum(M, 2); 
tmp2 = sum(M, 1); 
M = M(tmp > 0, tmp2 > 0);  
M_after = M; 
