==================================================
# data_generation
Code allowing to generate data needed in the reserve site selection discrete optimization problem, i.e. conservation features and cost distributions. 

# Goal
We provide a systematic way of building scenarios with a user-defined complexity for reserve site selection optimization problem. We thus hope to facilitate transparent benchmarks of developed methodologies in the conservation literature.

# Method
The main principle is to build realistic spatial distributions for conservation features. Thus, in order to compute the amount of conservation feature in a planning unit, we chose to randomly draw this value in a gaussian distribution whose mean value depends on the distance to the closest (chosen or randomly drawn) epicentres of the conservation feature. If no epicentre is provided, the mean value depends on the distance to the locked-out planning units supposed to represent a shoreline.  


==================================================
# functions
Julia scripts used for data generation : 
- gen_param.jl : the user can set parameters according to the scenario desired for data generation. 
  "r_seed" is the random seed.
  "N_x" and "N_y" gives the size of the rectangular grid.
  "N_cf" gives the number of conservation features.
  "max_mean" gives the maximum mean value of the gaussian distribution for each conservation feature.
  "std_dev" gives the standard deviation of the gaussian distribution for each conservation feature.
  "alpha" is a parameter controlling the spreading of the gaussian distribution for each conservation feature.
  "N_epicentre" gives the number of epicentres for each conservation feature.
  "locked_out" gives the identifiers of the locked_out planning units.
- gen_bound.jl : generate and store in "bound.csv" the common boundary length "boundary" (1 by default) between two planning units whose identifiers are "id1" and "id2".   
- gen_cf.jl : generate and store in "cf.csv" the amount of every conservation features within each planning units according to the method described above. For controlling purposes, "cf_mean.csv" is also produced and gives the mean value computed for every conservation features and planning units.    
- gen_grid.jl : parameters of the rectangular grid considered
- gen_pu.jl : generate and store in "pu.csv" the cost associated to every planning units. The link between planning unit identifier and coordinates is found in "coords.csv". For controlling purposes, we also produced "pu_wepi.csv" telling if a planning unit is an epicentre for a given conservation feature. 


Julia scripts used for data visualisation (WARNING: visualisation can take a lot of time in julia, at least with the code I provide): 
- visu_opt.jl : user can set options for parameters used in the visualisation
- visualisation output : plot the grid, the cost distribution, the conservation feature amount distribution and the mean value of the gaussian distribution of each conservation feature.  

Others scripts : 
- load_functions.jl : functions needed for visualisation and computation purposes. 
- load_output.jl : script allowing to read and store data found in "pu_wepi.csv","cf.csv","cf_mean.csv","coords.csv"
- load_param.jl : script allowing to read and store data found in "params.csv".
- manage_package.jl : load needed julia libraries.
- manage_path.jl : build needed paths in a systematic way only depending on the root directory. 


# results
This folder contains csv files and pictures produced by runnig "main.jl" according to the scenario written in "gen_param.jl"

