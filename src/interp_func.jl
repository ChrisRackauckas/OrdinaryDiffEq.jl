abstract type OrdinaryDiffEqInterpolation{cacheType} <: AbstractDiffEqInterpolation end

immutable InterpolationData{F,uType,tType,kType,cacheType} <: OrdinaryDiffEqInterpolation{cacheType}
  f::F
  timeseries::uType
  ts::tType
  ks::kType
  notsaveat_idxs::Vector{Int}
  dense::Bool
  cache::cacheType
end

immutable CompositeInterpolationData{F,uType,tType,kType,cacheType} <: OrdinaryDiffEqInterpolation{cacheType}
  f::F
  timeseries::uType
  ts::tType
  ks::kType
  alg_choice::Vector{Int}
  notsaveat_idxs::Vector{Int}
  dense::Bool
  cache::cacheType
end

DiffEqBase.interp_summary{cacheType<:DiscreteConstantCache}(interp::OrdinaryDiffEqInterpolation{cacheType}) = "left-endpoint piecewise constant"
DiffEqBase.interp_summary{cacheType<:DiscreteCache}(interp::OrdinaryDiffEqInterpolation{cacheType}) = "left-endpoint piecewise constant"
function DiffEqBase.interp_summary{cacheType<:Union{DP5ConstantCache,DP5Cache,DP5ThreadedCache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 4th order \"free\" interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{Rosenbrock23ConstantCache,Rosenbrock32ConstantCache,Rosenbrock23Cache,Rosenbrock32Cache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 2nd order \"free\" stiffness-aware interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{SSPRK22,SSPRK22ConstantCache,SSPRK33,SSPRK33ConstantCache,SSPRK432,SSPRK432ConstantCache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "2nd order \"free\" SSP interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{Tsit5Cache,Tsit5ConstantCache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 4th order \"free\" interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{BS5ConstantCache,BS5Cache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 5th order lazy interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{Vern6Cache,Vern6ConstantCache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 6th order lazy interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{Vern7Cache,Vern7ConstantCache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 7th order lazy interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{Vern8Cache,Vern8ConstantCache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 8th order lazy interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{Vern9Cache,Vern9ConstantCache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 9th order lazy interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType<:Union{DP8ConstantCache,DP8Cache}}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "specialized 7th order interpolation" : "1st order linear"
end
function DiffEqBase.interp_summary{cacheType}(interp::OrdinaryDiffEqInterpolation{cacheType})
  interp.dense ? "3rd order Hermite" : "1st order linear"
end

(interp::InterpolationData)(tvals,idxs,deriv) = ode_interpolation(tvals,interp,idxs,deriv)
(interp::CompositeInterpolationData)(tvals,idxs,deriv) = ode_interpolation(tvals,interp,idxs,deriv)
(interp::InterpolationData)(val,tvals,idxs,deriv) = ode_interpolation!(val,tvals,interp,idxs,deriv)
(interp::CompositeInterpolationData)(val,tvals,idxs,deriv) = ode_interpolation!(val,tvals,interp,idxs,deriv)

function InterpolationData(id::InterpolationData,f)
  InterpolationData(f,id.timeseries,
                      id.ts,
                      id.ks,
                      id.notsaveat_idxs,
                      id.dense,
                      id.cache)
end

function CompositeInterpolationData(id::CompositeInterpolationData,f)
  CompositeInterpolationData(f,id.timeseries,
                               id.ts,
                               id.ks,
                               id.alg_choice,
                               id.notsaveat_idxs,
                               id.dense,
                               id.cache)
end
