


% compute Moran's indices for movie recommendation problem 

function multivar_mi_list = multivar_moran_indices(A,B,sigma)

% A is an array of size N x factors 
% B is an array of size N x 4 

N = size(A,1); 

sumW = 0; 

visited = zeros(N,N); 
w = zeros(N,N); 

visited = visited + eye(N); % diagonal entries are ignored 

% form weight matrix 
for i=1:N
    for j=1:N
        if visited(i,j)==0 
            weight = exp(-norm(B(i,3:4)-B(j,3:4))^2/sigma); % heat kernel 
            w(i,j) = weight; w(j,i) = weight; 
            visited(i,j) = 1; visited(j,i) = 1; 
            sumW = sumW + weight; 
        end; 
    end; 
end;

w = (w + w')/2; % symmetrize 

% normalize W to have total sum 1 
w = w./sumW; 

multivar_mi_list = A'*w*A; % multivariate Moran index proposed by Wartenberg 

return; 

figure(3); imagesc(w); colorbar; 

% Moran multivariate scatterplot 
% plot each factor f_i against the "lagged" factor W*f_j 

figure(2); subplot(3,1,1); 
%scatter3(A(:,1), w*A(:,2), w*A(:,3)); 
%scatter(A(:,1), w*A(:,2)); 
scatter(A(:,1), w*A(:,2)); 
title(sprintf('Factor 1 against lagged 2: Moran Index %f', (A(:,1)'*w*A(:,2))/(A(:,1)'*A(:,2))), 'FontSize', 18); 
grid on; 

subplot(3,1,2); 
scatter(A(:,2), w*A(:,3)); 
title(sprintf('Factor 2 against lagged 3: Moran Index %f', (A(:,2)'*w*A(:,3))/(A(:,2)'*A(:,3))), 'FontSize', 18); 
grid on; 

subplot(3,1,3); 
scatter(A(:,4), w*A(:,5)); 
title(sprintf('Factor 4 against lagged 5: Moran Index %f', (A(:,4)'*w*A(:,5))/(A(:,4)'*A(:,5))), 'FontSize', 18); 
grid on; 

%asubplot(3,1,2); 
%scatter3(A(:,4), w*A(:,5), w*A(:,6)); 
%title('Factors 4 against lagged 5 and 6', 'FontSize', 18); 

%subplot(3,1,3); 
%scatter3(A(:,7), w*A(:,8), w*A(:,9)); 
%title('Factors 7 against lagged 8 and 9', 'FontSize', 18); 
pause; 






