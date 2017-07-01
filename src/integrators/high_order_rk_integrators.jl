@inline function initialize!(integrator,cache::TanYam7ConstantCache,f=integrator.f)
  integrator.fsalfirst = f(integrator.t,integrator.uprev) # Pre-start fsal
  integrator.kshortsize = 2
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
end

#=
@inline function perform_step!(integrator,cache::TanYam7ConstantCache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  @unpack c1,c2,c3,c4,c5,c6,c7,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a93,a94,a95,a96,a97,a98,a101,a103,a104,a105,a106,a107,a108,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat8,bhat10 = cache
  k1 = integrator.fsalfirst
  a = dt*a21
  k2 = f(@muladd(t + c1*dt),@.(@muladd(uprev+a*k1)))
  k3 = f(@muladd(t + c2*dt),@.(@muladd(uprev+dt*(a31*k1+a32*k2))))
  k4 = f(@muladd(t + c3*dt),@.(@muladd(uprev+dt*(a41*k1       +a43*k3))))
  k5 = f(@muladd(t + c4*dt),@.(@muladd(uprev+dt*(a51*k1       +a53*k3+a54*k4))))
  k6 = f(@muladd(t + c5*dt),@.(@muladd(uprev+dt*(a61*k1       +a63*k3+a64*k4+a65*k5))))
  k7 = f(@muladd(t + c6*dt),@.(@muladd(uprev+dt*(a71*k1       +a73*k3+a74*k4+a75*k5+a76*k6))))
  k8 = f(@muladd(t + c7*dt),@.(@muladd(uprev+dt*(a81*k1       +a83*k3+a84*k4+a85*k5+a86*k6+a87*k7))))
  k9 = f(t+dt,@.(@muladd(uprev+dt*(a91*k1       +a93*k3+a94*k4+a95*k5+a96*k6+a97*k7+a98*k8))))
  k10= f(t+dt,@.(@muladd(uprev+dt*(a101*k1      +a103*k3+a104*k4+a105*k5+a106*k6+a107*k7+a108*k8))))
  u = @. @muladd uprev + dt*(k1*b1+k4*b4+k5*b5+k6*b6+k7*b7+k8*b8+k9*b9)
  if integrator.opts.adaptive
    utilde = @. @muladd uprev + dt*(k1*bhat1+k4*bhat4+k5*bhat5+k6*bhat6+k7*bhat7+k8*bhat8+k10*bhat10)
    tmp = @. ((utilde-u)./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol))
    integrator.EEst = integrator.opts.internalnorm(tmp)
  end
  k = f(t+dt,u) # For the interpolation, needs k at the updated point
  integrator.fsallast = k
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  @pack integrator = t,dt,u
end
=#

@inline function perform_step!(integrator,cache::TanYam7ConstantCache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  @unpack c1,c2,c3,c4,c5,c6,c7,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a93,a94,a95,a96,a97,a98,a101,a103,a104,a105,a106,a107,a108,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat8,bhat10 = cache
  k1 = integrator.fsalfirst
  a = dt*a21
  k2 = f(@muladd(t + c1*dt),@muladd(uprev+a*k1))
  k3 = f(@muladd(t + c2*dt),@muladd(uprev+dt*(a31*k1+a32*k2)))
  k4 = f(@muladd(t + c3*dt),@muladd(uprev+dt*(a41*k1       +a43*k3)))
  k5 = f(@muladd(t + c4*dt),@muladd(uprev+dt*(a51*k1       +a53*k3+a54*k4)))
  k6 = f(@muladd(t + c5*dt),@muladd(uprev+dt*(a61*k1       +a63*k3+a64*k4+a65*k5)))
  k7 = f(@muladd(t + c6*dt),@muladd(uprev+dt*(a71*k1       +a73*k3+a74*k4+a75*k5+a76*k6)))
  k8 = f(@muladd(t + c7*dt),@muladd(uprev+dt*(a81*k1       +a83*k3+a84*k4+a85*k5+a86*k6+a87*k7)))
  k9 = f(t+dt,@muladd(uprev+dt*(a91*k1       +a93*k3+a94*k4+a95*k5+a96*k6+a97*k7+a98*k8)))
  k10= f(t+dt,@muladd(uprev+dt*(a101*k1      +a103*k3+a104*k4+a105*k5+a106*k6+a107*k7+a108*k8)))
  u = @muladd uprev + dt*(k1*b1+k4*b4+k5*b5+k6*b6+k7*b7+k8*b8+k9*b9)
  if integrator.opts.adaptive
    utilde = @muladd uprev + dt*(k1*bhat1+k4*bhat4+k5*bhat5+k6*bhat6+k7*bhat7+k8*bhat8+k10*bhat10)
    integrator.EEst = integrator.opts.internalnorm( ((utilde-u)./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol)))
  end
  k = f(t+dt,u) # For the interpolation, needs k at the updated point
  integrator.fsallast = k
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  @pack integrator = t,dt,u
end

@inline function initialize!(integrator,cache::TanYam7Cache,f=integrator.f)
  integrator.fsalfirst = cache.fsalfirst
  integrator.fsallast = cache.k
  integrator.kshortsize = 2
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  f(integrator.t,integrator.uprev,integrator.fsalfirst) # Pre-start fsal
end

