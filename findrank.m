function a = findrank(i, j) 
    [~, B] = sort(i(:, 3), 'descend' ); 
    a = find(B == j); 
    
end