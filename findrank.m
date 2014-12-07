function a = findrank(i, j) 
    [~, B] = sort(i(:, 3)); 
    a = find(B == j); 
end