#=
@inline function perform_step!(integrator,cache::TanYam7Cache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  uidx = eachindex(integrator.uprev)
  @unpack fsalfirst,k2,k3,k4,k5,k6,k7,k8,k9,k10,utilde,tmp,atmp,k = cache
  @unpack c1,c2,c3,c4,c5,c6,c7,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a93,a94,a95,a96,a97,a98,a101,a103,a104,a105,a106,a107,a108,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat8,bhat10 = cache.tab
  k1 = fsalfirst
  f(t,uprev,k1)
  a = dt*a21
  @. tmp = @muladd uprev+a*k1
  f(@muladd(t + c1*dt),tmp,k2)
  @. tmp = @muladd uprev+dt*(a31*k1+a32*k2)
  f(@muladd(t + c2*dt),tmp,k3)
  @. tmp = @muladd uprev+dt*(a41*k1+a43*k3)
  f(@muladd(t + c3*dt),tmp,k4)
  @. tmp = @muladd uprev+dt*(a51*k1+a53*k3+a54*k4)
  f(@muladd(t + c4*dt),tmp,k5)
  @. tmp = @muladd uprev+dt*(a61*k1+a63*k3+a64*k4+a65*k5)
  f(@muladd(t + c5*dt),tmp,k6)
  @. tmp = @muladd uprev+dt*(a71*k1+a73*k3+a74*k4+a75*k5+a76*k6)
  f(@muladd(t + c6*dt),tmp,k7)
  @. tmp = @muladd uprev+dt*(a81*k1+a83*k3+a84*k4+a85*k5+a86*k6+a87*k7)
  f(@muladd(t + c7*dt),tmp,k8)
  @. tmp = @muladd uprev+dt*(a91*k1+a93*k3+a94*k4+a95*k5+a96*k6+a97*k7+a98*k8)
  f(t+dt,tmp,k9)
  @. tmp = @muladd uprev+dt*(a101*k1+a103*k3+a104*k4+a105*k5+a106*k6+a107*k7+a108*k8)
  f(t+dt,tmp,k10)
  @. u = uprev + dt*(k1*b1+k4*b4+k5*b5+k6*b6+k7*b7+k8*b8+k9*b9)
  if integrator.opts.adaptive
    @. utilde = uprev + dt*(k1*bhat1+k4*bhat4+k5*bhat5+k6*bhat6+k7*bhat7+k8*bhat8+k10*bhat10)
    @. atmp = ((utilde-u)./(integrator.opts.abstol+max(abs(uprev),abs(u)).*integrator.opts.reltol))
    integrator.EEst = integrator.opts.internalnorm(atmp)
  end
  f(t+dt,u,k)
  @pack integrator = t,dt,u
end
=#

@inline function perform_step!(integrator,cache::TanYam7Cache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  uidx = eachindex(integrator.uprev)
  @unpack fsalfirst,k2,k3,k4,k5,k6,k7,k8,k9,k10,utilde,tmp,atmp,k = cache
  @unpack c1,c2,c3,c4,c5,c6,c7,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a93,a94,a95,a96,a97,a98,a101,a103,a104,a105,a106,a107,a108,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat8,bhat10 = cache.tab
  k1 = fsalfirst
  f(t,uprev,k1)
  a = dt*a21
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+a*k1[i]
  end
  f(@muladd(t + c1*dt),tmp,k2)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a31*k1[i]+a32*k2[i])
  end
  f(@muladd(t + c2*dt),tmp,k3)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a41*k1[i]+a43*k3[i])
  end
  f(@muladd(t + c3*dt),tmp,k4)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a51*k1[i]+a53*k3[i]+a54*k4[i])
  end
  f(@muladd(t + c4*dt),tmp,k5)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a61*k1[i]+a63*k3[i]+a64*k4[i]+a65*k5[i])
  end
  f(@muladd(t + c5*dt),tmp,k6)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a71*k1[i]+a73*k3[i]+a74*k4[i]+a75*k5[i]+a76*k6[i])
  end
  f(@muladd(t + c6*dt),tmp,k7)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a81*k1[i]+a83*k3[i]+a84*k4[i]+a85*k5[i]+a86*k6[i]+a87*k7[i])
  end
  f(@muladd(t + c7*dt),tmp,k8)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a91*k1[i]+a93*k3[i]+a94*k4[i]+a95*k5[i]+a96*k6[i]+a97*k7[i]+a98*k8[i])
  end
  f(t+dt,tmp,k9)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a101*k1[i]+a103*k3[i]+a104*k4[i]+a105*k5[i]+a106*k6[i]+a107*k7[i]+a108*k8[i])
  end
  f(t+dt,tmp,k10)
  @tight_loop_macros for i in uidx
    u[i] = uprev[i] + dt*(k1[i]*b1+k4[i]*b4+k5[i]*b5+k6[i]*b6+k7[i]*b7+k8[i]*b8+k9[i]*b9)
  end
  if integrator.opts.adaptive
    @tight_loop_macros for (i,atol,rtol) in zip(uidx,Iterators.cycle(integrator.opts.abstol),Iterators.cycle(integrator.opts.reltol))
      @inbounds utilde[i] = uprev[i] + dt*(k1[i]*bhat1+k4[i]*bhat4+k5[i]*bhat5+k6[i]*bhat6+k7[i]*bhat7+k8[i]*bhat8+k10[i]*bhat10)
      @inbounds atmp[i] = ((utilde[i]-u[i])./(atol+max(abs(uprev[i]),abs(u[i])).*rtol))
    end
    integrator.EEst = integrator.opts.internalnorm(atmp)
  end
  f(t+dt,u,k)
  @pack integrator = t,dt,u
end

@inline function initialize!(integrator,cache::DP8ConstantCache,f=integrator.f)
  integrator.kshortsize = 7
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
  integrator.fsalfirst = f(integrator.t,integrator.uprev) # Pre-start fsal
end

