

function amir = avg_mi_range_old(A,B,factors, range, idxs) 

% compute mean Moran index for factors given a population range 


amir = zeros(length(range),1); 

for r=1:length(range)
    
    amir(r) = avg_mi_old(A,B,factors,range(r), idxs); 
    
end; 

return; 


