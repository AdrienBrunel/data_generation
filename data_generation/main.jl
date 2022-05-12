clearconsole(); root_dir=pwd();
# ==============================================================================
# 1 - PARAMETERS
# ==============================================================================
    folder = "sc_50x40pu_10cf"
    gen    = true
    visu   = true

    println("manage_path.jl    ...");include("$(root_dir)/functions/manage_path.jl");
    println("manage_package.jl ...");include("$(func_dir)/manage_package.jl");
    println("load_functions.jl ...");include("$(func_dir)/load_functions.jl");

# ==============================================================================
# 2 - GENERATION
# ==============================================================================
if gen == true
    t1 = time_ns()
    println("gen_param.jl ...");include("$(func_dir)/gen_param.jl");
    println("gen_grid.jl  ...");include("$(func_dir)/gen_grid.jl");
    println("gen_cf.jl    ...");include("$(func_dir)/gen_cf.jl");
    println("gen_pu.jl    ...");include("$(func_dir)/gen_pu.jl");
    println("gen_bound.jl ...");include("$(func_dir)/gen_bound.jl");
    t2 = time_ns()
    @printf("\nInput files generated (%.2fs) \n\n",(t2-t1)/1e9)
end

# ==============================================================================
# 4 - VISUALISATION
# ==============================================================================
if visu == true
    t1 = time_ns()
    println("load_param.jl  ...");include("$(func_dir)/load_param.jl");
    println("load_output.jl  ...");include("$(func_dir)/load_output.jl");
    println("visu_opt.jl    ...");include("$(func_dir)/visu_opt.jl");
    println("visu_output.jl ...");include("$(func_dir)/visu_output.jl");
    t2 = time_ns()
    @printf("\nVisualisation over (%.2fs) \n\n",(t2-t1)/1e9)
end
