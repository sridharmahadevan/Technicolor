

function plot_multivariate_moran_factors(A,B,popsize,display,sigma) 


% simply compute M = Z'*W*Z, the multivariate Moran index proposed by
% Wartenberg (1985) 

% Here, Z a matrix of normalized (X-mu)/sigma variables 
% W is the neighborhood matrix, normalized to have sum(sum(W,1)) = 1 
% this computes the Moran index 

% ami_list = zeros(length(factors),1); 

% do preprocessing to set up nearest neighbor search
% requires access to OPEN-TSTOOLS NN toolbox 

% A matrix contains users X latent factors 
% B matrix contains users X location info (dimension 3 and 4) 

% normalize latent factor matrix to have mean 0, variance 1 per factor 
mean_factors = mean(A); 
std_factors = std(A); 

A = A - repmat(mean_factors,size(A,1),1); % mean 0 normalization 
A = A./repmat(std_factors,size(A,1),1); % variance 1 normalization 

atr = nn_prepare(B(:,3:4)); % set up data structure for fast NN search using longitude/latitude 

[idxs dist] = nn_search(B(:,3:4), atr, B(:,3:4),popsize);

[arif, varif] = avg_multivar_mi_range(A,B,popsize,idxs, display,sigma); 
    
h = figure;  %subplot(lf,1, fi); 
    
    % plot(arif, 'r-*', 'LineWidth', 2); 
    
%errorbar(arif, varif, 'xm-.', 'LineWidth', 2); 

plot(arif, 'r-*', 'LineWidth', 2); 
   % axis([popsize(1), popsize(length(popsize)),0.8, 1.2]); 
    
title('Average Variance of first PC of Factor Autocorrelation Matrix', 'FontSize', 18);
    
ylabel('Geary C Index', 'FontSize', 18);
    
xlabel(sprintf('Population Sizes: Min = %d Max = %d', popsize(1), popsize(size(popsize,2))),'FontSize', 18); 
    
grid on; drawnow; 
    
str = ['Multivariate-Moran-I-Index', '-Pop-Sizes-', num2str(popsize(1)), '-to-', num2str(popsize(length(popsize)))]; 
    
print(h, '-djpeg', str); 
print(h, '-dpdf', str); 
    




