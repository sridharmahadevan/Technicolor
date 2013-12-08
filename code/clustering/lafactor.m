

% create latent factor matrix of the ratings matrix filtered by the most
% popular movies 

function lfactors = lafactor(ratings,popindex, lfindex) 

% INPUT: a ratings matrix of size N x movies, and a popularity index of k
% most popular rated or watched movies
% OUTPUT: a latent factor matrix of the users of size N x lfindex 


numusers = size(ratings,1); 
nmovies = size(ratings,2); 

lfactors = zeros(numusers,lfindex); 


% find the k least popular or watched movies first 
subratings = sort_movie_ratings(ratings,popindex); 


% now run a latent factor algorithm of some kind, e.g. NNMF or something
% else. 

[lfactors, rfactors] = nnmf(ratings(:,subratings), lfindex); 




