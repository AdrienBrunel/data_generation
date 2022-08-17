# ==============================================================================
#  LOAD PARAMETERS
# ==============================================================================

    ## Read file ---------------------------------------------------------------
        param_fname = string(sc_dir,"/param.csv")

        if !isfile(param_fname)
            println("$(param_fname) not found ")
        end

    ## DataFrame ---------------------------------------------------------------
        fid = open(param_fname)
        max_length = 0
        while !eof(fid)
            line = readline(fid)
            elmt = split(line,",")
            if length(elmt) > max_length
                global max_length = length(elmt)
            end
        end
        max_length = max_length-1
        close(fid)

        var_name = ["r_seed" "N_x" "N_y" "N_cf" "max_mean" "std_dev" "alpha" "N_epicentre" "locked_out"]
        for k in 1:length(var_name)
            eval(Meta.parse("$(var_name[k]) = Array{String,1}(undef,max_length)"))
        end
        fid = open(param_fname)
        while !eof(fid)
            line = readline(fid)
            global elmt = split(line,",")
            for k in 1:length(var_name)
                if elmt[1] == var_name[k]
                    for i in 2:length(elmt)
                        eval(Meta.parse("$(var_name[k])[$(i-1)] = elmt[$(i)]"))
                    end
                    for i in length(elmt):max_length
                        eval(Meta.parse("$(var_name[k])[$(i)] = \"\""))
                    end
                end
            end
        end
        close(fid)
        param_data_string = DataFrame([r_seed N_x N_y N_cf max_mean std_dev alpha N_epicentre locked_out],:auto)
        rename!(param_data_string,["r_seed","N_x","N_y","N_cf","max_mean","std_dev","alpha","N_epicentre","locked_out"])

        # Reading/Parsing
        r_seed = parse.(Int64,param_data_string.r_seed[1])
        N_x    = parse.(Int64,param_data_string.N_x[1])
        N_y    = parse.(Int64,param_data_string.N_y[1])
        N_cf   = parse.(Int64,param_data_string.N_cf[1])
        max_mean = Array{Float64,1}()
        for k in 1:sum(param_data_string.max_mean .!= "")
          push!(max_mean, parse.(Float64,param_data_string.max_mean[k]))
        end
        std_dev = Array{Float64,1}()
        for k in 1:sum(param_data_string.std_dev .!= "")
          push!(std_dev, parse.(Float64,param_data_string.std_dev[k]))
        end
        alpha = Array{Float64,1}()
        for k in 1:sum(param_data_string.alpha .!= "")
          push!(alpha, parse.(Float64,param_data_string.alpha[k]))
        end
        N_epicentre = Array{Int64,1}()
        for k in 1:sum(param_data_string.N_epicentre .!= "")
          push!(N_epicentre, parse.(Int64,param_data_string.N_epicentre[k]))
        end
        locked_out = Array{Int64,1}()
        for k in 1:sum(param_data.locked_out .!= "")
          push!(locked_out, parse.(Int64,param_data.locked_out[k]))
        end
