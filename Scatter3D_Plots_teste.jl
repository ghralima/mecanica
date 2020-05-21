using Plots
using Printf

O3d = [0,0,0]
A3d = [8,2,7]
B3d = [-2,-8,6]
C3d = [-3,6,-9]

A3dstr = @sprintf("A = (%3.1f m, %3.1f m, %3.1f m)", A3d[1], A3d[2], A3d[3])
B3dstr = @sprintf("B = (%3.1f m, %3.1f m, %3.1f m)", B3d[1], B3d[2], B3d[3])
C3dstr = @sprintf("C = (%3.1f m, %3.1f m, %3.1f m)", C3d[1], C3d[2], C3d[3])

#ann_pts = [(A3d[1],A3d[2],A3d[3], text(A3dstr, color = :darkorange, fontsize = 10))]

scatter3d([O3d[1]],[O3d[2]],[O3d[3]], xaxis = ("posição x (m)", (-10,10), -10:1:10, font(10)),
    yaxis = ("posição y (m)", (-10,10), -10:1:10, font(10)),
    zaxis = ("posição z (m)", (-10,10), -10:1:10, font(10)), marker = :circle, color = :dodgerblue,
    markerstrokecolor = :blue, alpha = 0.7, markersize = 8, camera = (45,45), legend = true,
    label = "Referência")

scatter3d!([A3d[1]],[A3d[2]],[A3d[3]], marker = :diamond, color = :orange, markerstrokecolor = :darkorange,
    alpha = 0.7, markersize = 8, label = A3dstr)
plot!([0,A3d[1],A3d[1],A3d[1]],[0,0,A3d[2],A3d[2]],[0,0,0,A3d[3]], lw = 3, color = :orange, alpha = 0.3, label = :none)
plot!([0,A3d[1]],[0,A3d[2]],[0,A3d[3]], lw = 5, color = :darkorange, alpha = 0.5, label = :none)

scatter3d!([B3d[1]],[B3d[2]],[B3d[3]], marker = :pentagon, color = :red, markerstrokecolor = :darkred,
    alpha = 0.7, markersize = 8, label = B3dstr)
plot!([0,B3d[1],B3d[1],B3d[1]],[0,0,B3d[2],B3d[2]],[0,0,0,B3d[3]], lw = 3, color = :red, alpha = 0.3,
    line = arrow(4,4), label = :none)
plot!([0,B3d[1]],[0,B3d[2]],[0,B3d[3]], lw = 5, color = :darkred, alpha = 0.5, label = :none)

scatter3d!([C3d[1]],[C3d[2]],[C3d[3]], marker = :utriangle, color = :limegreen, markerstrokecolor = :forestgreen,
    alpha = 0.7, markersize = 8, label = C3dstr)
plot!([0,0,C3d[1],C3d[1]],[0,C3d[2],C3d[2],C3d[2]],[0,0,0,C3d[3]], lw = 3, color = :limegreen, alpha = 0.3,
    label = :none)
plot!([0,C3d[1]],[0,C3d[2]],[0,C3d[3]], lw = 5, color = :forestgreen, alpha = 0.5, label = :none)
