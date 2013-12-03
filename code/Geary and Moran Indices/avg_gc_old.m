

% plot average moran index over a set of latent factors 

function ami = avg_gc_old(A,B,factors, M, idxs) 

% A is an array of size N x number of latent factors 

% B is an array of size N x 4, last two dimesions are longitude and
% latitude 

% M is number of nearest neighbors to consider

% idxs is the list of nearest neighbors for each person 

pop_bins = 1:M:size(A,1); % break users into groups of size M 

% disp(pop_bins); 

fprintf('Computing MI for factor %d for populations of size %d\n', factors, M); 

sami = 0; 

for i=1:length(pop_bins)
    
    interval = (i-1)*M+1:min(i*M,size(A,1)); 
    
%    disp(interval); 

%    ami = mean(moran_indices(A(1:M,:),B(1:M,:),factors)); 

  figure(1); scatter(B(interval,4), B(interval,3)); xlabel(sprintf('Population Group Size %d',M),'FontSize', 18); 
  
  cami = mean(geary_cindices(A(interval,:),B(interval,:),factors)); 
  
  title(sprintf('Spatial Autocorrelation for Latent Factor %d = %4.2f',factors, cami),'FontSize', 18); 
  
  sami = sami + cami; grid on; 
  
  drawnow; pause; 
    
end; 

ami  = sami/length(pop_bins); 

return; 


