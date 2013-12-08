

% cluster users based on latent factor decomposition using k least popular
% movies, and use self-organizing maps to cluster the users from their
% latent factors

function [mnet, lfactors,clustering,cscores] = som_lfmat_lfactors(ratings,lfindex,popindex,dim1,dim2, display) 

% INPUTS: ratings contains an Nxm array of N users and m movies, either
% watched statistics or ratings
% lfindex is the number of latent factors to create
% popindex specifies how many of the most popular movies to ignore
% dim1 and dim2 specify the architecture of the self-organizing map

 workers = 8; 

    %Init parallel if the parallel toolbox is installed
    if exist('matlabpool') > 1 %#ok<EXIST>
        if (matlabpool('size') == 0), matlabpool('open', 'local', workers); end
    end



% eliminate k most popular movies first 
popmovies = sort_movie_ratings(ratings,popindex); 

% find latent factors, e.g. by NNMF 
fprintf('Finding latent factors by NNMF...\n'); 
lfactors = lafactor(ratings(:,popmovies),popindex,lfindex); 

% run the self-organizing network to cluster the users 
[mnet, clustering, mout] = movie_user_som(lfactors,dim1,dim2, display); 

fprintf('Evaluating clustering found by SOM...\n'); 
cscores = cache_cluster_eval(clustering,ratings); 

  if exist('matlabpool') > 1 %#ok<EXIST>
        matlabpool('close');
    end

return; 







