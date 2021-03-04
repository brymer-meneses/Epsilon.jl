module Epsilon

# imports 
using LinearAlgebra

struct Dependency 
    t::Tensor 
    grad_fn

    function Dependency(t, grad_fn)
        return new(t, grad_fn)
    end 

end

struct Tensor <: AbstractArray{Float64, Float64}
    
    data::Array{Float64}
    requires_grad::Bool
    depends_on::Array{Dependency}

    shape
    
    function Tensor(data, requires_grad=false, depends_on =Array[]) 
        shape = size(data)

        # Makes it possible to use Tensor(1)
        if shape == ()
            data = [data]
        end

        return new(data, requires_grad, depends_on, shape)
    end

    function Base.:transpose(t1::Tensor)
        return Tensor(transpose(t1.data), t1.requires_grad, t1.depends_on)
    end

    function Base.:show(io::IO, t1::Tensor)
        display(t1.data)
    end

    function Base.:+(t1::Tensor, t2::Tensor)
        return add(t1, t2)
    end

    function Base.:*(t1::Tensor, t2::Tensor)
        return mul(t1, t2)
    end

    function Base.:sum(t1::Tensor)
        return tensor_sum(t1)
    end

end

function tensor_sum(t::Tensor)
    result = sum(t.data)
    requires_grad = t.requires_grad

    if requires_grad
        function grad_fn(grad)
            
            grad * ones(t.shape[1], t.shape[2])
            return grad
        end

        depends_on = Dependency(t, grad_fn)
    else 
        depends_on = Nothing

    return Tensor(data, requires_grad, depends_on)
end


function add(t1::Tensor, t2::Tensor)
    result = t1.data + t2.data
    return result
end

function mul(t1::Tensor, t2::Tensor)
    result = t1.data * t2.data
    return result
end


function greet()
    println("hello from Epsilon")
end
    
end # module
