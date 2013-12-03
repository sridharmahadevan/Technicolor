

function plot_mi_factors_old(A,B,factors,popsize) 


% ami_list = zeros(length(factors),1); 

% do preprocessing to set up nearest neighbor search
% requires access to OPEN-TSTOOLS NN toolbox 

atr = nn_prepare(B(:,3:4)); % set up data structure for fast NN search 

[idxs dist] = nn_search(B(:,3:4), atr, B(:,3:4),popsize);

lf = length(factors); 

figure; 

for fi=1:lf 
    
    f=factors(fi); 
    
    arif = avg_mi_range_old(A,B,f,popsize,idxs); 
    
    subplot(lf,1, fi); 
    
    plot(arif, 'r-*', 'LineWidth', 2); 
    
    title(sprintf('Mean Spatial Autocorrelation of Latent Factor %d', f), 'FontSize', 18);
    
    xlabel(sprintf('Population Sizes: Min = %d Max = %d', popsize(1), popsize(size(popsize,2))),'FontSize', 18); ylabel('Moran Index', 'FontSize', 18); 
    
    grid on; drawnow; 
    
 %   ami_list(f) = arif; 

end;



