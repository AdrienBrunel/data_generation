# ==============================================================================
# INPUT VISUALISATION
# ==============================================================================

    ## Grid --------------------------------------------------------------------
        Plots.plot(xlim=lon_range, ylim=lat_range, title="Grid", xlabel=xloc_lab,ylabel=yloc_lab, size=(png_res_width,png_res_height),legend=false)
        for k in 1:N_pu
            xc = coords_data.xloc[k]
            yc = coords_data.yloc[k]
            if pu_data.is_locked_out[k] == 1
                Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor="grey",linecolor="black")
            else
                Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor="white",linecolor="black")
            end
            Plots.annotate!([(xc,yc,Plots.text(@sprintf("%d",k),text_size))])
        end
        png(string(pic_dir,"/grid.png"))

    ## Cost --------------------------------------------------------------------
        Plots.plot(xlim=lon_range, ylim=lat_range, title="Cost", xlabel=xloc_lab, ylabel=yloc_lab, size=(png_res_width,png_res_height),legend=false)
        C  = palette([:white, :yellow, :orange, :red],100)
        z  = pu_data.cost
        z1 = minimum(z)
        z2 = maximum(z)
        Z  = collect(range(z1,z2,length=length(C)))
        for k in 1:N_pu
            xc = coords_data.xloc[k]
            yc = coords_data.yloc[k]
            zk = z[k]
            if z1!=z2
                idx = min(findall(Z .- zk .> 0)...,length(Z))
                t = (zk-Z[idx-1])/(Z[idx]-Z[idx-1])
                ck = t*col2rgb(C[idx])+(1-t)*col2rgb(C[idx-1])
            else
                idx = 1
                ck = col2rgb(C[idx])
            end
            Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor=rgb2col(ck),linecolor=rgb2col(ck))
            Plots.annotate!([(xc,yc,Plots.text(@sprintf("%.1f",zk),text_size))])
        end
        png(string(pic_dir,"/cost.png"))




    ## Conservation Features ---------------------------------------------------
        for i in 1:N_cf
            title = @sprintf("CF%d\nmax_mean=%.1f | std=%.2f | N_epicentre=%d | alpha=%.2f",i,max_mean[i],std_dev[i],N_epicentre[i],alpha[i])
            Plots.plot(xlim=lon_range, ylim=lat_range, title=title, xlabel=xloc_lab,
                       ylabel=yloc_lab, size=(png_res_width,png_res_height),legend=false)
            C  = palette([:white, :yellow, :orange, :red],100)
            eval(Meta.parse("z = cf_data.cf$(i)"))
            z1 = minimum(z)
            z2 = maximum(z)
            Z  = collect(range(z1,z2,length=length(C)))
            for k in 1:N_pu
                xc = coords_data.xloc[k]
                yc = coords_data.yloc[k]
                zk = z[k]
                if z1!=z2
                  idx = min(findall(Z .- zk .> 0)...,length(Z))
                  t = (zk-Z[idx-1])/(Z[idx]-Z[idx-1])
                  ck = t*col2rgb(C[idx])+(1-t)*col2rgb(C[idx-1])
                else
                  idx = 1
                  ck = col2rgb(C[idx])
                end
                if pu_data.is_locked_out[k] == 1
                    Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor="grey",linecolor="grey")
                else
                    Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor=rgb2col(ck),linecolor=rgb2col(ck))
                end
                Plots.annotate!([(xc,yc,Plots.text(@sprintf("%.1f",zk),text_size))])
            end

            for k in epicentre[i,:]
                if k>0
                  xc = coords_data.xloc[k]
                  yc = coords_data.yloc[k]
                  zk = z[k]
                  if z1!=z2
                    idx = min(findall(Z .- zk .> 0)...,length(Z))
                    t = (zk-Z[idx-1])/(Z[idx]-Z[idx-1])
                    ck = t*col2rgb(C[idx])+(1-t)*col2rgb(C[idx-1])
                  else
                    idx = 1
                    ck = col2rgb(C[idx])
                  end
                  Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor=rgb2col(ck),linecolor="green", linewidth=5)
                end
            end
            png(string(pic_dir,"/cf$(i).png"))
        end

    ## Mean computed for each conservation features ----------------------------
        for i in ConservationFeatures
          title = @sprintf("Mean CF%d\nmax_mean=%.1f | std=%.2f | N_epicentre=%d | alpha=%.2f",i,max_mean[i],std_dev[i],N_epicentre[i],alpha[i])
          Plots.plot(xlim=lon_range, ylim=lat_range, title=title, xlabel=xloc_lab,
                     ylabel=yloc_lab, size=(png_res_width,png_res_height),legend=false)
          C  = palette([:white, :yellow, :orange, :red],100)
          eval(Meta.parse("z = cf_mean_data.m_cf$(i)"))
          z1 = minimum(z)
          z2 = maximum(z)
          Z  = collect(range(z1,z2,length=length(C)))
          for k in 1:N_pu
            xc = coords_data.xloc[k]
            yc = coords_data.yloc[k]
            zk = z[k]
            if z1!=z2
              idx = min(findall(Z .- zk .> 0)...,length(Z))
              t = (zk-Z[idx-1])/(Z[idx]-Z[idx-1])
              ck = t*col2rgb(C[idx])+(1-t)*col2rgb(C[idx-1])
            else
              idx = 1
              ck = col2rgb(C[idx])
            end
            if pu_data.is_locked_out[k] == 1
                Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor="grey",linecolor="grey")
            else
                Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor=rgb2col(ck),linecolor=rgb2col(ck))
            end
            Plots.annotate!([(xc,yc,Plots.text(@sprintf("%.1f",zk),text_size))])
          end
          for k in epicentre[i,:]
            if k>0
              xc = coords_data.xloc[k]
              yc = coords_data.yloc[k]
              zk = z[k]
              if z1!=z2
                idx = min(findall(Z .- zk .> 0)...,length(Z))
                t = (zk-Z[idx-1])/(Z[idx]-Z[idx-1])
                ck = t*col2rgb(C[idx])+(1-t)*col2rgb(C[idx-1])
              else
                idx = 1
                ck = col2rgb(C[idx])
              end
              Plots.plot!(rectangle(lon_res,lat_res,xc-lon_res/2,yc-lat_res/2),fillcolor=rgb2col(ck),linecolor="green", linewidth=5)
            end
          end
          png(string(pic_dir,"/m_cf$(i).png"))
        end
