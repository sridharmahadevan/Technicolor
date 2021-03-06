

function plot_multivariate_moran_factors(A,B,factors,popsize, display,sigma) 


% simply compute M = Z'*W*Z 
% where Z a matrix of normalized (X-mu)/sigma variables 
% W is the neighborhood matrix, normalized to have sum(sum(W,1)) = 1 
% this computes the Moran index 
% ami_list = zeros(length(factors),1); 

% do preprocessing to set up nearest neighbor search
% requires access to OPEN-TSTOOLS NN toolbox 

atr = nn_prepare(B(:,3:4)); % set up data structure for fast NN search 

[idxs dist] = nn_search(B(:,3:4), atr, B(:,3:4),popsize);

lf = length(factors); 

for fi=1:lf 
    
    f=factors(fi); 
    
    [arif, varif] = avg_gc_range(A,B,f,popsize,idxs, display,sigma); 
    
   h = figure;  %subplot(lf,1, fi); 
    
    % plot(arif, 'r-*', 'LineWidth', 2); 
    
    errorbar(arif, varif, 'xm-.', 'LineWidth', 2); 
   % axis([popsize(1), popsize(length(popsize)),0.8, 1.2]); 
    
    title(sprintf('Mean Spatial Autocorrelation of Latent Factor %d', f), 'FontSize', 18);
    
   ylabel('Geary C Index', 'FontSize', 18);
    
    xlabel(sprintf('Population Sizes: Min = %d Max = %d', popsize(1), popsize(size(popsize,2))),'FontSize', 18); 
    
    grid on; drawnow; 
    
    str = ['Geary-C-Index-Factor-', num2str(factors(fi)), '-Pop-Sizes-', num2str(popsize(1)), '-to-', num2str(popsize(length(popsize)))]; 
    
    print(h, '-djpeg', str); 
    print(h, '-dpdf', str); 
    
 end;



