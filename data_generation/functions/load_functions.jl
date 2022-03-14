# ==============================================================================
#  GRID
# ==============================================================================

    ## PU coordinates ----------------------------------------------------------
        function coords(N_x,N_y,a1,a2,b1,b2)
            xloc = Array{Float64,1}(undef,N_x*N_y)
            yloc = Array{Float64,1}(undef,N_x*N_y)
            row_num = 0
            for k in 1:N_pu
                if mod(k,N_x) == 0
                    col_num = N_x
                else
                    col_num = mod(k,N_x)
                end
                xloc[k] = round(a1*(col_num-1)+b1,digits=2)
                if mod(k,N_x) == 1
                    row_num = row_num + 1
                end
                yloc[k] = round(a2*(row_num-1)+b2,digits=2)
            end
            return xloc,yloc
        end

    ## Matrix of distances between planning units ------------------------------
        function distance_matrix(N_pu,xloc,yloc)
            D = zeros(N_pu,N_pu)
            for j1 in 1:N_pu
                for j2 in (j1+1):N_pu
                    D[j1,j2] = round(sqrt((xloc[j1]-xloc[j2])^2 + (yloc[j1]-yloc[j2])^2),digits=3)
                    D[j2,j1] = D[j1,j2]
                end
            end
            return D
        end


# ==============================================================================
#  VISUALISATION
# ==============================================================================

    ## Color to RGB vector -----------------------------------------------------
        function col2rgb(color)
            color_rgb = RGB(color)
            return [color_rgb.r,color_rgb.g,color_rgb.b]
        end

    ## RGB vector to color -----------------------------------------------------
        function rgb2col(color_rgb)
            return RGB(color_rgb[1],color_rgb[2],color_rgb[3])
        end

    ## Rectangle shape ---------------------------------------------------------
        rectangle(w, h, x, y) = Plots.Shape(x .+ [0,w,w,0], y .+ [0,0,h,h])
