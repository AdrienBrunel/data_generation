# ==============================================================================
#  LOAD INPUT
# ==============================================================================

    ## Load --------------------------------------------------------------------
        pu_fname      = string(sc_dir,"/pu_wepi.csv")
        cf_mean_fname = string(sc_dir,"/cf_mean.csv")
        cf_fname      = string(sc_dir,"/cf.csv")
        coords_fname  = string(sc_dir,"/coords.csv")

        for f in [pu_fname,cf_fname,cf_mean_fname,coords_fname]
            if !isfile(f)
                println("$(f) not found ")
            end
        end

    ## DataFrame ---------------------------------------------------------------
        pu_data      = CSV.read(pu_fname, header=1, delim=",")
        cf_data      = CSV.read(cf_fname, header=1, delim=",")
        cf_mean_data = CSV.read(cf_mean_fname, header=1, delim=",")
        coords_data  = CSV.read(coords_fname, header=1, delim=",")
