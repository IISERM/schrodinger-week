using Combinatorics
using LinearAlgebra

function distancebetween(i, j, bodies, num_planets)
    if j == 0
        return norm(bodies[i,:])
    end
    if i > num_planets && j > num_planets
        return 0
    end
    return norm(bodies[i,:] .- bodies[j,:])
end
function f(bodies, num_planets)
    shortest_path = []
    shortest_path_length = Inf
    for path in permutations(1:size(bodies)[1])
        path_length = 0
        path_till_now = [0]
        for i in path
            path_length += distancebetween(i, path_till_now[end], bodies, num_planets)
            if path_length > shortest_path_length
                break
            end
            push!(path_till_now, i)
        end
        shortest_path = path_till_now
        shortest_path_length = path_length
    end
end
planets = [ 4.08843	    4.69975	5.41835;
            1.01513	    5.89078	1.48675;
            6.04748	    3.76679	5.91324;
            1.18806	    3.26168	4.75359;
            5.81472	    3.50833	3.5276;
            1.78623	    1.80381	4.97739;
            -0.618259	6.18706	3.0477;
            1.3763	    3.78712	5.16773;
            5.68307	    4.41375	5.18493;
            1.27576	    5.36594	3.70002;]

whs = [ 2.0	3.0	4.0;
	    0.0	5.0	2.5;
        5.0	5.0	5.0;]
f(vcat(planets, whs), size(planets)[1])
