load step1.txt;
M = zeros(5,5);
for i = 1:5;
    M(step1(i,1),step1(i,2)) = step1(i,3)>3;
end
save ('test', 'M'); 
    
