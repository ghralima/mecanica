using Makie
AbstractPlotting.inline!(false)

O3d = [0,0,0]
A3d = [8,2,7]
B3d = [-2,-8,6]
C3d = [-3,6,-9]

limits = FRect3D(Vec3f0(-10, -10, -10), Vec3f0(20, 20, 20))

scene = Scene(resolution = (1200,1200))

AbstractPlotting.meshscatter!(scene, [O3d[1]],[O3d[2]],[O3d[3]], color = :dodgerblue,
    limits = limits, markersize = 0.5)
axis = scene[Axis]
axis.names.axisnames = ("posição x (m)", "posição y (m)", "posição z (m)")
axis.names.textsize = 5


AbstractPlotting.meshscatter!([A3d[1]],[A3d[2]],[A3d[3]], color = :orange, markersize = 0.5, transparency = true)
arrows!([0],[0],[0],[A3d[1]],[A3d[2]],[A3d[3]], arrowcolor = :orange, linecolor = :orange, linewidth = 5,
    arrowsize = 0.5)
arrows!([0,A3d[1],A3d[1]],[0,0,A3d[2]],[0,0,0],[A3d[1],0,0],[0,A3d[2],0],[0,0,A3d[3]],
    arrowcolor = :darkorange, linecolor = :orange, linewidth = 5, linestyle = :dash, arrowsize = 0.5)

AbstractPlotting.meshscatter!([B3d[1]],[B3d[2]],[B3d[3]], color = :red, markersize = 0.5, transparency = true)
arrows!([0],[0],[0],[B3d[1]],[B3d[2]],[B3d[3]], arrowcolor = :red, linecolor = :red, linewidth = 5,
    arrowsize = 0.5)
arrows!([0,B3d[1],B3d[1]],[0,0,B3d[2]],[0,0,0],[B3d[1],0,0],[0,B3d[2],0],[0,0,B3d[3]],
    arrowcolor = :darkred, linecolor = :red, linewidth = 5, linestyle = :dash, arrowsize = 0.5)

AbstractPlotting.meshscatter!([C3d[1]],[C3d[2]],[C3d[3]], color = :limegreen, markersize = 0.5, transparency = true)
arrows!([0],[0],[0],[C3d[1]],[C3d[2]],[C3d[3]], arrowcolor = :limegreen, linecolor = :limegreen, linewidth = 5,
    arrowsize = 0.5)
arrows!([0,0,C3d[1]],[0,C3d[2],C3d[2]],[0,0,0],[0,C3d[1],0],[C3d[2],0,0],[0,0,C3d[3]],
    arrowcolor = :forestgreen, linecolor = :limegreen, linewidth = 5, linestyle = :dash, arrowsize = 0.5)

scene
