

% make sparse user ratings matrix 
% read in raw movie lens file 

function urmat = create_user_ratings(mlmat) 

% INPUT: movie lens matrix in original format 

% description of small MovieLens dataset 
%- UserIDs range between 1 and 6040 
%- MovieIDs range between 1 and 3952
%- Ratings are made on a 5-star scale (whole-star ratings only)
%- Timestamp is represented in seconds since the epoch as returned by time(2)
%- Each user has at least 20 ratings


[nur, nf] = size(mlmat);  % number of ratings by fields 

nm = max(mlmat(:,2)); % number of movies 
nu = mlmat(nur,1); % number of users 

urmat = spalloc(nu,nm,nur); 

for ur=1:nur
    urmat(mlmat(ur,1),mlmat(ur,2))=mlmat(ur,3); % find the rating
    if mod(ur,1000)==0
        disp(ur); 
    end; 
end; 

return; 