#=
@inline function perform_step!(integrator,cache::DP8ConstantCache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  @unpack c7,c8,c9,c10,c11,c6,c5,c4,c3,c2,b1,b6,b7,b8,b9,b10,b11,b12,bhh1,bhh2,bhh3,er1,er6,er7,er8,er9,er10,er11,er12,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache
  k1 = integrator.fsalfirst
  a = dt*a0201
  k2 = f(@muladd(t + c2*dt),@.(@muladd(uprev+a*k1)))
  k3 = f(@muladd(t + c3*dt),@.(@muladd(uprev+dt*(a0301*k1+a0302*k2))))
  k4 = f(@muladd(t + c4*dt),@.(@muladd(uprev+dt*(a0401*k1       +a0403*k3))))
  k5 = f(@muladd(t + c5*dt),@.(@muladd(uprev+dt*(a0501*k1       +a0503*k3+a0504*k4))))
  k6 = f(@muladd(t + c6*dt),@.(@muladd(uprev+dt*(a0601*k1                +a0604*k4+a0605*k5))))
  k7 = f(@muladd(t + c7*dt),@.(@muladd(uprev+dt*(a0701*k1                +a0704*k4+a0705*k5+a0706*k6))))
  k8 = f(@muladd(t + c8*dt),@.(@muladd(uprev+dt*(a0801*k1                +a0804*k4+a0805*k5+a0806*k6+a0807*k7))))
  k9 = f(@muladd(t + c9*dt),@.(@muladd(uprev+dt*(a0901*k1                +a0904*k4+a0905*k5+a0906*k6+a0907*k7+a0908*k8))))
  k10 =f(@muladd(t + c10*dt),@.(@muladd(uprev+dt*(a1001*k1                +a1004*k4+a1005*k5+a1006*k6+a1007*k7+a1008*k8+a1009*k9))))
  k11= f(@muladd(t + c11*dt),@.(@muladd(uprev+dt*(a1101*k1                +a1104*k4+a1105*k5+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10))))
  k12= f(t+dt,@.(@muladd(uprev+dt*(a1201*k1                +a1204*k4+a1205*k5+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11))))
  kupdate= @. @muladd b1*k1+b6*k6+b7*k7+b8*k8+b9*k9+b10*k10+b11*k11+b12*k12
  update = dt*kupdate
  u = uprev + update
  if integrator.opts.adaptive
    tmp = @. dt*(@muladd(k1*er1 + k6*er6 + k7*er7 + k8*er8 + k9*er9 + k10*er10 + k11*er11 + k12*er12))./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol)
    err5 = integrator.opts.internalnorm(tmp) # Order 5
    tmp = @. @muladd(update - dt*(bhh1*k1 + bhh2*k9 + bhh3*k12))./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol)
    err3 = integrator.opts.internalnorm(tmp) # Order 3
    err52 = err5*err5
    if err5 ≈ 0 && err3 ≈ 0
      integrator.EEst = zero(typeof(integrator.EEst))
    else
      integrator.EEst = err52./sqrt(err52 + 0.01*err3*err3)
    end
  end
  k13 = f(t+dt,u)
  integrator.fsallast = k13
  if integrator.opts.calck
    @unpack c14,c15,c16,a1401,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1613,a1614,a1615 = cache
    @unpack d401,d406,d407,d408,d409,d410,d411,d412,d413,d414,d415,d416,d501,d506,d507,d508,d509,d510,d511,d512,d513,d514,d515,d516,d601,d606,d607,d608,d609,d610,d611,d612,d613,d614,d615,d616,d701,d706,d707,d708,d709,d710,d711,d712,d713,d714,d715,d716 = cache
    k14 = f(@muladd(t + c14*dt),@.(@muladd(uprev+dt*(a1401*k1         +a1407*k7+a1408*k8+a1409*k9+a1410*k10+a1411*k11+a1412*k12+a1413*k13))))
    k15 = f(@muladd(t + c15*dt),@.(@muladd(uprev+dt*(a1501*k1+a1506*k6+a1507*k7+a1508*k8                   +a1511*k11+a1512*k12+a1513*k13+a1514*k14))))
    k16 = f(@muladd(t + c16*dt),@.(@muladd(uprev+dt*(a1601*k1+a1606*k6+a1607*k7+a1608*k8+a1609*k9                              +a1613*k13+a1614*k14+a1615*k15))))
    udiff = kupdate
    integrator.k[1] = udiff
    bspl = k1 - udiff
    integrator.k[2] = bspl
    integrator.k[3] = @. udiff - k13 - bspl
    integrator.k[4] = @.(@muladd(d401*k1+d406*k6+d407*k7+d408*k8+d409*k9+d410*k10+d411*k11+d412*k12+d413*k13+d414*k14+d415*k15+d416*k16))
    integrator.k[5] = @.(@muladd(d501*k1+d506*k6+d507*k7+d508*k8+d509*k9+d510*k10+d511*k11+d512*k12+d513*k13+d514*k14+d515*k15+d516*k16))
    integrator.k[6] = @.(@muladd(d601*k1+d606*k6+d607*k7+d608*k8+d609*k9+d610*k10+d611*k11+d612*k12+d613*k13+d614*k14+d615*k15+d616*k16))
    integrator.k[7] = @.(@muladd(d701*k1+d706*k6+d707*k7+d708*k8+d709*k9+d710*k10+d711*k11+d712*k12+d713*k13+d714*k14+d715*k15+d716*k16))
  end
  @pack integrator = t,dt,u,k
end
=#

