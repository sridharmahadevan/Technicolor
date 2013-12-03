

function plot_agc_across_factors_fixed_size(A,B,factors,popsize, display,sigma) 

% ami_list = zeros(length(factors),1); 

% do preprocessing to set up nearest neighbor search
% requires access to OPEN-TSTOOLS NN toolbox 

atr = nn_prepare(B(:,3:4)); % set up data structure for fast NN search 

[idxs dist] = nn_search(B(:,3:4), atr, B(:,3:4),popsize);

lf = length(factors); 

arif = zeros(lf,1); 

for fi=1:lf 
    
    f=factors(fi); 
    
    arif(fi) = avg_gc_range(A,B,f,popsize,idxs,display,sigma); 
    
 end;

 figure(10);  
    
    plot(arif, 'r-*', 'LineWidth', 2); 
    
   title(sprintf('Mean Spatial Autocorrelation for population size %d', popsize), 'FontSize', 18);
    
   ylabel('Geary C Index', 'FontSize', 18);
    
  xlabel('Latent Factors', 'FontSize', 18); grid on; drawnow; 
