
wh = [[2 3 4]; [0 5 2.5]; [5 5 5]]
planets = []
for i in 1:10
    push!(planets, wh[rand(1:3), :] + 1.5 * (2 * rand(3) .- 1))
end
planets = [planets[i][j] for i in 1:10, j in 1:3]
println(planets)
