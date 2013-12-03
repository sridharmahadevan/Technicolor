

% plot mulitivariate Moran Index over a set of latent factors for a
% clustered set of users 

function cami = clustered_avg_multivar_mi(ufactors, ulocs, clusterings, maxclusters,display) 

% ufactors is an array of size N (num of users) x number of latent factors 

% ulocs is an array of size N x 4, last two dimesions are longitude and
% latitude 

% clustering is an Nx1 vector of clusterings where index i specifies the
% cluster number that user i belongs to 

% maxclusters is the number of groupings 

num_eigproj = 3; 

laticksize = 20; 
longticksize = 20; 


N = size(ufactors,1); 
nfactors = size(ufactors,2); 

% fprintf('Computing Geary C index for factor %d for populations of size %d\n', factors, M); 

% users = randperm(size(A,1),lpop); 
% 
% if display 
%     h = figure;  
% end; 
% 

% compute the weight matrix first -- assume binary weight matrix
% w(i,j) = 1 if i and j belong to the same cluster 

w = zeros(N,N); 

for i=1:maxclusters
    
    neighbors = find(clusterings==i); % find elements in cluster i 
    
    w(neighbors,neighbors) = 1; % two neighbors are unit distance from each other 
    
 %   fprintf('cluster %d neighbor size: %d edge count: %d\n', i, length(neighbors),nnz(w)); 
    
 %   figure(11); imagesc(w);  colorbar; colormap(hot); axis square; pause(1); 

end; 

w = w - eye(N); % no diagonal similarities 

w = (w + w')/2; % symmetrize 

% normalize W to have total sum 1 
w = w./sum(sum(w,2));  


% subplot(2,2,3); spy(w); title('Original Weight Matrix', 'FontSize', 18); % original ordering 
% use reverse Cuthill-McKee ordering so permute rows/columns so entries are near diagonal  
pM = symrcm(w);  
pw = w(pM,pM); 

figure(10);
subplot(2,3,4); spy(pw); title('Permuted Weight Matrix', 'FontSize', 18); 

cami = ufactors(pM,:)'*pw*ufactors(pM,:); % multivariate Moran index proposed by Wartenberg 

[eigvec, eigval] = eig(cami); % find principal components of factor spatial corr. matrix 

[reigvec, Tm] = rotatefactors(eigvec, 'Method','orthomax','Coeff',num_eigproj/2); % rotate PCs to make them more interpretable using varimax rotation 


figure(10); subplot(2,3,3); %imagesc(eigvec); colorbar; title('Original PC Matrix', 'FontSize', 18); 
imagesc(reigvec); colorbar; title('Rotated PC Matrix', 'FontSize', 18); 
  
eigvals = diag(eigval); % pull out the diagonal eigenvalues 
  
abseigsum = sum(abs(eigvals)); 

eigvars = zeros(nfactors,1); 
  
for i=1:size(eigval,1)
     eigvars(i) = abs(eigvals(i))*100/abseigsum; 
end; 

if display 
     
    figure(10); subplot(2,3,5); 

    %  hold on; surf(B(neighbors,4), B(neighbors,3), A(neighbors,:)*eigvec(:,1)); % xlabel(sprintf('Population Group Size %d',M),'FontSize', 18); 
     plot(sort(eigvars, 'descend'), 'r-*', 'LineWidth', 2); grid on; 
     %title('Eigenvalues of Factor Spatial Autocorrelation Matrix', 'FontSize', 18); 
     title('MSC Variances', 'FontSize', 18); 
     drawnow; 
     
      minlat = min(ulocs(:,4)); maxlat = max(ulocs(:,4)); 
      minlong = min(ulocs(:,3)); maxlong = max(ulocs(:,3)); 
      lattick = minlat:(maxlat-minlat)/laticksize:maxlat; longtick = minlong:(maxlong-minlong)/longticksize:maxlong; 
            
      [xq, yq] = meshgrid(lattick,longtick); 
      
%      eigprojz = ufactors(pM,:)*eigvec(:,1:num_eigproj);  % get matrix of first few PC projections 
      eigprojz = ufactors(pM,:)*eigvec(:,1:num_eigproj)*Tm(1:num_eigproj,1:num_eigproj);  % get rotated PC score matrix of first few PC projections 
      
      for i=1:num_eigproj; 
          figure(11); subplot(1, num_eigproj, i); 

          eiginterp = griddata(ulocs(pM,4),ulocs(pM,3),eigprojz(:,i),xq, yq); 
          
         %  mesh(xq,yq,eiginterp); 
            surf(xq,yq,eiginterp); colormap(jet); lighting phong; view(0,90); 
           hold on; plot3(ulocs(pM,4),ulocs(pM,3),eigprojz(:,i),'r.'); view(0,90); hold off;
           axis([-125,-60,25,50]);  % zoom out to US map
          xlabel('Longitude', 'FontSize', 18); 
          ylabel('Latitude', 'FontSize', 18); 
          title(sprintf('MSC %d', i),'FontSize', 18); 
          colorbar; 
          
          drawnow; % pause; 

     end; 
     
    figure(10); subplot(2,3,6); imagesc(cami); colorbar; 
    title('Multivariate Moran Index', 'FontSize', 18); 
     
end; 
 

return; 


