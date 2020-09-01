```julia
function simulate(path::AbstractString, miss_prob::Float64)
    pos::Complex = 0+0im
    dir::Complex = 1im
    for step in path
        if step == 'L' && rand() < 1-miss_prob
            dir *= 1im
        elseif step == 'R' && rand() < 1-miss_prob
            dir *= 1im
        else
            pos+=dir
        end
    end
    return pos
end

path = strip(read(open("path", "r"), String))

l = [simulate(path, 0.45) for _ in 1:150]
sum(abs.( l .- simulate(path, 0.)))/150
```
