

% compare clustering by latent factors of ratings matrix vs. clustering by
% location
% Use self-organizing MAP (SOM) for both, although this can be easily
% changed


function [cscoresloc, cscoreslf,lfloc,lf,cmlf,cmloc,mnetloc,mnetlf] = compare_clustering_by_loc_vs_lf(ratings,ulocs,lfindex,popindex,dim1,dim2, display) 

[mnetloc,lfloc,cmloc,cscoresloc] = som_lfmat(ulocs,ratings,lfindex,popindex,dim1,dim2,display);  % cluster users by loc using SOM

[mnetlf,lf,cmlf,cscoreslf] = som_lfmat_lfactors(ratings,lfindex,popindex,dim1,dim2,display);

%[cmkm, histkm] = flat_cluster_users(ulocs, method, metric, dim1*dim2); % cluster users by location using kmeans 

%cscores_km = cache_cluster_eval(cmkm,ratings); 


figure; 

plot(cscoreslf,'r-','LineWidth', 2); hold on; 
plot(cscoresloc,'b-','LineWidth', 2); hold on; 
%plot(cscores_km,'m-','LineWidth', 2); 
%legend('SOM User Factors', 'SOM User Location', 'K-means loc');
legend('SOM User Factors', 'SOM User Location');

xlabel('Movies', 'FontSize', 18); 
ylabel(sprintf('Mean Movie Cache Ratings removing %d top movies', popindex),'FontSize', 18); 

title(sprintf('Comparing SOM Clustering Algorithms', popindex),'FontSize', 18); 
grid on; 

return; 