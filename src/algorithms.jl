abstract type OrdinaryDiffEqAlgorithm <: AbstractODEAlgorithm end
abstract type OrdinaryDiffEqAdaptiveAlgorithm <: OrdinaryDiffEqAlgorithm end
abstract type OrdinaryDiffEqCompositeAlgorithm <: OrdinaryDiffEqAlgorithm end

immutable Discrete{apply_map,scale_by_time} <: OrdinaryDiffEqAlgorithm end

Base.@pure Discrete(;apply_map=false,scale_by_time=false) = Discrete{apply_map,scale_by_time}()
Base.@pure FunctionMap(;scale_by_time=false) = Discrete{true,scale_by_time}()
immutable Euler <: OrdinaryDiffEqAlgorithm end
immutable Midpoint <: OrdinaryDiffEqAlgorithm end
immutable RK4 <: OrdinaryDiffEqAlgorithm end
immutable SSPRK22 <: OrdinaryDiffEqAlgorithm end
immutable SSPRK33 <: OrdinaryDiffEqAlgorithm end
immutable SSPRK104 <: OrdinaryDiffEqAlgorithm end

#immutable Verlet <: OrdinaryDiffEqAlgorithm end
immutable SymplecticEuler <: OrdinaryDiffEqAlgorithm end
immutable VelocityVerlet <: OrdinaryDiffEqAlgorithm end
immutable Ruth3 <: OrdinaryDiffEqAlgorithm end

immutable SplitEuler <: OrdinaryDiffEqAlgorithm end

@with_kw immutable ExplicitRK{TabType} <: OrdinaryDiffEqAdaptiveAlgorithm
  tableau::TabType=ODE_DEFAULT_TABLEAU
end

immutable SSPRK432 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable BS3 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable BS5 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable DP5 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable DP5Threaded <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Tsit5 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable DP8 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Vern6 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Vern7 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Vern8 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable TanYam7 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable TsitPap8 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Vern9 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Feagin10 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Feagin12 <: OrdinaryDiffEqAdaptiveAlgorithm end
immutable Feagin14 <: OrdinaryDiffEqAdaptiveAlgorithm end

immutable ImplicitEuler{F} <: OrdinaryDiffEqAlgorithm
  nlsolve::F
end
Base.@pure ImplicitEuler(;nlsolve=NLSOLVEJL_SETUP()) = ImplicitEuler{typeof(nlsolve)}(nlsolve)

immutable Trapezoid{F} <: OrdinaryDiffEqAlgorithm
  nlsolve::F
end
Base.@pure Trapezoid(;nlsolve=NLSOLVEJL_SETUP()) = Trapezoid{typeof(nlsolve)}(nlsolve)

immutable Rosenbrock23{CS,AD,F} <: OrdinaryDiffEqAdaptiveAlgorithm
  linsolve::F
  diff_type::Symbol
end
Base.@pure Rosenbrock23(;chunk_size=0,autodiff=true,diff_type=:central,linsolve=DEFAULT_LINSOLVE) = Rosenbrock23{chunk_size,autodiff,typeof(linsolve)}(linsolve,diff_type)

immutable Rosenbrock32{CS,AD,F} <: OrdinaryDiffEqAdaptiveAlgorithm
  linsolve::F
  diff_type::Symbol
end
Base.@pure Rosenbrock32(;chunk_size=0,autodiff=true,diff_type=:central,linsolve=DEFAULT_LINSOLVE) = Rosenbrock32{chunk_size,autodiff,typeof(linsolve)}(linsolve,diff_type)

immutable IIF1{F} <: OrdinaryDiffEqAlgorithm
  nlsolve::F
end
Base.@pure IIF1(;nlsolve=NLSOLVEJL_SETUP()) = IIF1{typeof(nlsolve)}(nlsolve)

immutable IIF2{F} <: OrdinaryDiffEqAlgorithm
  nlsolve::F
end
Base.@pure IIF2(;nlsolve=NLSOLVEJL_SETUP()) = IIF2{typeof(nlsolve)}(nlsolve)

immutable LawsonEuler <: OrdinaryDiffEqAlgorithm end
immutable NorsettEuler <: OrdinaryDiffEqAlgorithm end

immutable GeneralRosenbrock{CS,AD,F,TabType} <: OrdinaryDiffEqAdaptiveAlgorithm
  tableau::TabType
  factorization::F
end

Base.@pure GeneralRosenbrock(;chunk_size=0,autodiff=true,
                    factorization=lufact!,tableau=ROSENBROCK_DEFAULT_TABLEAU) =
                    GeneralRosenbrock{chunk_size,autodiff,typeof(factorization),typeof(tableau)}(tableau,factorization)

immutable CompositeAlgorithm{T,F} <: OrdinaryDiffEqCompositeAlgorithm
  algs::T
  choice_function::F
end