@inline function perform_step!(integrator,cache::DP8ConstantCache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  @unpack c7,c8,c9,c10,c11,c6,c5,c4,c3,c2,b1,b6,b7,b8,b9,b10,b11,b12,bhh1,bhh2,bhh3,er1,er6,er7,er8,er9,er10,er11,er12,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache
  k1 = integrator.fsalfirst
  a = dt*a0201
  k2 = f(@muladd(t + c2*dt),uprev+a*k1)
  k3 = f(@muladd(t + c3*dt),@muladd(uprev+dt*(a0301*k1+a0302*k2)))
  k4 = f(@muladd(t + c4*dt),@muladd(uprev+dt*(a0401*k1       +a0403*k3)))
  k5 = f(@muladd(t + c5*dt),@muladd(uprev+dt*(a0501*k1       +a0503*k3+a0504*k4)))
  k6 = f(@muladd(t + c6*dt),@muladd(uprev+dt*(a0601*k1                +a0604*k4+a0605*k5)))
  k7 = f(@muladd(t + c7*dt),@muladd(uprev+dt*(a0701*k1                +a0704*k4+a0705*k5+a0706*k6)))
  k8 = f(@muladd(t + c8*dt),@muladd(uprev+dt*(a0801*k1                +a0804*k4+a0805*k5+a0806*k6+a0807*k7)))
  k9 = f(@muladd(t + c9*dt),@muladd(uprev+dt*(a0901*k1                +a0904*k4+a0905*k5+a0906*k6+a0907*k7+a0908*k8)))
  k10 =f(@muladd(t + c10*dt),@muladd(uprev+dt*(a1001*k1                +a1004*k4+a1005*k5+a1006*k6+a1007*k7+a1008*k8+a1009*k9)))
  k11= f(@muladd(t + c11*dt),@muladd(uprev+dt*(a1101*k1                +a1104*k4+a1105*k5+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10)))
  k12= f(t+dt,@muladd(uprev+dt*(a1201*k1                +a1204*k4+a1205*k5+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11)))
  kupdate= @muladd b1*k1+b6*k6+b7*k7+b8*k8+b9*k9+b10*k10+b11*k11+b12*k12
  update = dt*kupdate
  u = uprev + update
  if integrator.opts.adaptive
    err5 = integrator.opts.internalnorm(dt*(@muladd(k1*er1 + k6*er6 + k7*er7 + k8*er8 + k9*er9 + k10*er10 + k11*er11 + k12*er12))./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol)) # Order 5
    err3 = integrator.opts.internalnorm(@muladd(update - dt*(bhh1*k1 + bhh2*k9 + bhh3*k12))./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol)) # Order 3
    err52 = err5*err5
    if err5 ≈ 0 && err3 ≈ 0
      integrator.EEst = zero(typeof(integrator.EEst))
    else
      integrator.EEst = err52./sqrt(err52 + 0.01*err3*err3)
    end
  end
  k13 = f(t+dt,u)
  integrator.fsallast = k13
  if integrator.opts.calck
    @unpack c14,c15,c16,a1401,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1613,a1614,a1615 = cache
    @unpack d401,d406,d407,d408,d409,d410,d411,d412,d413,d414,d415,d416,d501,d506,d507,d508,d509,d510,d511,d512,d513,d514,d515,d516,d601,d606,d607,d608,d609,d610,d611,d612,d613,d614,d615,d616,d701,d706,d707,d708,d709,d710,d711,d712,d713,d714,d715,d716 = cache
    k14 = f(@muladd(t + c14*dt),@muladd(uprev+dt*(a1401*k1         +a1407*k7+a1408*k8+a1409*k9+a1410*k10+a1411*k11+a1412*k12+a1413*k13)))
    k15 = f(@muladd(t + c15*dt),@muladd(uprev+dt*(a1501*k1+a1506*k6+a1507*k7+a1508*k8                   +a1511*k11+a1512*k12+a1513*k13+a1514*k14)))
    k16 = f(@muladd(t + c16*dt),@muladd(uprev+dt*(a1601*k1+a1606*k6+a1607*k7+a1608*k8+a1609*k9                              +a1613*k13+a1614*k14+a1615*k15)))
    udiff = kupdate
    integrator.k[1] = udiff
    bspl = k1 - udiff
    integrator.k[2] = bspl
    integrator.k[3] = udiff - k13 - bspl
    integrator.k[4] = @muladd(d401*k1+d406*k6+d407*k7+d408*k8+d409*k9+d410*k10+d411*k11+d412*k12+d413*k13+d414*k14+d415*k15+d416*k16)
    integrator.k[5] = @muladd(d501*k1+d506*k6+d507*k7+d508*k8+d509*k9+d510*k10+d511*k11+d512*k12+d513*k13+d514*k14+d515*k15+d516*k16)
    integrator.k[6] = @muladd(d601*k1+d606*k6+d607*k7+d608*k8+d609*k9+d610*k10+d611*k11+d612*k12+d613*k13+d614*k14+d615*k15+d616*k16)
    integrator.k[7] = @muladd(d701*k1+d706*k6+d707*k7+d708*k8+d709*k9+d710*k10+d711*k11+d712*k12+d713*k13+d714*k14+d715*k15+d716*k16)
  end
  @pack integrator = t,dt,u,k
end

@inline function initialize!(integrator,cache::DP8Cache,f=integrator.f)
  integrator.kshortsize = 7
  integrator.k = [cache.udiff,cache.bspl,cache.dense_tmp3,cache.dense_tmp4,cache.dense_tmp5,cache.dense_tmp6,cache.dense_tmp7]
  integrator.fsalfirst = cache.k1
  integrator.fsallast = cache.k13
  f(integrator.t,integrator.uprev,integrator.fsalfirst) # Pre-start fsal
end

