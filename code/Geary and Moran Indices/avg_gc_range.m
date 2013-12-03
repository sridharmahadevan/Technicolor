

function [amir, vamir, good_agc_count] = avg_gc_range(A,B,factors, range, idxs, display,sigma) 

% compute mean Geary C index for factors given a population range 


amir = zeros(length(range),1); 

vamir = zeros(length(range),1);  % variance 

good_agc_count  = zeros(length(range),1);  % number of good AGCs 

N = size(A,1); 

fprintf('\n Computing Geary C index for factor %d for populations of size:',factors); 

for r=1:length(range)
    
    fprintf('%d,', range(r)); 
    
    [amir(r) vamir(r) good_agc_count(r)] = avg_gc(A,B,factors,range(r), idxs, display,sigma); 
    
end; 

fprintf('\n'); 

return; 


