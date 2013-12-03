

% plot mulitivariate Moran Index over a set of latent factors 

function [svars, vvars] = avg_multivar_mi(A,B, M, idxs, display,sigma) 

% A is an array of size N x number of latent factors 

% B is an array of size N x 4, last two dimesions are longitude and
% latitude 

% M is number of nearest neighbors to consider

% idxs is the list of nearest neighbors for each person 

pop_bins = 1:M:size(A,1); % break users into groups of size M 

num_eigproj = 2; 

nump = 50; % number of interpolation points 

%bins = 50; % floor(sqrt(size(A,1))); % break users into groups of size M 

%pop_bins = 1:bins:size(A,1); 

lpop = 100; % length(pop_bins); 

svars = 0; 

% fprintf('Computing Geary C index for factor %d for populations of size %d\n', factors, M); 

users = randperm(size(A,1),lpop); 

varlist = zeros(lpop,1); 

eigvarsum = zeros(lpop,1); 

if display 
    h = figure;  
end; 

popeigvals = zeros(lpop,1); 

for i = 1:lpop 
  
  neighbors = idxs(users(i),:); 
  
%  disp(sort(neighbors)); 
  
  multivar_mat = multivar_moran_indices(A(neighbors,:),B(neighbors,:),sigma);  % returns a matrix of factor autocorrelations 
 
  [eigvec, eigval] = eig(multivar_mat); % find principal components of factor spatial corr. matrix 
  
  eigvals = diag(eigval); % pull out the diagonal eigenvalues 
  
  popeigvals(i) = eigvals(1); 
  
  abseigsum = sum(abs(eigvals)); 
  
  for i=1:size(eigval,1)
      eigvars(i) = abs(eigvals(i))*100/abseigsum; 
  end; 
  
  %varfirst = 
  
 if display 
     

%      
%       hold on; scatter(B(neighbors,4), B(neighbors,3));% xlabel(sprintf('Population Group Size %d',M),'FontSize', 18); 
%     %  axis([-130,-60,25,50]);  % zoom out to US map
%       xlabel('Longitude', 'FontSize', 18); ylabel('Latitude', 'FontSize', 18); 
%       grid on; drawnow; 
      
      % subplot(3,1,2);  
      
       figure(1); 

    %  hold on; surf(B(neighbors,4), B(neighbors,3), A(neighbors,:)*eigvec(:,1)); % xlabel(sprintf('Population Group Size %d',M),'FontSize', 18); 
     plot(sort(eigvars, 'descend'), 'r-*', 'LineWidth', 2); grid on; 
     %title('Eigenvalues of Factor Spatial Autocorrelation Matrix', 'FontSize', 18); 
     title('MSC Variances of Spatial Autocorrelation Matrix', 'FontSize', 18); 
     drawnow; 
     
      figure(1); 
      
      minlat = min(B(neighbors,4)); maxlat = max(B(neighbors,4)); 
      minlong = min(B(neighbors,3)); maxlong = max(B(neighbors,3)); 
      lattick = minlat:(maxlat-minlat)/M:maxlat; longtick = minlong:(maxlong-minlong)/M:maxlong; 
            
      [xq, yq] = meshgrid(lattick,longtick); 
      
      eigprojz = A(neighbors,:)*eigvec(:,1:num_eigproj);  % get matrix of first few PC projections 
      
      for i=1:num_eigproj; 
          figure(2); subplot(num_eigproj,1,i); 

          eiginterp = griddata(B(neighbors,4),B(neighbors,3),eigprojz(:,i),xq, yq); 
          
%          disp(size(xq)); disp(size(yq)); disp(size(eiginterp)); 
           mesh(xq,yq,eiginterp); 
        %    surf(xq,yq,eiginterp); colormap(jet); lighting phong; 
           hold on; plot3(B(neighbors,4),B(neighbors,3),eigprojz(:,i),'.'); hold off;
          xlabel('Longitude', 'FontSize', 18); 
          ylabel('Latitude', 'FontSize', 18); 
          title(sprintf('Projection of Latent Factors: MSC Component %d', i),'FontSize', 18); 
          colorbar; 
      end; drawnow; pause; 

         
 %    plot(A(neighbors,:)*eigvec(:,1)); % xlabel(sprintf('Population Group Size %d',M),'FontSize', 18); 

%    title(sprintf('Projection onto first PC with eigenvalue %4.2f',eigvals(1)),'FontSize', 18); 
 
%     xlabel(sprintf('Group %d of size %d out of %d groups', i, M,lpop), 'FontSize', 18); 


  
     %ylabel('Geary C index','FontSize', 18); 
     

 end; 
 
 varlist(i) = eigvars(1); % just record first eigenvalue
  
  svars = svars + eigvars(1); 

end; 

colors = ['y', 'm', 'c', 'r', 'g', 'b', 'k']; 

if display 

    figure(1);  plot(varlist, 'LineWidth', 2, 'Color', colors(randi(7))); title('Average Variance w.r.t 1st eigenvalue', 'FontSize', 18);  grid on; 

    xstr =['Population Group Size=',num2str(M)]; 
    xlabel(xstr, 'FontSize', 18);
    
   str = ['Multivariate-Moran-Index','-Size-',num2str(M)]; 
     
    print(h, '-djpeg', str); 
    print(h, '-dpdf', str); 

end; 

svars  = svars/lpop; % length(pop_bins); 

vvars = var(varlist); 

return; 


