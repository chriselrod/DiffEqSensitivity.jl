using DiffEqSensitivity, SafeTestsets
using Test

const GROUP = get(ENV, "GROUP", "All")
const is_APPVEYOR = Sys.iswindows() && haskey(ENV,"APPVEYOR")
const is_TRAVIS = haskey(ENV,"TRAVIS")

@time begin
if GROUP == "All" || GROUP == "Core1" || GROUP == "Downstream"
    @time @safetestset "Forward Sensitivity" begin include("local_sensitivity/forward.jl") end
    @time @safetestset "Adjoint Sensitivity" begin include("local_sensitivity/adjoint.jl") end
    @time @safetestset "Sparse Adjoint Sensitivity" begin include("local_sensitivity/sparse_adjoint.jl") end
    @time @safetestset "Second Order Sensitivity" begin include("local_sensitivity/second_order.jl") end
    @time @safetestset "Concrete Solve Derivatives" begin include("local_sensitivity/concrete_solve_derivatives.jl") end
    @time @safetestset "Branching Derivatives" begin include("local_sensitivity/branching_derivatives.jl") end
    @time @safetestset "Derivative Shapes" begin include("local_sensitivity/derivative_shapes.jl") end
    @time @safetestset "Complex Adjoints" begin include("local_sensitivity/complex_adjoints.jl") end
end

if GROUP == "All" || GROUP == "Core2"
    @time @safetestset "Literal Adjoint" begin include("local_sensitivity/literal_adjoint.jl") end
    @time @safetestset "Stiff Adjoints" begin include("local_sensitivity/stiff_adjoints.jl") end
    @time @safetestset "Null Parameters" begin include("local_sensitivity/null_parameters.jl") end
    @time @safetestset "Callbacks with Adjoints" begin include("local_sensitivity/callbacks.jl") end
    @time @safetestset "Steady State Adjoint" begin include("local_sensitivity/steady_state.jl") end
    @time @safetestset "Concrete Solve Derivatives of Second Order ODEs" begin include("local_sensitivity/second_order_odes.jl") end
end

if GROUP == "All" || GROUP == "SDE1"
    @time @safetestset "SDE Adjoint" begin include("local_sensitivity/sde.jl") end
    @time @safetestset "SDE Scalar Noise" begin include("local_sensitivity/sde_scalar.jl") end
    @time @safetestset "SDE Checkpointing" begin include("local_sensitivity/sde_checkpointing.jl") end
end

if GROUP == "All" || GROUP == "SDE2"
    @time @safetestset "SDE Non-Diagonal Noise" begin include("local_sensitivity/sde_nondiag.jl") end
end

if GROUP == "All" || GROUP == "GSA"
    @time @safetestset "Morris Method" begin include("global_sensitivity/morris_method.jl") end
    @time @safetestset "Sobol Method" begin include("global_sensitivity/sobol_method.jl") end
    @time @safetestset "DGSM Method" begin include("global_sensitivity/DGSM.jl") end
    @time @safetestset "eFAST Method" begin include("global_sensitivity/eFAST_method.jl") end
    @time @safetestset "RegressionGSA Method" begin include("global_sensitivity/regression_sensitivity.jl") end
end

end
