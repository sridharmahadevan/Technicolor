


% compute Moran's indices for movie recommendation problem 

function mi_list = moran_indices(A,B,factors)

% A is an array of size N x factors 
% B is an array of size N x 4 

mi_list = zeros(length(factors),1); 

for i=1:length(factors)
    
    mi_list(i) = moran_index(A,B,factors(i)); 
    
end; 

