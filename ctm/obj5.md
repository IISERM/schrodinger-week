```julia
using Plots

function acceleration(pos_this, pos_that, mass_that)
    rvec = pos_this - pos_that
    r = abs(rvec)
    if r == 0
        return 0im
    end
    return -mass_that / r^3 * rvec
end

function plot_object!(pos, pl=nothing)
    if pl === nothing
        pl = plot(aspect_ratio=1)
    end
    plot!(pl, t -> 0.0002 * (cos(t) - real(pos)), t -> 0.0002 * (sin(t) - imag(pos)), -pi, pi)
    return pl
end

function simulate(positions::Array, velocities::Array, masses::Array, dt::Float64, end_time::Float64)
    t = 0;
    pos = [complex(i...) for i in positions];
    vel = [complex(i...) for i in velocities];
    steps = Int(div(end_time, dt))
    poses = zeros(Complex{Float64}, (steps, length(positions)))
    for i in 1:steps
        acc = dropdims(sum([acceleration(pos[i], pos[j], masses[j]) for i in 1:length(pos), j in 1:length(pos)], dims=2), dims=2)
        vel .+= acc * dt;
        pos .+= vel * dt;
        poses[i,:] .= pos
        t += dt;
    end
    points = poses
    plot()
    for i in 1:length(positions)
        plot!(points[:,i]);
    end
    return current()
end
savefig(simulate([[1.,0.], [-1.,0.], [0.,0.]], 1.556 * [[0.,1.], [0.,-1.], [0.001,0.]], [1., 1., 1.], 0.01, 1000.), "obj5.png")
```
