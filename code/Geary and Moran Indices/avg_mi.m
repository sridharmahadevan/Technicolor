

% plot average moran index over a set of latent factors 

function ami = avg_mi(A,B,factors, M, idxs) 

% A is an array of size N x number of latent factors 

% B is an array of size N x 4, last two dimesions are longitude and
% latitude 

% M is number of nearest neighbors to consider

% idxs is the list of nearest neighbors for each person 

pop_bins = 1:M:size(A,1); % break users into groups of size M 

lpop = length(pop_bins); 

% disp(pop_bins); 

fprintf('Computing MI for factor %d for %d populations of size %d\n', factors, length(pop_bins),M); 

sami = 0; 

clf; 

users = randperm(size(A,1),lpop);  % select some random users 

for i=1:lpop

%for i = 1:size(A,1) 
    
    % interval = (i-1)*M+1:min(i*M,size(A,1)); 
    
    % neighbors = idxs(i,:); 
    
    neighbors = idxs(users(i),:); 
    
%    disp(interval); 

%    ami = mean(moran_indices(A(1:M,:),B(1:M,:),factors)); 

 figure(1); hold on; scatter(B(neighbors,4), B(neighbors,3)); xlabel(sprintf('Population Group Size %d',M),'FontSize', 18); 
  axis([-130,-60,25,50]);  % zoom out to US map
  
  cami = mean(moran_indices(A(neighbors,:),B(neighbors,:),factors)); 
  
  title(sprintf('Spatial Autocorrelation for Latent Factor %d = %4.2f',factors, cami),'FontSize', 18); 
  
  sami = sami + cami; grid on; 
  
  drawnow; % pause(.1); 
    
end; 

ami  = sami/length(pop_bins); 

return; 


