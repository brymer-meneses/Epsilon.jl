module Epsilon

# imports 
using LinearAlgebra

struct Tensor
    data::Matrix{Float64}
    requires_grad::Bool
    dependency::Array

    shape::Tuple{Int64, Int64}
    
    function Tensor(data, requires_grad=false, dependency=Array[]) 
        shape = size(data)

        return new(data, requires_grad, dependency, shape)
    end

    function Base.:show(io::IO, t1::Tensor)
        display(t1.data)
    end

    function Base.:-(t1::Tensor, t2::Tensor)
        result = t1.data - t2.data
        return result
    end

    function Base.:+(t1::Tensor, t2::Tensor)
        result = t1.data + t2.data
        return result
    end

    function Base.:*(t1::Tensor, t2::Tensor)
        result = t1.data * 
        return result
    end
end



function greet()
    println("hello from Epsilon")
end
    
end # module
