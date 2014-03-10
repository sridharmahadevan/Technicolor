function [ trainr, testr ] = LambdaPolicy(Ratings,users,cachesizes,lambdas,f)
%LambdaPolicy Computes training and testing results for given lambda
%Ratings: An m x n matrix of individual user/item ratings
%users: A vector of length m defining the region of each user
%cachesizes: A vector of cache sizes to test over
%lambdas: A vector of lambdas, defines the local/global policy ratio
%f: Number of folds to use for validation
%trainr: A 3-dimensional array of test results (cachesize, lambda, fold)
%testr: A 3-dimensional array of test results (cachesize, lambda, fold)



c=size(cachesizes,2);
l=size(lambdas,2);
r=max(users);

trainr=zeros(c,l,f);
testr=trainr;

x=find(Ratings);
size1=size(Ratings,1);
size2=size(Ratings,2);
clear watched
%folds=cvpartition(size(watched,1)*size(watched,2),'kfold',f);
folds=cvpartition(size(x,1),'kfold',f);

for h=1:f
    %The following lines create training and testing sets and force the
    %matrix to be the right size
    trainm=sparse(x(training(folds,h)),y(training(folds,h)),val(training(folds,h)),size1,size2);
    testm=sparse(x(test(folds,h)),y(test(folds,h)),val(test(folds,h)),size1,size2);
    
    %Determine Global Popularity
    %Use the following 2 lines only for sampling
    %r=1+floor((5899).*rand(200,1));
    %sums=sum(trainm(r,:));
    sums=sum(trainm);
    [~,globallist]=sort(sums,'descend');
    %hack to keep movie order easy for testing
    testm=testm(:,globallist);
    trainm=trainm(:,globallist);
    globallist=[1:size(trainm,2)];

    for i=1:c; %for each cache size
        cache=zeros(cachesizes(i),1); %set up blank cache
        for j=1:l %for each lambda policy
            g=floor(cachesizes(i)*lambdas(j)); %determine number of global items in cache
            cache(1:g)=globallist(1:g); %Fill cache with global items

            %Reset Counters
            trainhits=0;
            traintots=0;
            testhits=0;
            testtots=0;
            for k=1:r %for each region
                u=find(users==k);
                %Fill cache with regional selections
                sums=sum(trainm(u,:));%sort all movies for later testing purposes
                [~,regionallist]=sort(sums(g+1:end),'descend'); %Only get movies not already in cache
                regionallist=regionallist+g; %Offset movies
                cache(g+1:end)=regionallist(1:cachesizes(i)-g); %Fill cache

                %Test Cache on training set
                trainhits=trainhits+sum(sums(cache));
                traintots=traintots+sum(sums);

                %Test cache on test set
                sums=sum(testm(u,:));
                testhits=testhits+sum(sums(cache));
                testtots=testtots+sum(sums);
            end
            trainr(i,j,h)=trainhits/traintots;
            testr(i,j,h)=testhits/testtots;
        end
    end
end
end

