@inline function initialize!(integrator,cache::SymplecticEulerCache,f=integrator.f)
  integrator.kshortsize = 2
  @unpack k,fsalfirst = cache
  integrator.fsalfirst = fsalfirst
  integrator.fsallast = k
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  # Do the calculation pre
  # So that way FSAL interpolation
  uprev,duprev = integrator.uprev.x
  u,du = integrator.u.x
  ku = integrator.k[1].x[1]
  kdu = integrator.k[2].x[2]
  f[2](integrator.t,uprev,duprev,kdu)
  dt = integrator.dt
  #du = muladd.(integrator.dt,kdu,duprev)
  duidx = eachindex(du)
  @tight_loop_macros for i in duidx
    @inbounds du[i] = muladd(dt,kdu[i],duprev[i])
  end
  f[1](integrator.t,uprev,du,ku)
end

@inline function perform_step!(integrator,cache::SymplecticEulerCache,f=integrator.f)
  @unpack t,dt = integrator
  uprev,duprev = integrator.uprev.x
  u,du = integrator.u.x
  duidx = eachindex(du)
  uidx = eachindex(u)
  kuprev = integrator.k[1].x[1]
  ku  = integrator.k[2].x[1]
  kdu = integrator.k[2].x[2]
  #u .= muladd.(dt,kuprev,uprev)
  @tight_loop_macros for i in uidx
    @inbounds u[i] = muladd(dt,kuprev[i],uprev[i])
  end
  # Now actually compute the step
  # Do it at the end for interpolations!
  f[2](integrator.t,uprev,duprev,kdu)
  #du .= muladd.(dt,kdu,duprev)
  @tight_loop_macros for i in duidx
    @inbounds du[i] = muladd(dt,kdu[i],duprev[i])
  end
  f[1](integrator.t,uprev,du,ku)
end

@inline function initialize!(integrator,cache::VelocityVerletCache,f=integrator.f)
  integrator.kshortsize = 2
  @unpack k,fsalfirst = cache
  integrator.fsalfirst = fsalfirst
  integrator.fsallast = k
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  uprev,duprev = integrator.uprev.x
  f[2](integrator.t,uprev,duprev,integrator.k[1].x[2])
end

@inline function perform_step!(integrator,cache::VelocityVerletCache,f=integrator.f)
  @unpack t,dt = integrator
  uprev,duprev = integrator.uprev.x
  u,du = integrator.u.x
  ku, kdu = integrator.k[1].x[1], integrator.k[1].x[2]
  # x(t+Δt) = x(t) + v(t)*Δt + 1/2*a(t)*Δt^2
  f[2](integrator.t,uprev,duprev,ku)
  @tight_loop_macros for i in eachindex(u)
    @inbounds u[i] = @muladd uprev[i]+duprev[i]*dt+(1//2*ku[i])*dt^2
  end
  f[2](integrator.t,u,duprev,kdu)
  # v(t+Δt) = v(t) + 1/2*(a(t)+a(t+Δt))*Δt
  @tight_loop_macros for i in eachindex(du)
    @inbounds du[i] = @muladd duprev[i] + dt*(1//2*ku[i] + 1//2*kdu[i])
  end
  copy!(integrator.k[2].x[1],du)
  copy!(integrator.k[2].x[2],kdu)
end

@inline function initialize!(integrator,cache::Ruth3Cache,f=integrator.f)
  integrator.kshortsize = 2
  @unpack k,fsalfirst = cache
  integrator.fsalfirst = fsalfirst
  integrator.fsallast = k
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  uprev,duprev = integrator.uprev.x
  f[1](integrator.t,uprev,duprev,integrator.k[1].x[1])
  f[2](integrator.t,uprev,duprev,integrator.k[1].x[2])
end

@inline function perform_step!(integrator,cache::Ruth3Cache,f=integrator.f)
  @unpack t,dt = integrator
  uprev,duprev = integrator.uprev.x
  u,du = integrator.u.x
  ku, kdu = integrator.k[2].x[1], integrator.k[2].x[2]
  # update velocity & position
  f[2](integrator.t,uprev,duprev,kdu)
  @tight_loop_macros for i in eachindex(du)
    @inbounds du[i] = @muladd duprev[i] + (7//24)*dt*kdu[i]
  end
  f[1](integrator.t,uprev,du,ku)
  @tight_loop_macros for i in eachindex(u)
    @inbounds u[i] = @muladd uprev[i] + (2//3)*dt*ku[i]
  end

  # update velocity & position
  f[2](integrator.t+2//3,u,du,kdu)
  @tight_loop_macros for i in eachindex(du)
    @inbounds du[i] += (3//4)*dt*kdu[i]
  end
  f[1](integrator.t,u,du,ku)
  @tight_loop_macros for i in eachindex(u)
    @inbounds u[i] -= 2//3*dt*ku[i]
  end

  # update velocity & position
  f[2](integrator.t,u,du,kdu)
  @tight_loop_macros for i in eachindex(du)
    @inbounds du[i] -= (1//24)*dt*kdu[i]
  end
  f[1](integrator.t,u,du,ku)
  @tight_loop_macros for i in eachindex(u)
    @inbounds u[i] += dt*ku[i]
  end
end
