using Makie
using LinearAlgebra
import Random.seed!

function pair_energy(p1, p2, D, r)
    x = norm(p1 - p2)
    if x == 0
        return 0
    end
    return D * ((r / x)^12 - (r / x)^6)
end

function sys_energy(positions, D, r)
    return sum([pair_energy(positions[i,:], positions[j,:], D, r) for j in 1:size(positions)[1], i in 1:size(positions)[1]]) / 2
end

function simulate(initial_positions, D, r, d, kT, steps=1e5)
    energy = sys_energy(initial_positions, D, r)
    pos = copy(initial_positions)
    num_particles = size(pos)[1]
    plotscene = scatter(pos[:,1], pos[:,2])
    xlims!(plotscene, (-150, 150))
    ylims!(plotscene, (-150, 150))
    record(plotscene, "file.mp4") do io
        for i in 1:steps
            old_pos = copy(pos)
            old_energy = energy
            pos[rand(1:num_particles), :] += d * (2 * rand(2) .- 1)
            energy = sys_energy(pos, D, r)
            if energy > old_energy
                if rand() > exp(-(energy - old_energy) / kT)
                    energy = old_energy
                    pos = old_pos
                end
            end
            if (i % (steps / 1000) == 0)
                println("plot for ", i)
                delete!(plotscene, plotscene[end])
                scatter!(plotscene, pos[:,1], pos[:,2])
                recordframe!(io)
            end
        end
    end
end

seed!(0);
pos1 = 2 * (rand(25, 2) * 2 .+ 9);
pos2 = 2 * (rand(25, 2) * 2 .- 11);
pos = vcat(pos1, pos2)
simulate(pos, 30, 50, 0.2, 1000, 1e5)
