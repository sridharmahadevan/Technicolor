
% plot spatial autocorrelation of some clustered group of people to gauge
% their movie preferences

function [mmi, Cm, cscores] = clustered_msc_all(ufactors,ulocs,display,maxclusters, method, metric,ratings)

% userpop = randperm(size(ufactors,1),popsize); 

[mmi, Cm] = plot_clustered_multivariate_moran_factors(ufactors,ulocs,display,maxclusters,method,metric);


% compute cache performance across movies based on the clustering found 
% assuming most popular movies are placed in a uniform cache across all
% movies 

cscores = cache_cluster_eval(Cm,ratings); 