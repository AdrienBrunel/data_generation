# ==============================================================================
#  CONSERVATION FEATURES DATA
# ==============================================================================

    ## Data declaration --------------------------------------------------------
        id     = Array{Int64,1}(undef,N_pu)
        amount = Array{Float64,1}(undef,N_pu)

    ## Computation -------------------------------------------------------------

        # Conservation features
        ConservationFeatures = collect(1:N_cf)

        # Planning units
        PlanningUnits = collect(1:N_pu)
        PlanningUnits_NotLockedOut = setdiff(collect(PlanningUnits),locked_out)

        # Epicentres amount for each conservation features
        epicentre = -1 .+ zeros(N_cf,maximum(N_epicentre))
        for i in ConservationFeatures
          epicentre[i,1:N_epicentre[i]] = rand(PlanningUnits_NotLockedOut,N_epicentre[i])
        end
        epicentre = convert(Array{Int64,2},epicentre)

        # Matrix of distances between each planning units
        dist_matrix = distance_matrix(N_pu,xloc,yloc)

        # Computation of the gaussian mean for each planning units and conservation features
        mean = zeros(N_cf,N_pu)
        amount = zeros(N_cf,N_pu)
        for i in ConservationFeatures
            if N_epicentre[i]==0
                pu_tmp = locked_out
            else
                pu_tmp = epicentre[i,epicentre[i,:] .> 0]
            end
            m = minimum(dist_matrix[pu_tmp,:])
            M = maximum(dist_matrix[pu_tmp,:])
            for j in PlanningUnits
                d = minimum(dist_matrix[pu_tmp,j])
                mean[i,j] = round(max_mean[i]*(d^alpha[i]-M^alpha[i])/(m^alpha[i]-M^alpha[i]), digits=2)
            end
            amount[i,:] = max.(0,round.(mean[i,:] .+ std_dev[i] .* randn(N_pu), digits=2))
        end

        id = zeros(N_pu,1)
        for j in PlanningUnits
            id[j] = j
        end

    ## Generation ----------------------------------------------------------------
        df_field_str = "id"
        df_name_str = "\"id\""
        for i in ConservationFeatures
            global df_field_str = @sprintf("%s mean[%d,:]",df_field_str,i)
            global df_name_str = @sprintf("%s,\"m_cf%d\"",df_name_str,i)
        end
        eval(Meta.parse("cf_mean_data  = DataFrame([$(df_field_str)])"))
        eval(Meta.parse("rename!(cf_mean_data,[$(df_name_str)])"))
        cf_mean_fname = string(sc_dir,"/cf_mean.csv")
        cf_mean_data.id = convert(Array{Int64,1},cf_mean_data.id)
        CSV.write(cf_mean_fname, cf_mean_data, writeheader=true)


        df_field_str = "id"
        df_name_str = "\"id\""
        for i in ConservationFeatures
            global df_field_str = @sprintf("%s amount[%d,:]",df_field_str,i)
            global df_name_str = @sprintf("%s,\"cf%d\"",df_name_str,i)
        end
        eval(Meta.parse("cf_data  = DataFrame([$(df_field_str)])"))
        eval(Meta.parse("rename!(cf_data,[$(df_name_str)])"))
        cf_fname = string(sc_dir,"/cf.csv")
        cf_data.id = convert(Array{Int64,1},cf_data.id)
        CSV.write(cf_fname, cf_data, writeheader=true)
