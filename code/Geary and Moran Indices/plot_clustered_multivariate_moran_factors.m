

function [cami, Cm] = plot_clustered_multivariate_moran_factors(ufactors,ulocs,display,maxclusters, method, metric) 

% cluster the users into groups and compute spatially averaged multivariate
% Moran's index 

% INPUTS: maxclusters is number of groupings desired, method and metric are
% described in MATLAB's linkage function used to do the clustering 

% simply compute M = Z'*W*Z, the multivariate Moran index proposed by
% Wartenberg (1985) 

% Here, Z a matrix of normalized (X-mu)/sigma variables 
% W is the neighborhood matrix, normalized to have sum(sum(W,1)) = 1 
% this computes the Moran index 

% ami_list = zeros(length(factors),1); 

% do preprocessing to set up nearest neighbor search
% requires access to OPEN-TSTOOLS NN toolbox 

% ufactors matrix contains users X latent factors 
% ulocs matrix contains users X location info (dimension 3 and 4 are
% latitude and longitude 

% normalize latent factor matrix to have mean 0, variance 1 per factor 
mean_factors = mean(ufactors); 
std_factors = std(ufactors); 

ufactors = ufactors - repmat(mean_factors,size(ufactors,1),1); % mean 0 normalization 
ufactors = ufactors./repmat(std_factors,size(ufactors,1),1); % variance 1 normalization 

%%%%%%%%%%%%%% this clusters using the Open TSTOOLS package 

% atr = nn_prepare(ulocs(:,3:4)); % set up data structure for fast NN search using longitude/latitude 
% 
% [idxs dist] = nn_search(ulocs(:,3:4), atr, ulocs(:,3:4),popsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% clustering using MATLAB package 

[Cm, hist] = flat_cluster_users(ulocs(:,3:4), method, metric, maxclusters); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute multivariate Moran index matrix -- returns matrix of size
% equal to nfactors x nfactors 
cami = clustered_avg_multivar_mi(ufactors, ulocs, Cm, maxclusters,display); 


    
