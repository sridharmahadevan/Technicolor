

function [amir, vamir] = clustered_avg_multivar_mi_range(ufactors, ulocs, range, clusterings, maxclusters,display) 

% compute mean Geary C index for factors given a population range 


amir = zeros(length(range),1); 

vamir = zeros(length(range),1);  % variance 

N = size(A,1); 

fprintf('\n Computing Multivariate Moran I index for populations of size:'); 

for r=1:length(range)
    
    fprintf('%d,', range(r)); 
    
    [amir(r) vamir(r)] = clustered_avg_multivar_mi(ufactors,ulocs, clusterings, maxclusters,display); 
    
end; 

fprintf('\n'); 

return; 


