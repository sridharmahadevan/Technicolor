

% plot average Geary's C index over a set of latent factors 

function [sagc, vagc, good_agc] = avg_gc(A,B,factors, M, idxs, display,sigma) 

% A is an array of size N x number of latent factors 

% B is an array of size N x 4, last two dimesions are longitude and
% latitude 

% M is number of nearest neighbors to consider

% idxs is the list of nearest neighbors for each person 

pop_bins = 1:M:size(A,1); % break users into groups of size M 

agc_threshold = 0.8; 

%bins = 50; % floor(sqrt(size(A,1))); % break users into groups of size M 

%pop_bins = 1:bins:size(A,1); 

lpop = 100; % length(pop_bins); 

% fprintf('Computing Geary C index for factor %d for populations of size %d\n', factors, M); 

sagc = 0; 

% for i = 1:size(A,1) 

users = randperm(size(A,1),lpop); 

agclist = zeros(lpop,1); 

if display 
    h = figure;  
end; 

good_agc = 0; 

for i = 1:lpop 
  
  neighbors = idxs(users(i),:); 
  
  agc = mean(geary_cindices(A(neighbors,:),B(neighbors,:),factors,sigma)); 
  
  if agc < agc_threshold
      good_agc = good_agc + 1; 
  end; 
 
  agclist(i) = agc; 
 
 if display 
     
     subplot(2,1,1); 
     
      hold on; scatter(B(neighbors,4), B(neighbors,3));% xlabel(sprintf('Population Group Size %d',M),'FontSize', 18); 
      axis([-130,-60,25,50]);  % zoom out to US map
      
    title(sprintf('Latent Factor %d = %4.2f',factors, agc),'FontSize', 18); 
 
%     xlabel(sprintf('Group %d of size %d out of %d groups', i, M,lpop), 'FontSize', 18); 

     xlabel('Longitude', 'FontSize', 18); ylabel('Latitude', 'FontSize', 18); 
  
     %ylabel('Geary C index','FontSize', 18); 
     
      drawnow; % pause; 
      
      grid on; 
      
 end; 
  
  sagc = sagc + agc; 

end; 

colors = ['y', 'm', 'c', 'r', 'g', 'b', 'k']; 

if display 

    subplot(2,1,2); plot(agclist, 'LineWidth', 2, 'Color', colors(randi(7))); title('Average Geary C Index', 'FontSize', 18);  grid on; 
    axis([0 length(agclist),0.4,1.5]); 
    ylabel(sprintf('Factor %d', factors), 'FontSize', 18);
    xstr =['Population Group Size=',num2str(M)]; 
    xlabel(xstr, 'FontSize', 18); 
    
   str = ['GCI-Factors-',num2str(factors'),'-Size-',num2str(M)]; 
     
    print(h, '-djpeg', str); 
    print(h, '-dpdf', str); 

end; 

sagc  = sagc/lpop; % length(pop_bins); 

good_agc = good_agc/lpop; 

vagc = var(agclist); 

return; 


