


% compute Moran's index to compute spatial autocorrelation for movie
% recommendation dataset  for a particular latent factor 

function mi = moran_index(A,B,  factor) 

% A is an array of size N x f, where N is number of users
% number of columns f is number of latent factors 

% B is an array of size N x (user ID, zipcode, latitude, longitude) 

[N, c] = size(A); 

% lf = c-2; % first two coordinates are latitude and longitude 

minum = 0; % numerator term of Moran's index
%midenom = 0; % denominator in Moran's index 

w = zeros(N,N); % measures distance between two users based on geographical location 

sigma = 1; 

Amu = mean(A(:,factor)); % compute mean of desired factor 

for i=1:N
    for j=1:N
        
        if i ~= j 
            w(i,j) = exp(-norm(B(i,3:4)-B(j,3:4))^2/sigma); % heat kernel 
        
            minum = minum + w(i,j)*(A(i,factor) - Amu)*(A(j,factor) - Amu); 
            
        end; 
        
    end; 
    
end; 

midenom = sum(sum(w,2))*var(A(:,factor),1); 

mi = minum/midenom; 


        
     
        