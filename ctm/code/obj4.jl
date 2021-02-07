ls = lowercase("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
ln = []
for i in ls
    if isdigit(i)
        push!(ln, parse(Int, i))
    elseif isletter(i)
        push!(ln, i - 'a' + 10)
    else
        push!(ln, Dict(':' => 36, '/' => 37, '?' => 38, '=' => 39, '.' => 40)[i])
    end
end
println(ls)
println(ln)
println(join(string.(ln, base=2, pad=6)),"")
