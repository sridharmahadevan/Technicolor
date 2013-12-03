


% compute Moran's indices for movie recommendation problem 

function mi_list = geary_cindices(A,B,factors,sigma)

% A is an array of size N x factors 
% B is an array of size N x 4 

mi_list = zeros(length(factors),1); 

for i=1:length(factors)
    
    mi_list(i) = geary_cindex(A,B,factors(i),sigma); 
    
end; 