#=
@inline function perform_step!(integrator,cache::DP8Cache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  uidx = eachindex(integrator.uprev)
  @unpack c7,c8,c9,c10,c11,c6,c5,c4,c3,c2,b1,b6,b7,b8,b9,b10,b11,b12,bhh1,bhh2,bhh3,er1,er6,er7,er8,er9,er10,er11,er12,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache.tab
  @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,update,udiff,bspl,dense_tmp3,dense_tmp4,dense_tmp5,dense_tmp6,dense_tmp7,kupdate,utilde,tmp,atmp,atmp2 = cache
  f(t,uprev,k1)
  a = dt*a0201
  @. tmp = @muladd uprev+a*k1
  f(@muladd(t + c2*dt),tmp,k2)
  @. tmp = @muladd uprev+dt*(a0301*k1+a0302*k2)
  f(@muladd(t + c3*dt),tmp,k3)
  @. tmp = @muladd uprev+dt*(a0401*k1+a0403*k3)
  f(@muladd(t + c4*dt),tmp,k4)
  @. tmp = @muladd uprev+dt*(a0501*k1+a0503*k3+a0504*k4)
  f(@muladd(t + c5*dt),tmp,k5)
  @. tmp = @muladd uprev+dt*(a0601*k1+a0604*k4+a0605*k5)
  f(@muladd(t + c6*dt),tmp,k6)
  @. tmp = @muladd uprev+dt*(a0701*k1+a0704*k4+a0705*k5+a0706*k6)
  f(@muladd(t + c7*dt),tmp,k7)
  @. tmp = @muladd uprev+dt*(a0801*k1+a0804*k4+a0805*k5+a0806*k6+a0807*k7)
  f(@muladd(t + c8*dt),tmp,k8)
  @. tmp = @muladd uprev+dt*(a0901*k1+a0904*k4+a0905*k5+a0906*k6+a0907*k7+a0908*k8)
  f(@muladd(t + c9*dt),tmp,k9)
  @. tmp = @muladd uprev+dt*(a1001*k1+a1004*k4+a1005*k5+a1006*k6+a1007*k7+a1008*k8+a1009*k9)
  f(@muladd(t + c10*dt),tmp,k10)
  @. tmp = @muladd uprev+dt*(a1101*k1+a1104*k4+a1105*k5+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10)
  f(@muladd(t + c11*dt),tmp,k11)
  @. tmp = @muladd uprev+dt*(a1201*k1+a1204*k4+a1205*k5+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11)
  f(t+dt,tmp,k12)
  @. kupdate = @muladd b1*k1+b6*k6+b7*k7+b8*k8+b9*k9+b10*k10+b11*k11+b12*k12
  @. update = dt*kupdate
  @. u = uprev + update
  if integrator.opts.adaptive
    @. atmp = (dt*(@muladd(k1*er1 + k6*er6 + k7*er7 + k8*er8 + k9*er9 + k10*er10 + k11*er11 + k12*er12))./@muladd(integrator.opts.abstol+max(abs(uprev),abs(u)).*integrator.opts.reltol))
    @. atmp2= (@muladd(update - dt*(bhh1*k1 + bhh2*k9 + bhh3*k12))./@muladd(integrator.opts.abstol+max(abs(uprev),abs(u)).*integrator.opts.reltol))
    err5 = integrator.opts.internalnorm(atmp) # Order 5
    err3 = integrator.opts.internalnorm(atmp2) # Order 3
    err52 = err5*err5
    if err5 ≈ 0 && err3 ≈ 0
      integrator.EEst = zero(typeof(integrator.EEst))
    else
      integrator.EEst = err52./sqrt(err52 + 0.01*err3*err3)
    end
  end
  f(t+dt,u,k13)
  if integrator.opts.calck
    @unpack c14,c15,c16,a1401,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1613,a1614,a1615 = cache.tab
    @unpack d401,d406,d407,d408,d409,d410,d411,d412,d413,d414,d415,d416,d501,d506,d507,d508,d509,d510,d511,d512,d513,d514,d515,d516,d601,d606,d607,d608,d609,d610,d611,d612,d613,d614,d615,d616,d701,d706,d707,d708,d709,d710,d711,d712,d713,d714,d715,d716 = cache.tab
    @. tmp = @muladd uprev+dt*(a1401*k1+a1407*k7+a1408*k8+a1409*k9+a1410*k10+a1411*k11+a1412*k12+a1413*k13)
    f(@muladd(t + c14*dt),tmp,k14)
    @. tmp = @muladd uprev+dt*(a1501*k1+a1506*k6+a1507*k7+a1508*k8+a1511*k11+a1512*k12+a1513*k13+a1514*k14)
    f(@muladd(t + c15*dt),tmp,k15)
    @. tmp = @muladd uprev+dt*(a1601*k1+a1606*k6+a1607*k7+a1608*k8+a1609*k9+a1613*k13+a1614*k14+a1615*k15)
    f(@muladd(t + c16*dt),tmp,k16)
    @. udiff = kupdate
    @. bspl = k1 - udiff
    @. integrator.k[3] = udiff - k13 - bspl
    @. integrator.k[4] = @muladd(d401*k1+d406*k6+d407*k7+d408*k8+d409*k9+d410*k10+d411*k11+d412*k12+d413*k13+d414*k14+d415*k15+d416*k16)
    @. integrator.k[5] = @muladd(d501*k1+d506*k6+d507*k7+d508*k8+d509*k9+d510*k10+d511*k11+d512*k12+d513*k13+d514*k14+d515*k15+d516*k16)
    @. integrator.k[6] = @muladd(d601*k1+d606*k6+d607*k7+d608*k8+d609*k9+d610*k10+d611*k11+d612*k12+d613*k13+d614*k14+d615*k15+d616*k16)
    @. integrator.k[7] = @muladd(d701*k1+d706*k6+d707*k7+d708*k8+d709*k9+d710*k10+d711*k11+d712*k12+d713*k13+d714*k14+d715*k15+d716*k16)
  end
  @pack integrator = t,dt,u,k
end
=#

@inline function perform_step!(integrator,cache::DP8Cache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  uidx = eachindex(integrator.uprev)
  @unpack c7,c8,c9,c10,c11,c6,c5,c4,c3,c2,b1,b6,b7,b8,b9,b10,b11,b12,bhh1,bhh2,bhh3,er1,er6,er7,er8,er9,er10,er11,er12,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache.tab
  @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,update,udiff,bspl,dense_tmp3,dense_tmp4,dense_tmp5,dense_tmp6,dense_tmp7,kupdate,utilde,tmp,atmp,atmp2 = cache
  f(t,uprev,k1)
  a = dt*a0201
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+a*k1[i]
  end
  f(@muladd(t + c2*dt),tmp,k2)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0301*k1[i]+a0302*k2[i])
  end
  f(@muladd(t + c3*dt),tmp,k3)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0401*k1[i]+a0403*k3[i])
  end
  f(@muladd(t + c4*dt),tmp,k4)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0501*k1[i]+a0503*k3[i]+a0504*k4[i])
  end
  f(@muladd(t + c5*dt),tmp,k5)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0601*k1[i]+a0604*k4[i]+a0605*k5[i])
  end
  f(@muladd(t + c6*dt),tmp,k6)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0701*k1[i]+a0704*k4[i]+a0705*k5[i]+a0706*k6[i])
  end
  f(@muladd(t + c7*dt),tmp,k7)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0801*k1[i]+a0804*k4[i]+a0805*k5[i]+a0806*k6[i]+a0807*k7[i])
  end
  f(@muladd(t + c8*dt),tmp,k8)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0901*k1[i]+a0904*k4[i]+a0905*k5[i]+a0906*k6[i]+a0907*k7[i]+a0908*k8[i])
  end
  f(@muladd(t + c9*dt),tmp,k9)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a1001*k1[i]+a1004*k4[i]+a1005*k5[i]+a1006*k6[i]+a1007*k7[i]+a1008*k8[i]+a1009*k9[i])
  end
  f(@muladd(t + c10*dt),tmp,k10)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a1101*k1[i]+a1104*k4[i]+a1105*k5[i]+a1106*k6[i]+a1107*k7[i]+a1108*k8[i]+a1109*k9[i]+a1110*k10[i])
  end
  f(@muladd(t + c11*dt),tmp,k11)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a1201*k1[i]+a1204*k4[i]+a1205*k5[i]+a1206*k6[i]+a1207*k7[i]+a1208*k8[i]+a1209*k9[i]+a1210*k10[i]+a1211*k11[i])
  end
  f(t+dt,tmp,k12)
  @tight_loop_macros for i in uidx
    @inbounds kupdate[i] = @muladd b1*k1[i]+b6*k6[i]+b7*k7[i]+b8*k8[i]+b9*k9[i]+b10*k10[i]+b11*k11[i]+b12*k12[i]
    @inbounds update[i] = dt*kupdate[i]
    @inbounds u[i] = uprev[i] + update[i]
  end
  if integrator.opts.adaptive
    @tight_loop_macros for (i,atol,rtol) in zip(uidx,Iterators.cycle(integrator.opts.abstol),Iterators.cycle(integrator.opts.reltol))
      @inbounds atmp[i] = (dt*(@muladd(k1[i]*er1 + k6[i]*er6 + k7[i]*er7 + k8[i]*er8 + k9[i]*er9 + k10[i]*er10 + k11[i]*er11 + k12[i]*er12))./@muladd(atol+max(abs(uprev[i]),abs(u[i])).*rtol))
      @inbounds atmp2[i]= (@muladd(update[i] - dt*(bhh1*k1[i] + bhh2*k9[i] + bhh3*k12[i]))./@muladd(atol+max(abs(uprev[i]),abs(u[i])).*rtol))
    end
    err5 = integrator.opts.internalnorm(atmp) # Order 5
    err3 = integrator.opts.internalnorm(atmp2) # Order 3
    err52 = err5*err5
    if err5 ≈ 0 && err3 ≈ 0
      integrator.EEst = zero(typeof(integrator.EEst))
    else
      integrator.EEst = err52./sqrt(err52 + 0.01*err3*err3)
    end
  end
  f(t+dt,u,k13)
  if integrator.opts.calck
    @unpack c14,c15,c16,a1401,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1613,a1614,a1615 = cache.tab
    @unpack d401,d406,d407,d408,d409,d410,d411,d412,d413,d414,d415,d416,d501,d506,d507,d508,d509,d510,d511,d512,d513,d514,d515,d516,d601,d606,d607,d608,d609,d610,d611,d612,d613,d614,d615,d616,d701,d706,d707,d708,d709,d710,d711,d712,d713,d714,d715,d716 = cache.tab
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = @muladd uprev[i]+dt*(a1401*k1[i]+a1407*k7[i]+a1408*k8[i]+a1409*k9[i]+a1410*k10[i]+a1411*k11[i]+a1412*k12[i]+a1413*k13[i])
    end
    f(@muladd(t + c14*dt),tmp,k14)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = @muladd uprev[i]+dt*(a1501*k1[i]+a1506*k6[i]+a1507*k7[i]+a1508*k8[i]+a1511*k11[i]+a1512*k12[i]+a1513*k13[i]+a1514*k14[i])
    end
    f(@muladd(t + c15*dt),tmp,k15)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = @muladd uprev[i]+dt*(a1601*k1[i]+a1606*k6[i]+a1607*k7[i]+a1608*k8[i]+a1609*k9[i]+a1613*k13[i]+a1614*k14[i]+a1615*k15[i])
    end
    f(@muladd(t + c16*dt),tmp,k16)
    @tight_loop_macros for i in uidx
      @inbounds udiff[i]= kupdate[i]
      @inbounds bspl[i] = k1[i] - udiff[i]
      @inbounds integrator.k[3][i] = udiff[i] - k13[i] - bspl[i]
      @inbounds integrator.k[4][i] = @muladd(d401*k1[i]+d406*k6[i]+d407*k7[i]+d408*k8[i]+d409*k9[i]+d410*k10[i]+d411*k11[i]+d412*k12[i]+d413*k13[i]+d414*k14[i]+d415*k15[i]+d416*k16[i])
      @inbounds integrator.k[5][i] = @muladd(d501*k1[i]+d506*k6[i]+d507*k7[i]+d508*k8[i]+d509*k9[i]+d510*k10[i]+d511*k11[i]+d512*k12[i]+d513*k13[i]+d514*k14[i]+d515*k15[i]+d516*k16[i])
      @inbounds integrator.k[6][i] = @muladd(d601*k1[i]+d606*k6[i]+d607*k7[i]+d608*k8[i]+d609*k9[i]+d610*k10[i]+d611*k11[i]+d612*k12[i]+d613*k13[i]+d614*k14[i]+d615*k15[i]+d616*k16[i])
      @inbounds integrator.k[7][i] = @muladd(d701*k1[i]+d706*k6[i]+d707*k7[i]+d708*k8[i]+d709*k9[i]+d710*k10[i]+d711*k11[i]+d712*k12[i]+d713*k13[i]+d714*k14[i]+d715*k15[i]+d716*k16[i])
    end
  end
  @pack integrator = t,dt,u,k
