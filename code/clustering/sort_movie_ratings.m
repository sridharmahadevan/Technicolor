% 
% 
% % Sort movies by some measure of popularity and return the k least popular
% movies -- either watched or rated 
% here k is computed as number of movies - popindex 

function pmovies = sort_movie_ratings(ratings, popindex) 

% INPUT: given a ratings matrix of size num_users x movies_rated (or
% watched) and an index of popularity (e.g., k most popular movies) 

% OUTPUT: return the indices in the ratings matrix of the most popular
% movies sorted in descending order 

numusers = size(ratings,1); 
nummovies = size(ratings,2); 

pmovies = zeros(popindex,1); 

mean_ratings = sum(ratings,1)/numusers; % compute mean rating per movie 

[sratings, midx] = sort(mean_ratings, 'descend'); % sort movies by mean ratings 

pmovies = midx(popindex+1:nummovies); 


