type VectorF{F,SizeType} <: Function
  f::F
  sizeu::SizeType
end
function (p::VectorF)(t,uprev,du)
  p.f(t,reshape(uprev,p.sizeu...),reshape(du,p.sizeu...))
  uprev = vec(uprev)
  du = vec(du)
end

type VectorFReturn{F,SizeType} <: Function
  f::F
  sizeu::SizeType
end
function (p::VectorFReturn)(t,uprev,du)
  p.f(t,reshape(uprev,p.sizeu...),reshape(du,p.sizeu...))
  vec(du)
end

type TimeGradientWrapper{VFType,uType} <: Function
  vf::VFType
  uprev::uType
end
(p::TimeGradientWrapper)(t) = (du2 = similar(p.uprev); p.vf(t,p.uprev,du2); du2)
(p::TimeGradientWrapper)(du2,t) = p.vf(t,p.uprev,du2)

type UJacobianWrapper{VFRType,tType} <: Function
  vfr::VFRType
  t::tType
end

(p::UJacobianWrapper)(du1,uprev) = p.vfr(p.t,uprev,du1)
(p::UJacobianWrapper)(uprev) = (du1 = similar(uprev); p.vfr(p.t,uprev,du1); du1)

type TimeDerivativeWrapper{F,uType} <: Function
  f::F
  u::uType
end
(p::TimeDerivativeWrapper)(t) = p.f(t,p.u)

type UDerivativeWrapper{F,tType} <: Function
  f::F
  t::tType
end
(p::UDerivativeWrapper)(u) = p.f(p.t,u)
