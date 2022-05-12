# ==============================================================================
# PARAMETERS GENERATION
# ==============================================================================

    ## Parameters --------------------------------------------------------------
        r_seed      = 1
        Random.seed!(r_seed)

        N_x         = 50
        N_y         = 40
        N_cf        = 10

        max_mean    = round.(1 .+ (10-1).*rand(N_cf),digits=1)
        std_dev     = [0.2,0.2,0.2]
        alpha       = round.(0.5 .+ (1-0.5).*rand(N_cf),digits=3)

        N_epicentre = [0,1,2,3,0,3,4,5,2,1]
        locked_out  = [1020:1022;1070:1072;1120:1122]

    ## Generation --------------------------------------------------------------
        max_length = max(2,length(locked_out),length(max_mean),length(alpha),length(N_epicentre))
        param_data = Array{String,2}(undef,max_length,9)
        param_data[1,1:4] = [string(r_seed),string(N_x),string(N_y),string(N_cf)]
        cpt = 0
        var_name = ["r_seed" "N_x" "N_y" "N_cf" "max_mean" "std_dev" "alpha" "N_epicentre" "locked_out"]
        for k in 1:length(var_name)
            global cpt = cpt+1
            eval(Meta.parse("var_length = length($(var_name[k]))"))
            if (var_name[k] == "max_mean") | (var_name[k] == "std_dev") | (var_name[k] == "alpha") | (var_name[k] == "N_epicentre") | (var_name[k] == "locked_out")
                for i in 1:max_length
                    if (i <= var_length)
                        eval(Meta.parse("param_data[$(i),$(cpt)] = string($(var_name[k])[$(i)])"))
                    else
                        param_data[i,cpt] = ""
                    end
                end
            else
                param_data[2:max_length,cpt] .= ""
            end
        end
        param_data = convert(DataFrame,param_data)
        rename!(param_data,["r_seed","N_x","N_y","N_cf","max_mean","std_dev","alpha","N_epicentre","locked_out"])

        param_fname = string(sc_dir,"/param.csv")
        fid = open(param_fname,"w")
        str    = Array{String,1}(undef,9)
        str[1] = @sprintf("r_seed,%d",r_seed)
        str[2] = @sprintf("N_x,%d",N_x)
        str[3] = @sprintf("N_y,%d",N_y)
        str[4] = @sprintf("N_cf,%d",N_cf)
        str[5] = "max_mean,"
        for i in 1:length(max_mean)
            if i == length(max_mean)
                global str[5] = string(str[5],@sprintf("%.1f",max_mean[i]))
            else
                global str[5] = string(str[5],@sprintf("%.1f,",max_mean[i]))
            end
        end
        str[6] = "std_dev,"
        for i in 1:length(alpha)
            if i == length(alpha)
                global str[6] = string(str[6],@sprintf("%.2f",std_dev[i]))
            else
                global str[6] = string(str[6],@sprintf("%.2f,",std_dev[i]))
            end
        end
        str[7] = "alpha,"
        for i in 1:length(alpha)
            if i == length(alpha)
                global str[7] = string(str[7],@sprintf("%.2f",alpha[i]))
            else
                global str[7] = string(str[7],@sprintf("%.2f,",alpha[i]))
            end
        end
        str[8] = "N_epicentre,"
        for i in 1:length(N_epicentre)
            if i == length(N_epicentre)
                global str[8] = string(str[8],@sprintf("%d",N_epicentre[i]))
            else
                global str[8] = string(str[8],@sprintf("%d,",N_epicentre[i]))
            end
        end
        str[9] = "locked_out,"
        for i in 1:length(locked_out)
            if i == length(locked_out)
                global str[9] = string(str[9],@sprintf("%d",locked_out[i]))
            else
                global str[9] = string(str[9],@sprintf("%d,",locked_out[i]))
            end
        end
        writedlm(fid,str)
        close(fid)
