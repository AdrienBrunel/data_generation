# ==============================================================================
#  PU DATA
# ==============================================================================

    ## Data declaration ----------------------------------------------------------
        id            = Array{Int64,1}(undef,N_pu)
        cost          = Array{Float64,1}(undef,N_pu)
        is_locked_out = Array{Int64,1}(undef,N_pu)
        epi           = Array{Int64,1}(undef,N_pu)

    ## Computation ---------------------------------------------------------------
        cost = zeros(N_pu,1)
        for j in PlanningUnits
            id[j] = j
            #cost[j] = 1
            cost[j] = rand(1:10)


            is_locked_out[j] = 0
            if length(findall(locked_out .== j))>0
                is_locked_out[j] = 1
            end
            epi[j] = 0
            for i in ConservationFeatures
                if length(findall(epicentre[i,:] .== j))>0
                    epi[j] = i
                end
            end
        end
        cost = round.(1 .+ (10-1).*rand(N_pu),digits=1)

    ## Generation ----------------------------------------------------------------
        pu_wepi_fname = string(sc_dir,"/pu_wepi.csv")
        pu_wepi_data  = DataFrame([id xloc yloc cost is_locked_out epi])
        rename!(pu_wepi_data,["id","xloc","yloc","cost","is_locked_out","epicentre"])
        pu_wepi_data.id = convert(Array{Int64,1},pu_wepi_data.id)
        CSV.write(pu_wepi_fname, pu_wepi_data, writeheader=true)

        pu_fname = string(sc_dir,"/pu.csv")
        pu_data  = DataFrame([id cost is_locked_out])
        rename!(pu_data,["id","cost","is_locked_out"])
        pu_data.id = convert(Array{Int64,1},pu_data.id)
        CSV.write(pu_fname, pu_data, writeheader=true)

        coords_fname = string(sc_dir,"/coords.csv")
        coords_data  = DataFrame([id xloc yloc])
        rename!(coords_data,["id","xloc","yloc"])
        coords_data.id = convert(Array{Int64,1},coords_data.id)
        CSV.write(coords_fname, coords_data, writeheader=true)