end

@inline function initialize!(integrator,cache::TsitPap8ConstantCache,f=integrator.f)
  integrator.fsalfirst = f(integrator.t,integrator.uprev) # Pre-start fsal
  integrator.kshortsize = 2
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
end

#=
@inline function perform_step!(integrator,cache::TsitPap8ConstantCache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13 = cache
  k1 = integrator.fsalfirst
  a = dt*a0201
  k2 = f(@muladd(t + c1*dt),@.(@muladd(uprev+a*k1)))
  k3 = f(@muladd(t + c2*dt),@.(@muladd(uprev+dt*(a0301*k1+a0302*k2))))
  k4 = f(@muladd(t + c3*dt),@.(@muladd(uprev+dt*(a0401*k1       +a0403*k3))))
  k5 = f(@muladd(t + c4*dt),@.(@muladd(uprev+dt*(a0501*k1       +a0503*k3+a0504*k4))))
  k6 = f(@muladd(t + c5*dt),@.(@muladd(uprev+dt*(a0601*k1                +a0604*k4+a0605*k5))))
  k7 = f(@muladd(t + c6*dt),@.(@muladd(uprev+dt*(a0701*k1                +a0704*k4+a0705*k5+a0706*k6))))
  k8 = f(@muladd(t + c7*dt),@.(@muladd(uprev+dt*(a0801*k1                +a0804*k4+a0805*k5+a0806*k6+a0807*k7))))
  k9 = f(@muladd(t + c8*dt),@.(@muladd(uprev+dt*(a0901*k1                +a0904*k4+a0905*k5+a0906*k6+a0907*k7+a0908*k8))))
  k10 =f(@muladd(t + c9*dt),@.(@muladd(uprev+dt*(a1001*k1                +a1004*k4+a1005*k5+a1006*k6+a1007*k7+a1008*k8+a1009*k9))))
  k11= f(@muladd(t + c10*dt),@.(@muladd(uprev+dt*(a1101*k1                +a1104*k4+a1105*k5+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10))))
  k12= f(t+dt,@.(@muladd(uprev+dt*(a1201*k1                +a1204*k4+a1205*k5+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11))))
  k13= f(t+dt,@.(@muladd(uprev+dt*(a1301*k1                +a1304*k4+a1305*k5+a1306*k6+a1307*k7+a1308*k8+a1309*k9+a1310*k10))))
  update = @. dt*(@muladd(b1*k1+b6*k6+b7*k7+b8*k8+b9*k9+b10*k10+b11*k11+b12*k12))
  u = uprev + update
  if integrator.opts.adaptive
    tmp = @. @muladd(update - dt*(k1*bhat1 + k6*bhat6 + k7*bhat7 + k8*bhat8 + k9*bhat9 + k10*bhat10 + k13*bhat13))./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol)
    integrator.EEst = integrator.opts.internalnorm(tmp)
  end
  k = f(t+dt,u)
  integrator.fsallast = k
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  @pack integrator = t,dt,u
end
=#

