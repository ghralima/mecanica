using Plots
using LaTeXStrings
using Printf

function rotate_text(TextHeight::Float64, Vec::Vector{T}) where {T<:Real}
    modVec = hypot(Vec[1], Vec[2])
    Vec[1] >= 0 && (angVec = asind(Vec[2]/modVec))
    Vec[1] < 0 && (angVec = 180 - asind(Vec[2]/modVec))
    rotM = [cosd(angVec) sind(angVec)
           -sind(angVec) cosd(angVec)]
    TextPos = [modVec/2 TextHeight]
    return TextPos*rotM
end

default(grid = true, markersize = 8, framestyle = :none, linewidth = 3, legend = :false,
    aspect_ratio = :equal, gridalpha = 1)

#definindo número de vetores a serem somados
nvec = 8

#criando nvec vetores aleatórios
vecs = rand(-5:1:5, (nvec,2))

#resultante dos nvec vetores
res = [sum(vecs[:,1]), sum(vecs[:,2])]

#calculando ângulo que a resultante faz com a direção x
ang_res = atand(res[2]/res[1])

#string em latex com os valores de cada vetor.
vecstr = String("")
for i = 1:nvec
    global vecstr = string(vecstr, string("\\vec{a}_{", i,"} = (", vecs[i,1], ",", vecs[i,2], ")\\, \\newline"))
end

latexstring(vecstr)

#calculando limites na direção x e na direção y para a criação da imagem
xmax = max(vecs[1,1],0)
ymax = max(vecs[1,2],0)

xmin = min(vecs[1,1],0)
ymin = min(vecs[1,2],0)

#gerando vetor com os pontos de origem de cada um dos vetores que serão somados
origins = [0 0]

#calculando limites e origem dos vetores
for i = 2: nvec
    global origins = vcat(origins, [(origins[i-1,1] + vecs[i-1,1]) (origins[i-1,2] + vecs[i-1,2])])
    global xmax = max(xmax, origins[i,1], vecs[i,1])
    global ymax = max(ymax, origins[i,2], vecs[i,2])
    global xmin = min(xmin, origins[i,1], vecs[i,1])
    global ymin = min(ymin, origins[i,2], vecs[i,2])
end

xmax = max(xmax, res[1])
xmin = min(xmin, res[1])

ymax = max(ymax, res[2])
ymin = min(ymin, res[2])

xlimits = (xmin - 1, xmax + 1)
ylimits = (ymin - 1, ymax + 1)

#gerando texto que será inserido na imagem
res_pos = rotate_text(0.35, res)

resstr = latexstring("{\\rm Resultante:\\;} \\vec{S}  = (", res[1],",", res[2],")")

ann_res = [(res_pos[1,1], res_pos[1,2], text(resstr, halign = :center, valign = :center, pointsize = 24, rotation = ang_res))]

emailstr = "ghralima at cefetmg.br"
ann_autor = [((xmax +0.5),(ymax+ymin)/2, text(emailstr, halign = :center, valign = :center,
    pointsize = 18, rotation = 90, color = :dodgerblue))]

npoints = 30
a2_ani_x = vcat(range(0,origins[2,1], length = npoints), origins[2,1].+zeros(nvec*npoints))
a2_ani_y = vcat(range(0,origins[2,2], length = npoints), origins[2,2].+zeros(nvec*npoints))

origens_ani = [[a2_ani_x, a2_ani_y]]

line_somax = vcat(zeros((nvec-1)*npoints), range(0, res[1], length = npoints), res[1].+zeros(npoints))
line_somay = vcat(zeros((nvec-1)*npoints), range(0, res[2], length = npoints), res[2].+zeros(npoints))

for i = 3: nvec
    ai_ani_x = vcat(zeros((i-2)*npoints), range(0,origins[i,1], length = npoints), origins[i,1].+zeros((nvec+2-i)*npoints))
    ai_ani_y = vcat(zeros((i-2)*npoints), range(0,origins[i,2], length = npoints), origins[i,2].+zeros((nvec+2-i)*npoints))
    push!(origens_ani, [ai_ani_x, ai_ani_y])
end

anim = @animate for i = 1: (nvec+1)*npoints
    quiver([0],[0], quiver = ([vecs[1,1]],[vecs[1,2]]), lw = 2, alpha = 0.5, framestyle = :grid,
        xaxis = ("direção x", xlimits, xlimits[1]:1:xlimits[2]),
        yaxis = ("direção y", ylimits, ylimits[1]:1:ylimits[2]), ann = ann_autor, size = (800,800))
     for j = 2:nvec
        quiver!([origens_ani[j-1][1][i]],[origens_ani[j-1][2][i]], quiver = ([vecs[j,1]],[vecs[j,2]]),
            lw = 2, alpha = 0.5)
     end
     quiver!([0],[0], quiver = ([line_somax[i]],[line_somay[i]]), lw = 4)

     if i > nvec*30
        annotate!(ann_res)
     end
end

gif(anim, "soma_vetores_ani.gif", fps = 25)
