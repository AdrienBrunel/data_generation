# ==============================================================================
#  PATH MANAGEMENT
# ==============================================================================
    func_dir   = "$(root_dir)/functions";
    res_dir    = "$(root_dir)/results";
    sc_dir     = "$(res_dir)/$(folder)";
    pic_dir    = "$(sc_dir)/pictures/";

    for dir in [sc_dir;pic_dir]
        if !isdir(dir)
            mkdir(dir);
            println("Creation of folder $(dir)")
        end
    end
