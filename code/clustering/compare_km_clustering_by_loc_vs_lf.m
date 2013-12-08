

% compare clustering by latent factors of ratings matrix vs. clustering by
% location
% Use k-means matlab clustering method  (see also the SOM routine) 


function [cscores_loc_km, cscores_lf_km] = compare_km_clustering_by_loc_vs_lf(ratings,popindex, lfindex, ulocs,numclusters,method, metric, display) 

workers = 8; 

    %Init parallel if the parallel toolbox is installed
if exist('matlabpool') > 1 %#ok<EXIST>
        if (matlabpool('size') == 0), matlabpool('open', 'local', workers); end
end

% eliminate k most popular movies first 
lesspopmovies = sort_movie_ratings(ratings,popindex); 

% find latent factors, e.g. by NNMF 
fprintf('Finding latent factors by NNMF...\n'); 
lfactors = lafactor(ratings(:,lesspopmovies),popindex,lfindex); 

[cmkm_lf, histkm_lf] = flat_cluster_users(lfactors, method, metric, numclusters, display); % cluster users by latent factors using kmeans 

cscores_lf_km = cache_cluster_eval(cmkm_lf,ratings, display); 

[cmkm_loc, histkm_loc] = flat_cluster_users(ulocs, method, metric, numclusters, display); % cluster users by location using kmeans 

cscores_loc_km = cache_cluster_eval(cmkm_loc,ratings, display); 


figure; 

plot(cscores_lf_km,'r-','LineWidth', 2); hold on; 
plot(cscores_loc_km,'b-','LineWidth', 2); hold on; 
legend('K-Means User Factors', 'K-Means User Location');

xlabel('Movies', 'FontSize', 18); 
ylabel(sprintf('Mean Movie Cache Ratings removing %d top movies', popindex),'FontSize', 18); 

title('Comparing K-means Clustering Algorithms', 'FontSize', 18); 
grid on; 

if exist('matlabpool') > 1 %#ok<EXIST>
        matlabpool('close');
    end

return; 