% 
% 
% % plot cache size performance for a given clustering
% 
% % from an email from Udi: 
% 
% rnative approach is not to remove the popular movies, but instead remove Regarding the identification of 
%the number of top popular movies that should be removed from the analysis ? I was thinking 
%about something along the following lines (relates more to what Stefan has done):
% 
% Assume we have some partitioning of users into groups (e.g., geographic clustering or one of the methods
% Sridhar used). Let us also assume that there is one cache in each group. For each movie we place in the cache, 
% we can measure the percentage of users in each group that ?watched? the movie. I refer to the avg of this 
% value across all groups as the utility of placing the movie in the cache (we can define other/better metrics for utility).
% 
% We sort the movies based on descending popularity. If we place the first movie from this list in all caches, 
% the utility should be very high. As we add more movies from this list, the utility should decrease, and 
% I expect that we?ll have some point that clearly exhibits diminishing returns.
% This is the point where it makes sense to localize ? how do we identify the localized content that will make the
% utility grow.
% 
% Some things:
% can we plot the utility as we add movies for a bunch of different clustering methods? IS the ?knee? of the 
% diminishing returns consistent? 
% If at that point we take the per-cluster popular movies (that were not already selected) ? do we increase utility?
% An altemovies that are uniformly distributed across the clusters. So ? for each movie create a vector that 
% holds the ratio of users that watched it in each cluster. Using this vector, 
% compute the normalized entropy for each movie. Then, plot the CDF of this normalized entropy over all movies, 
% and find a threshold from which the movies are considered too ?uniform? to be included in the analysis.
% Remove these movies. 

function cache_scores = cache_cluster_eval(clustering, ratings)

% INPUT: given a ratings matrix of size num_users x movies_rated (or
% watched) and a clustering of the users, 

% OUTPUT: return a score weighting per movie of keeping it in a cache for
% every cluster 

maxclusters = max(clustering); % determine number of clusters 

numusers = size(ratings,1); 
nummovies = size(ratings,2); 

mean_ratings = sum(ratings,1)/numusers; % compute mean rating per movie 

[sratings, midx] = sort(mean_ratings, 'descend'); % sort movies by mean ratings 

% figure; plot(sratings, 'r-.', 'LineWidth', 2); title('Sorted Movie Ratings', 'FontSize', 18); 
% xlabel('Movie Index', 'FontSize', 18); grid on; 

cache_scores = zeros(nummovies,1); 

for i=1:nummovies 
    
    avg_score = 0; 
    
    for c = 1:maxclusters
        
        avg_score = avg_score + mean(ratings(clustering==c,midx(i))); % average score of movies in most popular movies in cluster 

    end; 
    
    cache_scores(i) = avg_score/maxclusters; % mean score of placing movie in all caches
    
end; 

figure(12); plot(cache_scores, 'r-.', 'LineWidth', 2); title('Mean Movie Cache Ratings', 'FontSize', 18); 
xlabel('Movie Index', 'FontSize', 18); grid on; 

