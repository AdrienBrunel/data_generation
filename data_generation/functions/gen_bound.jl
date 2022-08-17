# ==============================================================================
#  BOUNDARY DATA
# ==============================================================================

    ## Data declaration --------------------------------------------------------
        id1      = Array{Int64,1}()
        id2      = Array{Int64,1}()
        boundary = Array{Float64,1}()

    ## Computation -------------------------------------------------------------
        for k in 1:N_pu
            if mod(k,N_x) != 0
                push!(id1,k)
                push!(id2,k+1)
                push!(boundary,1)
            end
        end

        for k in 1:((N_y-1)*N_x)
            push!(id1,k)
            push!(id2,k+N_x)
            push!(boundary,1)
        end

    ## Generation --------------------------------------------------------------
        bound_fname = string(sc_dir,"/bound.csv")
        bound_data  = DataFrame([id1 id2 boundary],:auto)
        rename!(bound_data,["id1","id2","boundary"])
        bound_data.id1 = convert(Array{Int64,1},bound_data.id1)
        bound_data.id2 = convert(Array{Int64,1},bound_data.id2)
        CSV.write(bound_fname, bound_data, header=true)