@inline function perform_step!(integrator,cache::TsitPap8ConstantCache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13 = cache
  k1 = integrator.fsalfirst
  a = dt*a0201
  k2 = f(@muladd(t + c1*dt),uprev+a*k1)
  k3 = f(@muladd(t + c2*dt),@muladd(uprev+dt*(a0301*k1+a0302*k2)))
  k4 = f(@muladd(t + c3*dt),@muladd(uprev+dt*(a0401*k1       +a0403*k3)))
  k5 = f(@muladd(t + c4*dt),@muladd(uprev+dt*(a0501*k1       +a0503*k3+a0504*k4)))
  k6 = f(@muladd(t + c5*dt),@muladd(uprev+dt*(a0601*k1                +a0604*k4+a0605*k5)))
  k7 = f(@muladd(t + c6*dt),@muladd(uprev+dt*(a0701*k1                +a0704*k4+a0705*k5+a0706*k6)))
  k8 = f(@muladd(t + c7*dt),@muladd(uprev+dt*(a0801*k1                +a0804*k4+a0805*k5+a0806*k6+a0807*k7)))
  k9 = f(@muladd(t + c8*dt),@muladd(uprev+dt*(a0901*k1                +a0904*k4+a0905*k5+a0906*k6+a0907*k7+a0908*k8)))
  k10 =f(@muladd(t + c9*dt),@muladd(uprev+dt*(a1001*k1                +a1004*k4+a1005*k5+a1006*k6+a1007*k7+a1008*k8+a1009*k9)))
  k11= f(@muladd(t + c10*dt),@muladd(uprev+dt*(a1101*k1                +a1104*k4+a1105*k5+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10)))
  k12= f(t+dt,@muladd(uprev+dt*(a1201*k1                +a1204*k4+a1205*k5+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11)))
  k13= f(t+dt,@muladd(uprev+dt*(a1301*k1                +a1304*k4+a1305*k5+a1306*k6+a1307*k7+a1308*k8+a1309*k9+a1310*k10)))
  update = dt*(@muladd(b1*k1+b6*k6+b7*k7+b8*k8+b9*k9+b10*k10+b11*k11+b12*k12))
  u = uprev + update
  if integrator.opts.adaptive
    integrator.EEst = integrator.opts.internalnorm(@muladd(update - dt*(k1*bhat1 + k6*bhat6 + k7*bhat7 + k8*bhat8 + k9*bhat9 + k10*bhat10 + k13*bhat13))./@muladd(integrator.opts.abstol+max.(abs.(uprev),abs.(u)).*integrator.opts.reltol))
  end
  k = f(t+dt,u)
  integrator.fsallast = k
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  @pack integrator = t,dt,u
end

@inline function initialize!(integrator,cache::TsitPap8Cache,f=integrator.f)
  integrator.fsalfirst = cache.fsalfirst
  integrator.fsallast = cache.k
  integrator.kshortsize = 2
  integrator.k = eltype(integrator.sol.k)(integrator.kshortsize)
  integrator.k[1] = integrator.fsalfirst
  integrator.k[2] = integrator.fsallast
  f(integrator.t,integrator.uprev,integrator.fsalfirst) # Pre-start fsal
end

#=
@inline function perform_step!(integrator,cache::TsitPap8Cache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  uidx = eachindex(integrator.uprev)
  @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13 = cache.tab
  @unpack k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,utilde,update,tmp,atmp,k = cache
  k1 = cache.fsalfirst
  f(t,uprev,k1)
  a = dt*a0201
  @. tmp = @muladd uprev+a*k1
  f(@muladd(t + c1*dt),tmp,k2)
  @. tmp = @muladd uprev+dt*(a0301*k1+a0302*k2)
  f(@muladd(t + c2*dt),tmp,k3)
  @. tmp = @muladd uprev+dt*(a0401*k1+a0403*k3)
  f(@muladd(t + c3*dt),tmp,k4)
  @. tmp = @muladd uprev+dt*(a0501*k1+a0503*k3+a0504*k4)
  f(@muladd(t + c4*dt),tmp,k5)
  @. tmp = @muladd uprev+dt*(a0601*k1+a0604*k4+a0605*k5)
  f(@muladd(t + c5*dt),tmp,k6)
  @. tmp = @muladd uprev+dt*(a0701*k1+a0704*k4+a0705*k5+a0706*k6)
  f(@muladd(t + c6*dt),tmp,k7)
  @. tmp = @muladd uprev+dt*(a0801*k1+a0804*k4+a0805*k5+a0806*k6+a0807*k7)
  f(@muladd(t + c7*dt),tmp,k8)
  @. tmp = @muladd uprev+dt*(a0901*k1+a0904*k4+a0905*k5+a0906*k6+a0907*k7+a0908*k8)
  f(@muladd(t + c8*dt),tmp,k9)
  @. tmp = @muladd uprev+dt*(a1001*k1+a1004*k4+a1005*k5+a1006*k6+a1007*k7+a1008*k8+a1009*k9)
  f(@muladd(t + c9*dt),tmp,k10)
  @. tmp = @muladd uprev+dt*(a1101*k1+a1104*k4+a1105*k5+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10)
  f(@muladd(t + c10*dt),tmp,k11)
  @. tmp = @muladd uprev+dt*(a1201*k1+a1204*k4+a1205*k5+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11)
  f(t+dt,tmp,k12)
  @. tmp = @muladd uprev+dt*(a1301*k1+a1304*k4+a1305*k5+a1306*k6+a1307*k7+a1308*k8+a1309*k9+a1310*k10)
  f(t+dt,tmp,k13)
  @. update = dt*@muladd(b1*k1+b6*k6+b7*k7+b8*k8+b9*k9+b10*k10+b11*k11+b12*k12)
  @. u = uprev + update
  if integrator.opts.adaptive
    @. atmp = (@muladd(update - dt*(k1*bhat1 + k6*bhat6 + k7*bhat7 + k8*bhat8 + k9*bhat9 + k10*bhat10 + k13*bhat13))./@muladd(integrator.opts.abstol+max(abs(uprev),abs(u)).*integrator.opts.reltol))
    integrator.EEst = integrator.opts.internalnorm(atmp)
  end
  f(t+dt,u,k)
  @pack integrator = t,dt,u
end
=#

@inline function perform_step!(integrator,cache::TsitPap8Cache,f=integrator.f)
  @unpack t,dt,uprev,u,k = integrator
  uidx = eachindex(integrator.uprev)
  @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13 = cache.tab
  @unpack k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,utilde,update,tmp,atmp,k = cache
  k1 = cache.fsalfirst
  f(t,uprev,k1)
  a = dt*a0201
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+a*k1[i]
  end
  f(@muladd(t + c1*dt),tmp,k2)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0301*k1[i]+a0302*k2[i])
  end
  f(@muladd(t + c2*dt),tmp,k3)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0401*k1[i]+a0403*k3[i])
  end
  f(@muladd(t + c3*dt),tmp,k4)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0501*k1[i]+a0503*k3[i]+a0504*k4[i])
  end
  f(@muladd(t + c4*dt),tmp,k5)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0601*k1[i]+a0604*k4[i]+a0605*k5[i])
  end
  f(@muladd(t + c5*dt),tmp,k6)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0701*k1[i]+a0704*k4[i]+a0705*k5[i]+a0706*k6[i])
  end
  f(@muladd(t + c6*dt),tmp,k7)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0801*k1[i]+a0804*k4[i]+a0805*k5[i]+a0806*k6[i]+a0807*k7[i])
  end
  f(@muladd(t + c7*dt),tmp,k8)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a0901*k1[i]+a0904*k4[i]+a0905*k5[i]+a0906*k6[i]+a0907*k7[i]+a0908*k8[i])
  end
  f(@muladd(t + c8*dt),tmp,k9)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a1001*k1[i]+a1004*k4[i]+a1005*k5[i]+a1006*k6[i]+a1007*k7[i]+a1008*k8[i]+a1009*k9[i])
  end
  f(@muladd(t + c9*dt),tmp,k10)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a1101*k1[i]+a1104*k4[i]+a1105*k5[i]+a1106*k6[i]+a1107*k7[i]+a1108*k8[i]+a1109*k9[i]+a1110*k10[i])
  end
  f(@muladd(t + c10*dt),tmp,k11)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a1201*k1[i]+a1204*k4[i]+a1205*k5[i]+a1206*k6[i]+a1207*k7[i]+a1208*k8[i]+a1209*k9[i]+a1210*k10[i]+a1211*k11[i])
  end
  f(t+dt,tmp,k12)
  @tight_loop_macros for i in uidx
    @inbounds tmp[i] = @muladd uprev[i]+dt*(a1301*k1[i]+a1304*k4[i]+a1305*k5[i]+a1306*k6[i]+a1307*k7[i]+a1308*k8[i]+a1309*k9[i]+a1310*k10[i])
  end
  f(t+dt,tmp,k13)
  @tight_loop_macros for i in uidx
    @inbounds update[i] = dt*@muladd(b1*k1[i]+b6*k6[i]+b7*k7[i]+b8*k8[i]+b9*k9[i]+b10*k10[i]+b11*k11[i]+b12*k12[i])
    @inbounds u[i] = uprev[i] + update[i]
  end
  if integrator.opts.adaptive
    @tight_loop_macros for (i,atol,rtol) in zip(uidx,Iterators.cycle(integrator.opts.abstol),Iterators.cycle(integrator.opts.reltol))
      @inbounds atmp[i] = (@muladd(update[i] - dt*(k1[i]*bhat1 + k6[i]*bhat6 + k7[i]*bhat7 + k8[i]*bhat8 + k9[i]*bhat9 + k10[i]*bhat10 + k13[i]*bhat13))./@muladd(atol+max(abs(uprev[i]),abs(u[i])).*rtol))
    end
    integrator.EEst = integrator.opts.internalnorm(atmp)
  end
  f(t+dt,u,k)
  @pack integrator = t,dt,u
end
