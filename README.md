Technicolor
===========

Technicolor Movie Recommendations Project

This is a repository for the Technicolor project. Initially, it will
only contain the MATLAB code that I have written for doing spatial
statistics on the Movie Lens dataset. Ultimately, I hope we will put
all the publically sharable code and datasets on this repository. 


GITHUB REPOSITORY FOR SPATIAL STATISTICS IN MATLAB: 
---------------------------------------------------

The MATLAB code is not as well documented as it should be, but here's
a quick guide as to how to get started. At the top level, the github
repository is divided into several folders with self-evident names:

 - `code` contains the MATLAB code to compute clusterings
and spatial statistics.
 - `Documentation` contains the two handouts I sent you.
 - `MATLAB variables` contains binary variables with the
   data from Stefan that need to be loaded into MATLAB to
   run the code.
 - `Plots` contains sample plots of the type I sent you. 



RUNNING THE CODE: 
-----------------

1. First, start up MATLAB, and then make sure the entire Technicolor
repository is in the MATLAB path. 

2. Next, navigate to the MATLAB variables subdirectory, and load in
the MATLAB variables that define user latent factors, user locations,
and watched movie statistics. Type in the MATLAB command line: 

```
load user_bias.mat
load users.mat
load watched.mat
```

This defines `user_factors`, an N x 10 array of 10 latent factors per
user;  `users` is an N x 4 array where `users(:,3)` and `users(:,4)` have
the longitude and latitude respectively of each user; and finally,
`watched` simply lists the movies that have been watched by each user. 

3. Navigate into the code subdirectory, and run the routines
there. For example, if you go into the clustering subdirectory of the
code directory, you can run the MATLAB routine `clustered_msc` as
follows: 

```
clustered_msc(user_factors,users,1,20,'average','mahalanobis',2000,watched)
```

This runs both the clustering method and the spatial analysis
routines, and generates the plots I sent you. Here, the first two
arguments are the latent factors and the user locations, the third
argument is whether to display the plots, the fourth argument is the
number of clusters (20). The following two arguments are parameters to
the clustering method (see MATLAB documentation for `cluster`). 2000
is the population size. Finally, the last argument provides the
watched statistics to decide which movies to place in the cache to
generate the plot of cache hits across the various clusters (following
Udi's suggestion). 

Good luck with the code, and let me know if you see any bugs (of which
there are bound to be some!). 

- Sridhar (with thanks to Stefan for the datasets) 

