

% do a hierarchical clustering of users using MATLAB's clustering methods 
% Sridhar Mahadevan, November 29 2013

function [Cm, hist] = flat_cluster_users(user_locs, method, distance, maxclusters, display) 

% INPUT: latitude-longitude locations of users
% user_locs is an N x k matrix (k=2 for spatial loc) 

% method is a particular way of computing distance between clusters. From
% MATLAB's documentation of linkage: 
% average': Unweighted average distance (UPGMA)

% 'centroid': Centroid distance (UPGMC), appropriate for Euclidean distances only'complete'
% 
% Furthest distance'median'
% 
%    Weighted center of mass distance (WPGMC), appropriate for Euclidean distances only'single'
% 
% Shortest distance'ward'
% 
%    Inner squared distance (minimum variance algorithm), appropriate for Euclidean distances only'weighted'
% 
% Weighted average distance (WPGMA

% metric is any distance function accepted by MATLAB's pdist :
% Examples: 'euclidean', 'cityblock', 'minkowski', 'chebyshev',
% 'mahalanobis', 'cosine', 'correlation', 'spearman', or a custom distance
% function. See MATLAB docs on pdist. 

% 
% TO-DO: Convert lat-long pairs to distances using the pos2dist function
% sent to me by Stefan 

% OUTPUT: T and H are the outputs of the dendrogram produced by MATLAB
% Z is a matrix of clusterings produced by MATLAB's linkage function 
% Z is an Nx3 matrix, where columns 1 and 2 contain cluster indices linked
% in pairs to form a binary tree. See MATLAB documentation of linkage for
% more information
% Cm is a vector of size N of clusterings, where index i value is the
% cluster number for user i

if nargin < 2
    
    method = 'complete'; 
    distance = 'euclidean'; 
    maxclusters = 10; 
    display = 0; 
end; 

Cm = clusterdata(user_locs,'distance', distance, 'linkage', method, 'maxclust', maxclusters);

hist = zeros(maxclusters,1);

for i=1:maxclusters
    hist(i) = length(find(Cm==i)); % how many in cluster i
end;

if display 

    figure(10); subplot(2,3,1); scatter(user_locs(:,2),user_locs(:,1),30,Cm);  % longitude on x axis
    title('Clustering of Users', 'FontSize', 18); grid on; 
    axis([-130,-60,25,50]);  % zoom out to US map
    ylabel('Latitude', 'FontSize', 18); 
    xlabel('Longitude', 'FontSize', 18); 
    drawnow; 

    figure(10); subplot(2,3,2); bar(hist); title('Histogram of Clusters', 'FontSize', 18); drawnow;
end;

% another way to do hierarchical clustering 
%Zm = linkage(user_locs,method,metric); 

%[H,T] = dendrogram(Zm,'colorthreshold','default');

%set(H,'LineWidth',2); 

return; 



