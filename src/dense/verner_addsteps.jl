#=
"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern6ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 9 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a94,a95,a96,a97,a98,b1,b4,b5,b6,b7,b8,b9= cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c1*dt,@.(@muladd(uprev+dt*(a21*k[1])))))
    copyat_or_push!(k,3,f(t+c2*dt,@.(@muladd(uprev+dt*(a31*k[1]+a32*k[2])))))
    copyat_or_push!(k,4,f(t+c3*dt,@.(@muladd(uprev+dt*(a41*k[1]       +a43*k[3])))))
    copyat_or_push!(k,5,f(t+c4*dt,@.(@muladd(uprev+dt*(a51*k[1]       +a53*k[3]+a54*k[4])))))
    copyat_or_push!(k,6,f(t+c5*dt,@.(@muladd(uprev+dt*(a61*k[1]       +a63*k[3]+a64*k[4]+a65*k[5])))))
    copyat_or_push!(k,7,f(t+c6*dt,@.(@muladd(uprev+dt*(a71*k[1]       +a73*k[3]+a74*k[4]+a75*k[5]+a76*k[6])))))
    copyat_or_push!(k,8,f(t+dt,@.(@muladd(uprev+dt*(a81*k[1]       +a83*k[3]+a84*k[4]+a85*k[5]+a86*k[6]+a87*k[7])))))
    copyat_or_push!(k,9,f(t+dt,@.(@muladd(uprev+dt*(a91*k[1]+a94*k[4]+a95*k[5]+a96*k[6]+a97*k[7]+a98*k[8])))))
  end
  if (calcVal2 && length(k)< 12) || calcVal3 # Have not added the extra stages yet
    @unpack c10,a1001,a1004,a1005,a1006,a1007,a1008,a1009,c11,a1101,a1102,a1103,a1104,a1105,a1106,a1107,a1108,a1109,a1110,c12,a1201,a1202,a1203,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache
    copyat_or_push!(k,10,f(t+c10*dt,@.(@muladd(uprev+dt*(a1001*k[1]+a1004*k[4]+a1005*k[5]+a1006*k[6]+a1007*k[7]+a1008*k[8]+a1009*k[9])))))
    copyat_or_push!(k,11,f(t+c11*dt,@.(@muladd(uprev+dt*(a1101*k[1]+a1102*k[2]+a1103*k[3]+a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9]+a1110*k[10])))))
    copyat_or_push!(k,12,f(t+c12*dt,@.(@muladd(uprev+dt*(a1201*k[1]+a1202*k[2]+a1203*k[3]+a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1210*k[10]+a1211*k[11])))))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern6Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 9 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a94,a95,a96,a97,a98,b1,b4,b5,b6,b7,b8,b9= cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,utilde,tmp,atmp = cache
    @. tmp = @muladd uprev+dt*(a21*k1)
    f(t+c1*dt,tmp,k2)
    @. tmp = @muladd uprev+dt*(a31*k1+a32*k2)
    f(t+c2*dt,tmp,k3)
    @. tmp = @muladd uprev+dt*(a41*k1+a43*k3)
    f(t+c3*dt,tmp,k4)
    @. tmp = @muladd uprev+dt*(a51*k1+a53*k3+a54*k4)
    f(t+c4*dt,tmp,k5)
    @. tmp = @muladd uprev+dt*(a61*k1+a63*k3+a64*k4+a65*k5)
    f(t+c5*dt,tmp,k6)
    @. tmp = @muladd uprev+dt*(a71*k1+a73*k3+a74*k4+a75*k5+a76*k6)
    f(t+c6*dt,tmp,k7)
    @. tmp = @muladd uprev+dt*(a81*k1+a83*k3+a84*k4+a85*k5+a86*k6+a87*k7)
    f(t+dt,tmp,k8)
    @. tmp = @muladd uprev+dt*(a91*k1+a94*k4+a95*k5+a96*k6+a97*k7+a98*k8)
    f(t+dt,tmp,k9)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
  end
  if (calcVal2 && length(k)< 12) || calcVal3 # Have not added the extra stages yet
    @unpack c10,a1001,a1004,a1005,a1006,a1007,a1008,a1009,c11,a1101,a1102,a1103,a1104,a1105,a1106,a1107,a1108,a1109,a1110,c12,a1201,a1202,a1203,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache.tab
    @unpack tmp = cache
    rtmp = similar(cache.k1)
    @. tmp = @muladd uprev+dt*(a1001*k[1]+a1004*k[4]+a1005*k[5]+a1006*k[6]+a1007*k[7]+a1008*k[8]+a1009*k[9])
    f(t+c10*dt,tmp,rtmp); copyat_or_push!(k,10,rtmp)
    @. tmp = @muladd uprev+dt*(a1101*k[1]+a1102*k[2]+a1103*k[3]+a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9]+a1110*k[10])
    f(t+c11*dt,tmp,rtmp); copyat_or_push!(k,11,rtmp)
    @. tmp = @muladd uprev+dt*(a1201*k[1]+a1202*k[2]+a1203*k[3]+a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1210*k[10]+a1211*k[11])
    f(t+c12*dt,tmp,rtmp); copyat_or_push!(k,12,rtmp,Val{false})
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern7ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 10 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,a021,a031,a032,a041,a043,a051,a053,a054,a061,a063,a064,a065,a071,a073,a074,a075,a076,a081,a083,a084,a085,a086,a087,a091,a093,a094,a095,a096,a097,a098,a101,a103,a104,a105,a106,a107,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat10= cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c2*dt,@.(@muladd(uprev+dt*(a021*k[1])))))
    copyat_or_push!(k,3,f(t+c3*dt,@.(@muladd(uprev+dt*(a031*k[1]+a032*k[2])))))
    copyat_or_push!(k,4,f(t+c4*dt,@.(@muladd(uprev+dt*(a041*k[1]       +a043*k[3])))))
    copyat_or_push!(k,5,f(t+c5*dt,@.(@muladd(uprev+dt*(a051*k[1]       +a053*k[3]+a054*k[4])))))
    copyat_or_push!(k,6,f(t+c6*dt,@.(@muladd(uprev+dt*(a061*k[1]       +a063*k[3]+a064*k[4]+a065*k[5])))))
    copyat_or_push!(k,7,f(t+c7*dt,@.(@muladd(uprev+dt*(a071*k[1]       +a073*k[3]+a074*k[4]+a075*k[5]+a076*k[6])))))
    copyat_or_push!(k,8,f(t+c8*dt,@.(@muladd(uprev+dt*(a081*k[1]       +a083*k[3]+a084*k[4]+a085*k[5]+a086*k[6]+a087*k[7])))))
    copyat_or_push!(k,9,f(t+dt, @.(@muladd(uprev+dt*(a091*k[1]          +a093*k[3]+a094*k[4]+a095*k[5]+a096*k[6]+a097*k[7]+a098*k[8])))))
    copyat_or_push!(k,10,f(t+dt,@.(@muladd(uprev+dt*(a101*k[1]          +a103*k[3]+a104*k[4]+a105*k[5]+a106*k[6]+a107*k[7])))))
  end
  if (calcVal2 && length(k)< 16) || calcVal3 # Have not added the extra stages yet
    @unpack c11,a1101,a1104,a1105,a1106,a1107,a1108,a1109,c12,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1211,c13,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1311,a1312,c14,a1401,a1404,a1405,a1406,a1407,a1408,a1409,a1411,a1412,a1413,c15,a1501,a1504,a1505,a1506,a1507,a1508,a1509,a1511,a1512,a1513,c16,a1601,a1604,a1605,a1606,a1607,a1608,a1609,a1611,a1612,a1613 = cache
    copyat_or_push!(k,11,f(t+c11*dt,@.(@muladd(uprev+dt*(a1101*k[1]+a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9])))))
    copyat_or_push!(k,12,f(t+c12*dt,@.(@muladd(uprev+dt*(a1201*k[1]+a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1211*k[11])))))
    copyat_or_push!(k,13,f(t+c13*dt,@.(@muladd(uprev+dt*(a1301*k[1]+a1304*k[4]+a1305*k[5]+a1306*k[6]+a1307*k[7]+a1308*k[8]+a1309*k[9]+a1311*k[11]+a1312*k[12])))))
    copyat_or_push!(k,14,f(t+c14*dt,@.(@muladd(uprev+dt*(a1401*k[1]+a1404*k[4]+a1405*k[5]+a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1411*k[11]+a1412*k[12]+a1413*k[13])))))
    copyat_or_push!(k,15,f(t+c15*dt,@.(@muladd(uprev+dt*(a1501*k[1]+a1504*k[4]+a1505*k[5]+a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1511*k[11]+a1512*k[12]+a1513*k[13])))))
    copyat_or_push!(k,16,f(t+c16*dt,@.(@muladd(uprev+dt*(a1601*k[1]+a1604*k[4]+a1605*k[5]+a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1611*k[11]+a1612*k[12]+a1613*k[13])))))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern7Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 10 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,a021,a031,a032,a041,a043,a051,a053,a054,a061,a063,a064,a065,a071,a073,a074,a075,a076,a081,a083,a084,a085,a086,a087,a091,a093,a094,a095,a096,a097,a098,a101,a103,a104,a105,a106,a107,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat10= cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,update,utilde,tmp,atmp = cache
    f(t,uprev,k1)
    @. tmp = @muladd uprev+dt*(a021*k1)
    f(t+c2*dt,tmp,k2)
    @. tmp = @muladd uprev+dt*(a031*k1+a032*k2)
    f(t+c3*dt,tmp,k3)
    @. tmp = @muladd uprev+dt*(a041*k1+a043*k3)
    f(t+c4*dt,tmp,k4)
    @. tmp = @muladd uprev+dt*(a051*k1+a053*k3+a054*k4)
    f(t+c5*dt,tmp,k5)
    @. tmp = @muladd uprev+dt*(a061*k1+a063*k3+a064*k4+a065*k5)
    f(t+c6*dt,tmp,k6)
    @. tmp = @muladd uprev+dt*(a071*k1+a073*k3+a074*k4+a075*k5+a076*k6)
    f(t+c7*dt,tmp,k7)
    @. tmp = @muladd uprev+dt*(a081*k1+a083*k3+a084*k4+a085*k5+a086*k6+a087*k7)
    f(t+c8*dt,tmp,k8)
    @. tmp = @muladd uprev+dt*(a091*k1+a093*k3+a094*k4+a095*k5+a096*k6+a097*k7+a098*k8)
    f(t+dt,tmp,k9)
    @. tmp = @muladd uprev+dt*(a101*k1+a103*k3+a104*k4+a105*k5+a106*k6+a107*k7)
    f(t+dt,tmp,k10)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
    copyat_or_push!(k,10,k10)
  end
  if (calcVal2 && length(k)< 16) || calcVal3 # Have not added the extra stages yet
    @unpack tmp = cache
    rtmp = similar(cache.k1)
    @unpack c11,a1101,a1104,a1105,a1106,a1107,a1108,a1109,c12,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1211,c13,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1311,a1312,c14,a1401,a1404,a1405,a1406,a1407,a1408,a1409,a1411,a1412,a1413,c15,a1501,a1504,a1505,a1506,a1507,a1508,a1509,a1511,a1512,a1513,c16,a1601,a1604,a1605,a1606,a1607,a1608,a1609,a1611,a1612,a1613 = cache.tab
    @. tmp = @muladd uprev+dt*(a1101*k[1]+a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9])
    f(t+c11*dt,tmp,rtmp); copyat_or_push!(k,11,rtmp)
    @. tmp = @muladd uprev+dt*(a1201*k[1]+a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1211*k[11])
    f(t+c12*dt,tmp,rtmp); copyat_or_push!(k,12,rtmp)
    @. tmp = @muladd uprev+dt*(a1301*k[1]+a1304*k[4]+a1305*k[5]+a1306*k[6]+a1307*k[7]+a1308*k[8]+a1309*k[9]+a1311*k[11]+a1312*k[12])
    f(t+c13*dt,tmp,rtmp); copyat_or_push!(k,13,rtmp)
    @. tmp = @muladd uprev+dt*(a1401*k[1]+a1404*k[4]+a1405*k[5]+a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1411*k[11]+a1412*k[12]+a1413*k[13])
    f(t+c14*dt,tmp,rtmp); copyat_or_push!(k,14,rtmp)
    @. tmp=  @muladd uprev+dt*(a1501*k[1]+a1504*k[4]+a1505*k[5]+a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1511*k[11]+a1512*k[12]+a1513*k[13])
    f(t+c15*dt,tmp,rtmp); copyat_or_push!(k,15,rtmp)
    @. tmp = @muladd uprev+dt*(a1601*k[1]+a1604*k[4]+a1605*k[5]+a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1611*k[11]+a1612*k[12]+a1613*k[13])
    f(t+c16*dt,tmp,rtmp); copyat_or_push!(k,16,rtmp,Val{false})
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern8ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) <13 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13 = cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c2*dt ,@.(@muladd(uprev+dt*(a0201*k[1])))))
    copyat_or_push!(k,3,f(t+c3*dt ,@.(@muladd(uprev+dt*(a0301*k[1]+a0302*k[2])))))
    copyat_or_push!(k,4,f(t+c4*dt ,@.(@muladd(uprev+dt*(a0401*k[1]       +a0403*k[3])))))
    copyat_or_push!(k,5,f(t+c5*dt ,@.(@muladd(uprev+dt*(a0501*k[1]       +a0503*k[3]+a0504*k[4])))))
    copyat_or_push!(k,6,f(t+c6*dt ,@.(@muladd(uprev+dt*(a0601*k[1]                +a0604*k[4]+a0605*k[5])))))
    copyat_or_push!(k,7,f(t+c7*dt ,@.(@muladd(uprev+dt*(a0701*k[1]                +a0704*k[4]+a0705*k[5]+a0706*k[6])))))
    copyat_or_push!(k,8,f(t+c8*dt ,@.(@muladd(uprev+dt*(a0801*k[1]                +a0804*k[4]+a0805*k[5]+a0806*k[6]+a0807*k[7])))))
    copyat_or_push!(k,9,f(t+c9*dt ,@.(@muladd(uprev+dt*(a0901*k[1]                +a0904*k[4]+a0905*k[5]+a0906*k[6]+a0907*k[7]+a0908*k[8])))))
    copyat_or_push!(k,10,f(t+c10*dt,@.(@muladd(uprev+dt*(a1001*k[1]                +a1004*k[4]+a1005*k[5]+a1006*k[6]+a1007*k[7]+a1008*k[8]+a1009*k[9])))))
    copyat_or_push!(k,11,f(t+c11*dt,@.(@muladd(uprev+dt*(a1101*k[1]                +a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9]+a1110*k[10])))))
    copyat_or_push!(k,12,f(t+    dt,@.(@muladd(uprev+dt*(a1201*k[1]                +a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1210*k[10]+a1211*k[11])))))
    copyat_or_push!(k,13,f(t+    dt,@.(@muladd(uprev+dt*(a1301*k[1]                +a1304*k[4]+a1305*k[5]+a1306*k[6]+a1307*k[7]+a1308*k[8]+a1309*k[9]+a1310*k[10])))))
  end
  if (calcVal2 && length(k)< 21) || calcVal3 # Have not added the extra stages yet
    @unpack c14,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,c15,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1514,c16,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1614,a1615,c17,a1701,a1706,a1707,a1708,a1709,a1710,a1711,a1712,a1714,a1715,a1716,c18,a1801,a1806,a1807,a1808,a1809,a1810,a1811,a1812,a1814,a1815,a1816,a1817,c19,a1901,a1906,a1907,a1908,a1909,a1910,a1911,a1912,a1914,a1915,a1916,a1917,c20,a2001,a2006,a2007,a2008,a2009,a2010,a2011,a2012,a2014,a2015,a2016,a2017,c21,a2101,a2106,a2107,a2108,a2109,a2110,a2111,a2112,a2114,a2115,a2116,a2117 = cache
    copyat_or_push!(k,14,f(t+c14*dt,@.(@muladd(uprev+dt*(a1401*k[1]+a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1410*k[10]+a1411*k[11]+a1412*k[12])))))
    copyat_or_push!(k,15,f(t+c15*dt,@.(@muladd(uprev+dt*(a1501*k[1]+a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1510*k[10]+a1511*k[11]+a1512*k[12]+a1514*k[14])))))
    copyat_or_push!(k,16,f(t+c16*dt,@.(@muladd(uprev+dt*(a1601*k[1]+a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1610*k[10]+a1611*k[11]+a1612*k[12]+a1614*k[14]+a1615*k[15])))))
    copyat_or_push!(k,17,f(t+c17*dt,@.(@muladd(uprev+dt*(a1701*k[1]+a1706*k[6]+a1707*k[7]+a1708*k[8]+a1709*k[9]+a1710*k[10]+a1711*k[11]+a1712*k[12]+a1714*k[14]+a1715*k[15]+a1716*k[16])))))
    copyat_or_push!(k,18,f(t+c18*dt,@.(@muladd(uprev+dt*(a1801*k[1]+a1806*k[6]+a1807*k[7]+a1808*k[8]+a1809*k[9]+a1810*k[10]+a1811*k[11]+a1812*k[12]+a1814*k[14]+a1815*k[15]+a1816*k[16]+a1817*k[17])))))
    copyat_or_push!(k,19,f(t+c19*dt,@.(@muladd(uprev+dt*(a1901*k[1]+a1906*k[6]+a1907*k[7]+a1908*k[8]+a1909*k[9]+a1910*k[10]+a1911*k[11]+a1912*k[12]+a1914*k[14]+a1915*k[15]+a1916*k[16]+a1917*k[17])))))
    copyat_or_push!(k,20,f(t+c20*dt,@.(@muladd(uprev+dt*(a2001*k[1]+a2006*k[6]+a2007*k[7]+a2008*k[8]+a2009*k[9]+a2010*k[10]+a2011*k[11]+a2012*k[12]+a2014*k[14]+a2015*k[15]+a2016*k[16]+a2017*k[17])))))
    copyat_or_push!(k,21,f(t+c21*dt,@.(@muladd(uprev+dt*(a2101*k[1]+a2106*k[6]+a2107*k[7]+a2108*k[8]+a2109*k[9]+a2110*k[10]+a2111*k[11]+a2112*k[12]+a2114*k[14]+a2115*k[15]+a2116*k[16]+a2117*k[17])))))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern8Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) <13 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13= cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,utilde,update,tmp,atmp = cache
    f(t,uprev,k1)
    @. tmp = @muladd uprev+dt*(a0201*k1)
    f(t+c2*dt,tmp,k2)
    @. tmp = @muladd uprev+dt*(a0301*k1+a0302*k2)
    f(t+c3*dt,tmp,k3)
    @. tmp = @muladd uprev+dt*(a0401*k1+a0403*k3)
    f(t+c4*dt,tmp,k4)
    @. tmp = @muladd uprev+dt*(a0501*k1+a0503*k3+a0504*k4)
    f(t+c5*dt,tmp,k5)
    @. tmp = @muladd uprev+dt*(a0601*k1+a0604*k4+a0605*k5)
    f(t+c6*dt,tmp,k6)
    @. tmp = @muladd uprev+dt*(a0701*k1+a0704*k4+a0705*k5+a0706*k6)
    f(t+c7*dt,tmp,k7)
    @. tmp = @muladd uprev+dt*(a0801*k1+a0804*k4+a0805*k5+a0806*k6+a0807*k7)
    f(t+c8*dt,tmp,k8)
    @. tmp = @muladd uprev+dt*(a0901*k1+a0904*k4+a0905*k5+a0906*k6+a0907*k7+a0908*k8)
    f(t+c9*dt,tmp,k9)
    @. tmp = @muladd uprev+dt*(a1001*k1+a1004*k4+a1005*k5+a1006*k6+a1007*k7+a1008*k8+a1009*k9)
    f(t+c10*dt,tmp,k10)
    @. tmp = @muladd uprev+dt*(a1101*k1+a1104*k4+a1105*k5+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10)
    f(t+c11*dt,tmp,k11)
    @. tmp = @muladd uprev+dt*(a1201*k1+a1204*k4+a1205*k5+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11)
    f(t+dt,tmp,k12)
    @. tmp = @muladd uprev+dt*(a1301*k1+a1304*k4+a1305*k5+a1306*k6+a1307*k7+a1308*k8+a1309*k9+a1310*k10)
    f(t+dt,tmp,k13)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
    copyat_or_push!(k,10,k10)
    copyat_or_push!(k,11,k11)
    copyat_or_push!(k,12,k12)
    copyat_or_push!(k,13,k13)
  end
  if (calcVal2 && length(k)< 21) || calcVal3 # Have not added the extra stages yet
    rtmp = similar(cache.k1)
    @unpack c14,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,c15,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1514,c16,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1614,a1615,c17,a1701,a1706,a1707,a1708,a1709,a1710,a1711,a1712,a1714,a1715,a1716,c18,a1801,a1806,a1807,a1808,a1809,a1810,a1811,a1812,a1814,a1815,a1816,a1817,c19,a1901,a1906,a1907,a1908,a1909,a1910,a1911,a1912,a1914,a1915,a1916,a1917,c20,a2001,a2006,a2007,a2008,a2009,a2010,a2011,a2012,a2014,a2015,a2016,a2017,c21,a2101,a2106,a2107,a2108,a2109,a2110,a2111,a2112,a2114,a2115,a2116,a2117 = cache.tab
    @unpack tmp = cache
    @. tmp = @muladd uprev+dt*(a1401*k[1]+a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1410*k[10]+a1411*k[11]+a1412*k[12])
    f(t+c14*dt,tmp,rtmp); copyat_or_push!(k,14,rtmp)
    @. tmp = @muladd uprev+dt*(a1501*k[1]+a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1510*k[10]+a1511*k[11]+a1512*k[12]+a1514*k[14])
    f(t+c15*dt,tmp,rtmp); copyat_or_push!(k,15,rtmp)
    @. tmp = @muladd uprev+dt*(a1601*k[1]+a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1610*k[10]+a1611*k[11]+a1612*k[12]+a1614*k[14]+a1615*k[15])
    f(t+c16*dt,tmp,rtmp); copyat_or_push!(k,16,rtmp)
    @. tmp = @muladd uprev+dt*(a1701*k[1]+a1706*k[6]+a1707*k[7]+a1708*k[8]+a1709*k[9]+a1710*k[10]+a1711*k[11]+a1712*k[12]+a1714*k[14]+a1715*k[15]+a1716*k[16])
    f(t+c17*dt,tmp,rtmp); copyat_or_push!(k,17,rtmp)
    @. tmp = @muladd uprev+dt*(a1801*k[1]+a1806*k[6]+a1807*k[7]+a1808*k[8]+a1809*k[9]+a1810*k[10]+a1811*k[11]+a1812*k[12]+a1814*k[14]+a1815*k[15]+a1816*k[16]+a1817*k[17])
    f(t+c18*dt,tmp,rtmp); copyat_or_push!(k,18,rtmp)
    @. tmp = @muladd uprev+dt*(a1901*k[1]+a1906*k[6]+a1907*k[7]+a1908*k[8]+a1909*k[9]+a1910*k[10]+a1911*k[11]+a1912*k[12]+a1914*k[14]+a1915*k[15]+a1916*k[16]+a1917*k[17])
    f(t+c19*dt,tmp,rtmp); copyat_or_push!(k,19,rtmp)
    @. tmp = @muladd uprev+dt*(a2001*k[1]+a2006*k[6]+a2007*k[7]+a2008*k[8]+a2009*k[9]+a2010*k[10]+a2011*k[11]+a2012*k[12]+a2014*k[14]+a2015*k[15]+a2016*k[16]+a2017*k[17])
    f(t+c20*dt,tmp,rtmp); copyat_or_push!(k,20,rtmp)
    @. tmp = @muladd uprev+dt*(a2101*k[1]+a2106*k[6]+a2107*k[7]+a2108*k[8]+a2109*k[9]+a2110*k[10]+a2111*k[11]+a2112*k[12]+a2114*k[14]+a2115*k[15]+a2116*k[16]+a2117*k[17])
    f(t+c21*dt,tmp,rtmp); copyat_or_push!(k,21,rtmp,Val{false})
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern9ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if (length(k) < 16 || calcVal) || ((calcVal2 && length(k)< 26) || calcVal3)
  end
  if length(k) < 16 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0806,a0807,a0901,a0906,a0907,a0908,a1001,a1006,a1007,a1008,a1009,a1101,a1106,a1107,a1108,a1109,a1110,a1201,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1306,a1307,a1308,a1309,a1310,a1311,a1312,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1613,b1,b8,b9,b10,b11,b12,b13,b14,b15,bhat1,bhat8,bhat9,bhat10,bhat11,bhat12,bhat13,bhat16 = cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c1*dt,@.(@muladd(uprev+dt*(a0201*k[1])))))
    copyat_or_push!(k,3,f(t+c2*dt,@.(@muladd(uprev+dt*(a0301*k[1]+a0302*k[2])))))
    copyat_or_push!(k,4,f(t+c3*dt,@.(@muladd(uprev+dt*(a0401*k[1]       +a0403*k[3])))))
    copyat_or_push!(k,5,f(t+c4*dt,@.(@muladd(uprev+dt*(a0501*k[1]       +a0503*k[3]+a0504*k[4])))))
    copyat_or_push!(k,6,f(t+c5*dt,@.(@muladd(uprev+dt*(a0601*k[1]                +a0604*k[4]+a0605*k[5])))))
    copyat_or_push!(k,7,f(t+c6*dt,@.(@muladd(uprev+dt*(a0701*k[1]                +a0704*k[4]+a0705*k[5]+a0706*k[6])))))
    copyat_or_push!(k,8,f(t+c7*dt,@.(@muladd(uprev+dt*(a0801*k[1]                                  +a0806*k[6]+a0807*k[7])))))
    copyat_or_push!(k,9,f(t+c8*dt,  @.(@muladd(uprev+dt*(a0901*k[1]                                  +a0906*k[6]+a0907*k[7]+a0908*k[8])))))
    copyat_or_push!(k,10,f(t+c9*dt, @.(@muladd(uprev+dt*(a1001*k[1]                                  +a1006*k[6]+a1007*k[7]+a1008*k[8]+a1009*k[9])))))
    copyat_or_push!(k,11,f(t+c10*dt,@.(@muladd(uprev+dt*(a1101*k[1]                                  +a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9]+a1110*k[10])))))
    copyat_or_push!(k,12,f(t+c11*dt,@.(@muladd(uprev+dt*(a1201*k[1]                                  +a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1210*k[10]+a1211*k[11])))))
    copyat_or_push!(k,13,f(t+c12*dt,@.(@muladd(uprev+dt*(a1301*k[1]                                  +a1306*k[6]+a1307*k[7]+a1308*k[8]+a1309*k[9]+a1310*k[10]+a1311*k[11]+a1312*k[12])))))
    copyat_or_push!(k,14,f(t+c13*dt,@.(@muladd(uprev+dt*(a1401*k[1]                                  +a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1410*k[10]+a1411*k[11]+a1412*k[12]+a1413*k[13])))))
    copyat_or_push!(k,15,f(t+dt,@.(@muladd(uprev+dt*(a1501*k[1]                                  +a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1510*k[10]+a1511*k[11]+a1512*k[12]+a1513*k[13]+a1514*k[14])))))
    copyat_or_push!(k,16,f(t+dt,@.(@muladd(uprev+dt*(a1601*k[1]                                  +a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1610*k[10]+a1611*k[11]+a1612*k[12]+a1613*k[13])))))
  end
  if (calcVal2 && length(k)< 26) || calcVal3 # Have not added the extra stages yet
    @unpack c17,a1701,a1708,a1709,a1710,a1711,a1712,a1713,a1714,a1715,c18,a1801,a1808,a1809,a1810,a1811,a1812,a1813,a1814,a1815,a1817,c19,a1901,a1908,a1909,a1910,a1911,a1912,a1913,a1914,a1915,a1917,a1918,c20,a2001,a2008,a2009,a2010,a2011,a2012,a2013,a2014,a2015,a2017,a2018,a2019,c21,a2101,a2108,a2109,a2110,a2111,a2112,a2113,a2114,a2115,a2117,a2118,a2119,a2120,c22,a2201,a2208,a2209,a2210,a2211,a2212,a2213,a2214,a2215,a2217,a2218,a2219,a2220,a2221,c23,a2301,a2308,a2309,a2310,a2311,a2312,a2313,a2314,a2315,a2317,a2318,a2319,a2320,a2321,c24,a2401,a2408,a2409,a2410,a2411,a2412,a2413,a2414,a2415,a2417,a2418,a2419,a2420,a2421,c25,a2501,a2508,a2509,a2510,a2511,a2512,a2513,a2514,a2515,a2517,a2518,a2519,a2520,a2521,c26,a2601,a2608,a2609,a2610,a2611,a2612,a2613,a2614,a2615,a2617,a2618,a2619,a2620,a2621 = cache
    copyat_or_push!(k,17,f(t+c17*dt,@.(@muladd(uprev+dt*(a1701*k[1]+a1708*k[8]+a1709*k[9]+a1710*k[10]+a1711*k[11]+a1712*k[12]+a1713*k[13]+a1714*k[14]+a1715*k[15])))))
    copyat_or_push!(k,18,f(t+c18*dt,@.(@muladd(uprev+dt*(a1801*k[1]+a1808*k[8]+a1809*k[9]+a1810*k[10]+a1811*k[11]+a1812*k[12]+a1813*k[13]+a1814*k[14]+a1815*k[15]+a1817*k[17])))))
    copyat_or_push!(k,19,f(t+c19*dt,@.(@muladd(uprev+dt*(a1901*k[1]+a1908*k[8]+a1909*k[9]+a1910*k[10]+a1911*k[11]+a1912*k[12]+a1913*k[13]+a1914*k[14]+a1915*k[15]+a1917*k[17]+a1918*k[18])))))
    copyat_or_push!(k,20,f(t+c20*dt,@.(@muladd(uprev+dt*(a2001*k[1]+a2008*k[8]+a2009*k[9]+a2010*k[10]+a2011*k[11]+a2012*k[12]+a2013*k[13]+a2014*k[14]+a2015*k[15]+a2017*k[17]+a2018*k[18]+a2019*k[19])))))
    copyat_or_push!(k,21,f(t+c21*dt,@.(@muladd(uprev+dt*(a2101*k[1]+a2108*k[8]+a2109*k[9]+a2110*k[10]+a2111*k[11]+a2112*k[12]+a2113*k[13]+a2114*k[14]+a2115*k[15]+a2117*k[17]+a2118*k[18]+a2119*k[19]+a2120*k[20])))))
    copyat_or_push!(k,22,f(t+c22*dt,@.(@muladd(uprev+dt*(a2201*k[1]+a2208*k[8]+a2209*k[9]+a2210*k[10]+a2211*k[11]+a2212*k[12]+a2213*k[13]+a2214*k[14]+a2215*k[15]+a2217*k[17]+a2218*k[18]+a2219*k[19]+a2220*k[20]+a2221*k[21])))))
    copyat_or_push!(k,23,f(t+c23*dt,@.(@muladd(uprev+dt*(a2301*k[1]+a2308*k[8]+a2309*k[9]+a2310*k[10]+a2311*k[11]+a2312*k[12]+a2313*k[13]+a2314*k[14]+a2315*k[15]+a2317*k[17]+a2318*k[18]+a2319*k[19]+a2320*k[20]+a2321*k[21])))))
    copyat_or_push!(k,24,f(t+c24*dt,@.(@muladd(uprev+dt*(a2401*k[1]+a2408*k[8]+a2409*k[9]+a2410*k[10]+a2411*k[11]+a2412*k[12]+a2413*k[13]+a2414*k[14]+a2415*k[15]+a2417*k[17]+a2418*k[18]+a2419*k[19]+a2420*k[20]+a2421*k[21])))))
    copyat_or_push!(k,25,f(t+c25*dt,@.(@muladd(uprev+dt*(a2501*k[1]+a2508*k[8]+a2509*k[9]+a2510*k[10]+a2511*k[11]+a2512*k[12]+a2513*k[13]+a2514*k[14]+a2515*k[15]+a2517*k[17]+a2518*k[18]+a2519*k[19]+a2520*k[20]+a2521*k[21])))))
    copyat_or_push!(k,26,f(t+c26*dt,@.(@muladd(uprev+dt*(a2601*k[1]+a2608*k[8]+a2609*k[9]+a2610*k[10]+a2611*k[11]+a2612*k[12]+a2613*k[13]+a2614*k[14]+a2615*k[15]+a2617*k[17]+a2618*k[18]+a2619*k[19]+a2620*k[20]+a2621*k[21])))))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern9Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 16 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0806,a0807,a0901,a0906,a0907,a0908,a1001,a1006,a1007,a1008,a1009,a1101,a1106,a1107,a1108,a1109,a1110,a1201,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1306,a1307,a1308,a1309,a1310,a1311,a1312,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1613,b1,b8,b9,b10,b11,b12,b13,b14,b15,bhat1,bhat8,bhat9,bhat10,bhat11,bhat12,bhat13,bhat16 = cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,utilde,update,tmp,atmp = cache
    f(t,uprev,k1)
    @. tmp = @muladd uprev+dt*(a0201*k1)
    f(t+c1*dt,tmp,k2)
    @. tmp = @muladd uprev+dt*(a0301*k1+a0302*k2)
    f(t+c2*dt,tmp,k3)
    @. tmp = @muladd uprev+dt*(a0401*k1+a0403*k3)
    f(t+c3*dt,tmp,k4)
    @. tmp = @muladd uprev+dt*(a0501*k1+a0503*k3+a0504*k4)
    f(t+c4*dt,tmp,k5)
    @. tmp = @muladd uprev+dt*(a0601*k1+a0604*k4+a0605*k5)
    f(t+c5*dt,tmp,k6)
    @. tmp = @muladd uprev+dt*(a0701*k1+a0704*k4+a0705*k5+a0706*k6)
    f(t+c6*dt,tmp,k7)
    @. tmp = @muladd uprev+dt*(a0801*k1+a0806*k6+a0807*k7)
    f(t+c7*dt,tmp,k8)
    @. tmp = @muladd uprev+dt*(a0901*k1+a0906*k6+a0907*k7+a0908*k8)
    f(t+c8*dt,tmp,k9)
    @. tmp = @muladd uprev+dt*(a1001*k1+a1006*k6+a1007*k7+a1008*k8+a1009*k9)
    f(t+c9*dt,tmp,k10)
    @. tmp = @muladd uprev+dt*(a1101*k1+a1106*k6+a1107*k7+a1108*k8+a1109*k9+a1110*k10)
    f(t+c10*dt,tmp,k11)
    @. tmp = @muladd uprev+dt*(a1201*k1+a1206*k6+a1207*k7+a1208*k8+a1209*k9+a1210*k10+a1211*k11)
    f(t+c11*dt,tmp,k12)
    @. tmp = @muladd uprev+dt*(a1301*k1+a1306*k6+a1307*k7+a1308*k8+a1309*k9+a1310*k10+a1311*k11+a1312*k12)
    f(t+c12*dt,tmp,k13)
    @. tmp = @muladd uprev+dt*(a1401*k1+a1406*k6+a1407*k7+a1408*k8+a1409*k9+a1410*k10+a1411*k11+a1412*k12+a1413*k13)
    f(t+c13*dt,tmp,k14)
    @. tmp = @muladd uprev+dt*(a1501*k1+a1506*k6+a1507*k7+a1508*k8+a1509*k9+a1510*k10+a1511*k11+a1512*k12+a1513*k13+a1514*k14)
    f(t+dt,tmp,k15)
    @. tmp = uprev+dt*(a1601*k1+a1606*k6+a1607*k7+a1608*k8+a1609*k9+a1610*k10+a1611*k11+a1612*k12+a1613*k13)
    f(t+dt,tmp,k16)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
    copyat_or_push!(k,10,k10)
    copyat_or_push!(k,11,k11)
    copyat_or_push!(k,12,k12)
    copyat_or_push!(k,13,k13)
    copyat_or_push!(k,14,k14)
    copyat_or_push!(k,15,k15)
    copyat_or_push!(k,16,k16)
  end
  if (calcVal2 && length(k)< 26) || calcVal3 # Have not added the extra stages yet
    rtmp = similar(cache.k1)
    @unpack tmp = cache
    @unpack c17,a1701,a1708,a1709,a1710,a1711,a1712,a1713,a1714,a1715,c18,a1801,a1808,a1809,a1810,a1811,a1812,a1813,a1814,a1815,a1817,c19,a1901,a1908,a1909,a1910,a1911,a1912,a1913,a1914,a1915,a1917,a1918,c20,a2001,a2008,a2009,a2010,a2011,a2012,a2013,a2014,a2015,a2017,a2018,a2019,c21,a2101,a2108,a2109,a2110,a2111,a2112,a2113,a2114,a2115,a2117,a2118,a2119,a2120,c22,a2201,a2208,a2209,a2210,a2211,a2212,a2213,a2214,a2215,a2217,a2218,a2219,a2220,a2221,c23,a2301,a2308,a2309,a2310,a2311,a2312,a2313,a2314,a2315,a2317,a2318,a2319,a2320,a2321,c24,a2401,a2408,a2409,a2410,a2411,a2412,a2413,a2414,a2415,a2417,a2418,a2419,a2420,a2421,c25,a2501,a2508,a2509,a2510,a2511,a2512,a2513,a2514,a2515,a2517,a2518,a2519,a2520,a2521,c26,a2601,a2608,a2609,a2610,a2611,a2612,a2613,a2614,a2615,a2617,a2618,a2619,a2620,a2621 = cache.tab
    @. tmp = @muladd uprev+dt*(a1701*k[1]+a1708*k[8]+a1709*k[9]+a1710*k[10]+a1711*k[11]+a1712*k[12]+a1713*k[13]+a1714*k[14]+a1715*k[15])
    f(t+c17*dt,tmp,rtmp); copyat_or_push!(k,17,rtmp)
    @. tmp = @muladd uprev+dt*(a1801*k[1]+a1808*k[8]+a1809*k[9]+a1810*k[10]+a1811*k[11]+a1812*k[12]+a1813*k[13]+a1814*k[14]+a1815*k[15]+a1817*k[17])
    f(t+c18*dt,tmp,rtmp); copyat_or_push!(k,18,rtmp)
    @. tmp = @muladd uprev+dt*(a1901*k[1]+a1908*k[8]+a1909*k[9]+a1910*k[10]+a1911*k[11]+a1912*k[12]+a1913*k[13]+a1914*k[14]+a1915*k[15]+a1917*k[17]+a1918*k[18])
    f(t+c19*dt,tmp,rtmp); copyat_or_push!(k,19,rtmp)
    @. tmp = @muladd uprev+dt*(a2001*k[1]+a2008*k[8]+a2009*k[9]+a2010*k[10]+a2011*k[11]+a2012*k[12]+a2013*k[13]+a2014*k[14]+a2015*k[15]+a2017*k[17]+a2018*k[18]+a2019*k[19])
    f(t+c20*dt,tmp,rtmp); copyat_or_push!(k,20,rtmp)
    @. tmp = @muladd uprev+dt*(a2101*k[1]+a2108*k[8]+a2109*k[9]+a2110*k[10]+a2111*k[11]+a2112*k[12]+a2113*k[13]+a2114*k[14]+a2115*k[15]+a2117*k[17]+a2118*k[18]+a2119*k[19]+a2120*k[20])
    f(t+c21*dt,tmp,rtmp); copyat_or_push!(k,21,rtmp)
    @. tmp = @muladd uprev+dt*(a2201*k[1]+a2208*k[8]+a2209*k[9]+a2210*k[10]+a2211*k[11]+a2212*k[12]+a2213*k[13]+a2214*k[14]+a2215*k[15]+a2217*k[17]+a2218*k[18]+a2219*k[19]+a2220*k[20]+a2221*k[21])
    f(t+c22*dt,tmp,rtmp); copyat_or_push!(k,22,rtmp)
    @. tmp = @muladd uprev+dt*(a2301*k[1]+a2308*k[8]+a2309*k[9]+a2310*k[10]+a2311*k[11]+a2312*k[12]+a2313*k[13]+a2314*k[14]+a2315*k[15]+a2317*k[17]+a2318*k[18]+a2319*k[19]+a2320*k[20]+a2321*k[21])
    f(t+c23*dt,tmp,rtmp); copyat_or_push!(k,23,rtmp)
    @. tmp = @muladd uprev+dt*(a2401*k[1]+a2408*k[8]+a2409*k[9]+a2410*k[10]+a2411*k[11]+a2412*k[12]+a2413*k[13]+a2414*k[14]+a2415*k[15]+a2417*k[17]+a2418*k[18]+a2419*k[19]+a2420*k[20]+a2421*k[21])
    f(t+c24*dt,tmp,rtmp); copyat_or_push!(k,24,rtmp)
    @. tmp = @muladd uprev+dt*(a2501*k[1]+a2508*k[8]+a2509*k[9]+a2510*k[10]+a2511*k[11]+a2512*k[12]+a2513*k[13]+a2514*k[14]+a2515*k[15]+a2517*k[17]+a2518*k[18]+a2519*k[19]+a2520*k[20]+a2521*k[21])
    f(t+c25*dt,tmp,rtmp); copyat_or_push!(k,25,rtmp)
    @. tmp = @muladd uprev+dt*(a2601*k[1]+a2608*k[8]+a2609*k[9]+a2610*k[10]+a2611*k[11]+a2612*k[12]+a2613*k[13]+a2614*k[14]+a2615*k[15]+a2617*k[17]+a2618*k[18]+a2619*k[19]+a2620*k[20]+a2621*k[21])
    f(t+c26*dt,tmp,rtmp); copyat_or_push!(k,26,rtmp,Val{false})
 end
  nothing
end
=#

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern6ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 9 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a94,a95,a96,a97,a98,b1,b4,b5,b6,b7,b8,b9= cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c1*dt,uprev+dt*(a21*k[1])))
    copyat_or_push!(k,3,f(t+c2*dt,uprev+dt*(a31*k[1]+a32*k[2])))
    copyat_or_push!(k,4,f(t+c3*dt,uprev+dt*(a41*k[1]       +a43*k[3])))
    copyat_or_push!(k,5,f(t+c4*dt,uprev+dt*(a51*k[1]       +a53*k[3]+a54*k[4])))
    copyat_or_push!(k,6,f(t+c5*dt,uprev+dt*(a61*k[1]       +a63*k[3]+a64*k[4]+a65*k[5])))
    copyat_or_push!(k,7,f(t+c6*dt,uprev+dt*(a71*k[1]       +a73*k[3]+a74*k[4]+a75*k[5]+a76*k[6])))
    copyat_or_push!(k,8,f(t+dt,uprev+dt*(a81*k[1]       +a83*k[3]+a84*k[4]+a85*k[5]+a86*k[6]+a87*k[7])))
    copyat_or_push!(k,9,f(t+dt,uprev+dt*(a91*k[1]+a94*k[4]+a95*k[5]+a96*k[6]+a97*k[7]+a98*k[8])))
  end
  if (calcVal2 && length(k)< 12) || calcVal3 # Have not added the extra stages yet
    @unpack c10,a1001,a1004,a1005,a1006,a1007,a1008,a1009,c11,a1101,a1102,a1103,a1104,a1105,a1106,a1107,a1108,a1109,a1110,c12,a1201,a1202,a1203,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache
    copyat_or_push!(k,10,f(t+c10*dt,uprev+dt*(a1001*k[1]+a1004*k[4]+a1005*k[5]+a1006*k[6]+a1007*k[7]+a1008*k[8]+a1009*k[9])))
    copyat_or_push!(k,11,f(t+c11*dt,uprev+dt*(a1101*k[1]+a1102*k[2]+a1103*k[3]+a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9]+a1110*k[10])))
    copyat_or_push!(k,12,f(t+c12*dt,uprev+dt*(a1201*k[1]+a1202*k[2]+a1203*k[3]+a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1210*k[10]+a1211*k[11])))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern6Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 9 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,a21,a31,a32,a41,a43,a51,a53,a54,a61,a63,a64,a65,a71,a73,a74,a75,a76,a81,a83,a84,a85,a86,a87,a91,a94,a95,a96,a97,a98,b1,b4,b5,b6,b7,b8,b9= cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,utilde,tmp,atmp = cache
    uidx = eachindex(uprev)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a21*k1[i])
    end
    f(t+c1*dt,tmp,k2)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a31*k1[i]+a32*k2[i])
    end
    f(t+c2*dt,tmp,k3)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a41*k1[i]+a43*k3[i])
    end
    f(t+c3*dt,tmp,k4)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a51*k1[i]+a53*k3[i]+a54*k4[i])
    end
    f(t+c4*dt,tmp,k5)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a61*k1[i]+a63*k3[i]+a64*k4[i]+a65*k5[i])
    end
    f(t+c5*dt,tmp,k6)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a71*k1[i]+a73*k3[i]+a74*k4[i]+a75*k5[i]+a76*k6[i])
    end
    f(t+c6*dt,tmp,k7)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a81*k1[i]+a83*k3[i]+a84*k4[i]+a85*k5[i]+a86*k6[i]+a87*k7[i])
    end
    f(t+dt,tmp,k8)
    @tight_loop_macros for i in uidx
      tmp[i]=uprev[i]+dt*(a91*k1[i]+a94*k4[i]+a95*k5[i]+a96*k6[i]+a97*k7[i]+a98*k8[i])
    end
    f(t+dt,tmp,k9)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
  end
  if (calcVal2 && length(k)< 12) || calcVal3 # Have not added the extra stages yet
    @unpack c10,a1001,a1004,a1005,a1006,a1007,a1008,a1009,c11,a1101,a1102,a1103,a1104,a1105,a1106,a1107,a1108,a1109,a1110,c12,a1201,a1202,a1203,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211 = cache.tab
    @unpack tmp = cache
    rtmp = similar(cache.k1)
    uidx = eachindex(uprev)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1001*k[1][i]+a1004*k[4][i]+a1005*k[5][i]+a1006*k[6][i]+a1007*k[7][i]+a1008*k[8][i]+a1009*k[9][i])
    end
    f(t+c10*dt,tmp,rtmp); copyat_or_push!(k,10,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1101*k[1][i]+a1102*k[2][i]+a1103*k[3][i]+a1104*k[4][i]+a1105*k[5][i]+a1106*k[6][i]+a1107*k[7][i]+a1108*k[8][i]+a1109*k[9][i]+a1110*k[10][i])
    end
    f(t+c11*dt,tmp,rtmp); copyat_or_push!(k,11,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1201*k[1][i]+a1202*k[2][i]+a1203*k[3][i]+a1204*k[4][i]+a1205*k[5][i]+a1206*k[6][i]+a1207*k[7][i]+a1208*k[8][i]+a1209*k[9][i]+a1210*k[10][i]+a1211*k[11][i])
    end
    f(t+c12*dt,tmp,rtmp); copyat_or_push!(k,12,rtmp,Val{false})
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern7ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 10 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,a021,a031,a032,a041,a043,a051,a053,a054,a061,a063,a064,a065,a071,a073,a074,a075,a076,a081,a083,a084,a085,a086,a087,a091,a093,a094,a095,a096,a097,a098,a101,a103,a104,a105,a106,a107,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat10= cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c2*dt,uprev+dt*(a021*k[1])))
    copyat_or_push!(k,3,f(t+c3*dt,uprev+dt*(a031*k[1]+a032*k[2])))
    copyat_or_push!(k,4,f(t+c4*dt,uprev+dt*(a041*k[1]       +a043*k[3])))
    copyat_or_push!(k,5,f(t+c5*dt,uprev+dt*(a051*k[1]       +a053*k[3]+a054*k[4])))
    copyat_or_push!(k,6,f(t+c6*dt,uprev+dt*(a061*k[1]       +a063*k[3]+a064*k[4]+a065*k[5])))
    copyat_or_push!(k,7,f(t+c7*dt,uprev+dt*(a071*k[1]       +a073*k[3]+a074*k[4]+a075*k[5]+a076*k[6])))
    copyat_or_push!(k,8,f(t+c8*dt,uprev+dt*(a081*k[1]       +a083*k[3]+a084*k[4]+a085*k[5]+a086*k[6]+a087*k[7])))
    copyat_or_push!(k,9,f(t+dt,uprev+dt*(a091*k[1]          +a093*k[3]+a094*k[4]+a095*k[5]+a096*k[6]+a097*k[7]+a098*k[8])))
    copyat_or_push!(k,10,f(t+dt,uprev+dt*(a101*k[1]          +a103*k[3]+a104*k[4]+a105*k[5]+a106*k[6]+a107*k[7])))
  end
  if (calcVal2 && length(k)< 16) || calcVal3 # Have not added the extra stages yet
    @unpack c11,a1101,a1104,a1105,a1106,a1107,a1108,a1109,c12,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1211,c13,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1311,a1312,c14,a1401,a1404,a1405,a1406,a1407,a1408,a1409,a1411,a1412,a1413,c15,a1501,a1504,a1505,a1506,a1507,a1508,a1509,a1511,a1512,a1513,c16,a1601,a1604,a1605,a1606,a1607,a1608,a1609,a1611,a1612,a1613 = cache
    copyat_or_push!(k,11,f(t+c11*dt,uprev+dt*(a1101*k[1]+a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9])))
    copyat_or_push!(k,12,f(t+c12*dt,uprev+dt*(a1201*k[1]+a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1211*k[11])))
    copyat_or_push!(k,13,f(t+c13*dt,uprev+dt*(a1301*k[1]+a1304*k[4]+a1305*k[5]+a1306*k[6]+a1307*k[7]+a1308*k[8]+a1309*k[9]+a1311*k[11]+a1312*k[12])))
    copyat_or_push!(k,14,f(t+c14*dt,uprev+dt*(a1401*k[1]+a1404*k[4]+a1405*k[5]+a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1411*k[11]+a1412*k[12]+a1413*k[13])))
    copyat_or_push!(k,15,f(t+c15*dt,uprev+dt*(a1501*k[1]+a1504*k[4]+a1505*k[5]+a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1511*k[11]+a1512*k[12]+a1513*k[13])))
    copyat_or_push!(k,16,f(t+c16*dt,uprev+dt*(a1601*k[1]+a1604*k[4]+a1605*k[5]+a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1611*k[11]+a1612*k[12]+a1613*k[13])))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern7Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 10 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,a021,a031,a032,a041,a043,a051,a053,a054,a061,a063,a064,a065,a071,a073,a074,a075,a076,a081,a083,a084,a085,a086,a087,a091,a093,a094,a095,a096,a097,a098,a101,a103,a104,a105,a106,a107,b1,b4,b5,b6,b7,b8,b9,bhat1,bhat4,bhat5,bhat6,bhat7,bhat10= cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,update,utilde,tmp,atmp = cache
    uidx = eachindex(uprev)
    f(t,uprev,k1)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a021*k1[i])
    end
    f(t+c2*dt,tmp,k2)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a031*k1[i]+a032*k2[i])
    end
    f(t+c3*dt,tmp,k3)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a041*k1[i]+a043*k3[i])
    end
    f(t+c4*dt,tmp,k4)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a051*k1[i]+a053*k3[i]+a054*k4[i])
    end
    f(t+c5*dt,tmp,k5)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a061*k1[i]+a063*k3[i]+a064*k4[i]+a065*k5[i])
    end
    f(t+c6*dt,tmp,k6)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a071*k1[i]+a073*k3[i]+a074*k4[i]+a075*k5[i]+a076*k6[i])
    end
    f(t+c7*dt,tmp,k7)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a081*k1[i]+a083*k3[i]+a084*k4[i]+a085*k5[i]+a086*k6[i]+a087*k7[i])
    end
    f(t+c8*dt,tmp,k8)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a091*k1[i]+a093*k3[i]+a094*k4[i]+a095*k5[i]+a096*k6[i]+a097*k7[i]+a098*k8[i])
    end
    f(t+dt,tmp,k9)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a101*k1[i]+a103*k3[i]+a104*k4[i]+a105*k5[i]+a106*k6[i]+a107*k7[i])
    end
    f(t+dt,tmp,k10)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
    copyat_or_push!(k,10,k10)
  end
  if (calcVal2 && length(k)< 16) || calcVal3 # Have not added the extra stages yet
    @unpack tmp = cache
    rtmp = similar(cache.k1)
    @unpack c11,a1101,a1104,a1105,a1106,a1107,a1108,a1109,c12,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1211,c13,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1311,a1312,c14,a1401,a1404,a1405,a1406,a1407,a1408,a1409,a1411,a1412,a1413,c15,a1501,a1504,a1505,a1506,a1507,a1508,a1509,a1511,a1512,a1513,c16,a1601,a1604,a1605,a1606,a1607,a1608,a1609,a1611,a1612,a1613 = cache.tab
    uidx = eachindex(uprev)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1101*k[1][i]+a1104*k[4][i]+a1105*k[5][i]+a1106*k[6][i]+a1107*k[7][i]+a1108*k[8][i]+a1109*k[9][i])
    end
    f(t+c11*dt,tmp,rtmp); copyat_or_push!(k,11,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1201*k[1][i]+a1204*k[4][i]+a1205*k[5][i]+a1206*k[6][i]+a1207*k[7][i]+a1208*k[8][i]+a1209*k[9][i]+a1211*k[11][i])
    end
    f(t+c12*dt,tmp,rtmp); copyat_or_push!(k,12,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1301*k[1][i]+a1304*k[4][i]+a1305*k[5][i]+a1306*k[6][i]+a1307*k[7][i]+a1308*k[8][i]+a1309*k[9][i]+a1311*k[11][i]+a1312*k[12][i])
    end
    f(t+c13*dt,tmp,rtmp); copyat_or_push!(k,13,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1401*k[1][i]+a1404*k[4][i]+a1405*k[5][i]+a1406*k[6][i]+a1407*k[7][i]+a1408*k[8][i]+a1409*k[9][i]+a1411*k[11][i]+a1412*k[12][i]+a1413*k[13][i])
    end
    f(t+c14*dt,tmp,rtmp); copyat_or_push!(k,14,rtmp)
    @tight_loop_macros for i in uidx
      tmp[i]=  uprev[i]+dt*(a1501*k[1][i]+a1504*k[4][i]+a1505*k[5][i]+a1506*k[6][i]+a1507*k[7][i]+a1508*k[8][i]+a1509*k[9][i]+a1511*k[11][i]+a1512*k[12][i]+a1513*k[13][i])
    end
    f(t+c15*dt,tmp,rtmp); copyat_or_push!(k,15,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1601*k[1][i]+a1604*k[4][i]+a1605*k[5][i]+a1606*k[6][i]+a1607*k[7][i]+a1608*k[8][i]+a1609*k[9][i]+a1611*k[11][i]+a1612*k[12][i]+a1613*k[13][i])
    end
    f(t+c16*dt,tmp,rtmp); copyat_or_push!(k,16,rtmp,Val{false})
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern8ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) <13 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13 = cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c2*dt ,uprev+dt*(a0201*k[1])))
    copyat_or_push!(k,3,f(t+c3*dt ,uprev+dt*(a0301*k[1]+a0302*k[2])))
    copyat_or_push!(k,4,f(t+c4*dt ,uprev+dt*(a0401*k[1]       +a0403*k[3])))
    copyat_or_push!(k,5,f(t+c5*dt ,uprev+dt*(a0501*k[1]       +a0503*k[3]+a0504*k[4])))
    copyat_or_push!(k,6,f(t+c6*dt ,uprev+dt*(a0601*k[1]                +a0604*k[4]+a0605*k[5])))
    copyat_or_push!(k,7,f(t+c7*dt ,uprev+dt*(a0701*k[1]                +a0704*k[4]+a0705*k[5]+a0706*k[6])))
    copyat_or_push!(k,8,f(t+c8*dt ,uprev+dt*(a0801*k[1]                +a0804*k[4]+a0805*k[5]+a0806*k[6]+a0807*k[7])))
    copyat_or_push!(k,9,f(t+c9*dt ,uprev+dt*(a0901*k[1]                +a0904*k[4]+a0905*k[5]+a0906*k[6]+a0907*k[7]+a0908*k[8])))
    copyat_or_push!(k,10,f(t+c10*dt,uprev+dt*(a1001*k[1]                +a1004*k[4]+a1005*k[5]+a1006*k[6]+a1007*k[7]+a1008*k[8]+a1009*k[9])))
    copyat_or_push!(k,11,f(t+c11*dt,uprev+dt*(a1101*k[1]                +a1104*k[4]+a1105*k[5]+a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9]+a1110*k[10])))
    copyat_or_push!(k,12,f(t+    dt,uprev+dt*(a1201*k[1]                +a1204*k[4]+a1205*k[5]+a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1210*k[10]+a1211*k[11])))
    copyat_or_push!(k,13,f(t+    dt,uprev+dt*(a1301*k[1]                +a1304*k[4]+a1305*k[5]+a1306*k[6]+a1307*k[7]+a1308*k[8]+a1309*k[9]+a1310*k[10])))
  end
  if (calcVal2 && length(k)< 21) || calcVal3 # Have not added the extra stages yet
    @unpack c14,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,c15,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1514,c16,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1614,a1615,c17,a1701,a1706,a1707,a1708,a1709,a1710,a1711,a1712,a1714,a1715,a1716,c18,a1801,a1806,a1807,a1808,a1809,a1810,a1811,a1812,a1814,a1815,a1816,a1817,c19,a1901,a1906,a1907,a1908,a1909,a1910,a1911,a1912,a1914,a1915,a1916,a1917,c20,a2001,a2006,a2007,a2008,a2009,a2010,a2011,a2012,a2014,a2015,a2016,a2017,c21,a2101,a2106,a2107,a2108,a2109,a2110,a2111,a2112,a2114,a2115,a2116,a2117 = cache
    copyat_or_push!(k,14,f(t+c14*dt,uprev+dt*(a1401*k[1]+a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1410*k[10]+a1411*k[11]+a1412*k[12])))
    copyat_or_push!(k,15,f(t+c15*dt,uprev+dt*(a1501*k[1]+a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1510*k[10]+a1511*k[11]+a1512*k[12]+a1514*k[14])))
    copyat_or_push!(k,16,f(t+c16*dt,uprev+dt*(a1601*k[1]+a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1610*k[10]+a1611*k[11]+a1612*k[12]+a1614*k[14]+a1615*k[15])))
    copyat_or_push!(k,17,f(t+c17*dt,uprev+dt*(a1701*k[1]+a1706*k[6]+a1707*k[7]+a1708*k[8]+a1709*k[9]+a1710*k[10]+a1711*k[11]+a1712*k[12]+a1714*k[14]+a1715*k[15]+a1716*k[16])))
    copyat_or_push!(k,18,f(t+c18*dt,uprev+dt*(a1801*k[1]+a1806*k[6]+a1807*k[7]+a1808*k[8]+a1809*k[9]+a1810*k[10]+a1811*k[11]+a1812*k[12]+a1814*k[14]+a1815*k[15]+a1816*k[16]+a1817*k[17])))
    copyat_or_push!(k,19,f(t+c19*dt,uprev+dt*(a1901*k[1]+a1906*k[6]+a1907*k[7]+a1908*k[8]+a1909*k[9]+a1910*k[10]+a1911*k[11]+a1912*k[12]+a1914*k[14]+a1915*k[15]+a1916*k[16]+a1917*k[17])))
    copyat_or_push!(k,20,f(t+c20*dt,uprev+dt*(a2001*k[1]+a2006*k[6]+a2007*k[7]+a2008*k[8]+a2009*k[9]+a2010*k[10]+a2011*k[11]+a2012*k[12]+a2014*k[14]+a2015*k[15]+a2016*k[16]+a2017*k[17])))
    copyat_or_push!(k,21,f(t+c21*dt,uprev+dt*(a2101*k[1]+a2106*k[6]+a2107*k[7]+a2108*k[8]+a2109*k[9]+a2110*k[10]+a2111*k[11]+a2112*k[12]+a2114*k[14]+a2115*k[15]+a2116*k[16]+a2117*k[17])))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern8Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) <13 || calcVal
    @unpack c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0804,a0805,a0806,a0807,a0901,a0904,a0905,a0906,a0907,a0908,a1001,a1004,a1005,a1006,a1007,a1008,a1009,a1101,a1104,a1105,a1106,a1107,a1108,a1109,a1110,a1201,a1204,a1205,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1304,a1305,a1306,a1307,a1308,a1309,a1310,b1,b6,b7,b8,b9,b10,b11,b12,bhat1,bhat6,bhat7,bhat8,bhat9,bhat10,bhat13= cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,utilde,update,tmp,atmp = cache
    uidx = eachindex(uprev)
    f(t,uprev,k1)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0201*k1[i])
    end
    f(t+c2*dt,tmp,k2)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0301*k1[i]+a0302*k2[i])
    end
    f(t+c3*dt,tmp,k3)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0401*k1[i]+a0403*k3[i])
    end
    f(t+c4*dt,tmp,k4)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0501*k1[i]+a0503*k3[i]+a0504*k4[i])
    end
    f(t+c5*dt,tmp,k5)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0601*k1[i]+a0604*k4[i]+a0605*k5[i])
    end
    f(t+c6*dt,tmp,k6)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0701*k1[i]+a0704*k4[i]+a0705*k5[i]+a0706*k6[i])
    end
    f(t+c7*dt,tmp,k7)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0801*k1[i]+a0804*k4[i]+a0805*k5[i]+a0806*k6[i]+a0807*k7[i])
    end
    f(t+c8*dt,tmp,k8)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0901*k1[i]+a0904*k4[i]+a0905*k5[i]+a0906*k6[i]+a0907*k7[i]+a0908*k8[i])
    end
    f(t+c9*dt,tmp,k9)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1001*k1[i]+a1004*k4[i]+a1005*k5[i]+a1006*k6[i]+a1007*k7[i]+a1008*k8[i]+a1009*k9[i])
    end
    f(t+c10*dt,tmp,k10)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1101*k1[i]+a1104*k4[i]+a1105*k5[i]+a1106*k6[i]+a1107*k7[i]+a1108*k8[i]+a1109*k9[i]+a1110*k10[i])
    end
    f(t+c11*dt,tmp,k11)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1201*k1[i]+a1204*k4[i]+a1205*k5[i]+a1206*k6[i]+a1207*k7[i]+a1208*k8[i]+a1209*k9[i]+a1210*k10[i]+a1211*k11[i])
    end
    f(t+dt,tmp,k12)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1301*k1[i]+a1304*k4[i]+a1305*k5[i]+a1306*k6[i]+a1307*k7[i]+a1308*k8[i]+a1309*k9[i]+a1310*k10[i])
    end
    f(t+dt,tmp,k13)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
    copyat_or_push!(k,10,k10)
    copyat_or_push!(k,11,k11)
    copyat_or_push!(k,12,k12)
    copyat_or_push!(k,13,k13)
  end
  if (calcVal2 && length(k)< 21) || calcVal3 # Have not added the extra stages yet
    rtmp = similar(cache.k1)
    uidx = eachindex(uprev)
    @unpack c14,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,c15,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1514,c16,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1614,a1615,c17,a1701,a1706,a1707,a1708,a1709,a1710,a1711,a1712,a1714,a1715,a1716,c18,a1801,a1806,a1807,a1808,a1809,a1810,a1811,a1812,a1814,a1815,a1816,a1817,c19,a1901,a1906,a1907,a1908,a1909,a1910,a1911,a1912,a1914,a1915,a1916,a1917,c20,a2001,a2006,a2007,a2008,a2009,a2010,a2011,a2012,a2014,a2015,a2016,a2017,c21,a2101,a2106,a2107,a2108,a2109,a2110,a2111,a2112,a2114,a2115,a2116,a2117 = cache.tab
    @unpack tmp = cache
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1401*k[1][i]+a1406*k[6][i]+a1407*k[7][i]+a1408*k[8][i]+a1409*k[9][i]+a1410*k[10][i]+a1411*k[11][i]+a1412*k[12][i])
    end
    f(t+c14*dt,tmp,rtmp); copyat_or_push!(k,14,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1501*k[1][i]+a1506*k[6][i]+a1507*k[7][i]+a1508*k[8][i]+a1509*k[9][i]+a1510*k[10][i]+a1511*k[11][i]+a1512*k[12][i]+a1514*k[14][i])
    end
    f(t+c15*dt,tmp,rtmp); copyat_or_push!(k,15,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1601*k[1][i]+a1606*k[6][i]+a1607*k[7][i]+a1608*k[8][i]+a1609*k[9][i]+a1610*k[10][i]+a1611*k[11][i]+a1612*k[12][i]+a1614*k[14][i]+a1615*k[15][i])
    end
    f(t+c16*dt,tmp,rtmp); copyat_or_push!(k,16,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1701*k[1][i]+a1706*k[6][i]+a1707*k[7][i]+a1708*k[8][i]+a1709*k[9][i]+a1710*k[10][i]+a1711*k[11][i]+a1712*k[12][i]+a1714*k[14][i]+a1715*k[15][i]+a1716*k[16][i])
    end
    f(t+c17*dt,tmp,rtmp); copyat_or_push!(k,17,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1801*k[1][i]+a1806*k[6][i]+a1807*k[7][i]+a1808*k[8][i]+a1809*k[9][i]+a1810*k[10][i]+a1811*k[11][i]+a1812*k[12][i]+a1814*k[14][i]+a1815*k[15][i]+a1816*k[16][i]+a1817*k[17][i])
    end
    f(t+c18*dt,tmp,rtmp); copyat_or_push!(k,18,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1901*k[1][i]+a1906*k[6][i]+a1907*k[7][i]+a1908*k[8][i]+a1909*k[9][i]+a1910*k[10][i]+a1911*k[11][i]+a1912*k[12][i]+a1914*k[14][i]+a1915*k[15][i]+a1916*k[16][i]+a1917*k[17][i])
    end
    f(t+c19*dt,tmp,rtmp); copyat_or_push!(k,19,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2001*k[1][i]+a2006*k[6][i]+a2007*k[7][i]+a2008*k[8][i]+a2009*k[9][i]+a2010*k[10][i]+a2011*k[11][i]+a2012*k[12][i]+a2014*k[14][i]+a2015*k[15][i]+a2016*k[16][i]+a2017*k[17][i])
    end
    f(t+c20*dt,tmp,rtmp); copyat_or_push!(k,20,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2101*k[1][i]+a2106*k[6][i]+a2107*k[7][i]+a2108*k[8][i]+a2109*k[9][i]+a2110*k[10][i]+a2111*k[11][i]+a2112*k[12][i]+a2114*k[14][i]+a2115*k[15][i]+a2116*k[16][i]+a2117*k[17][i])
    end
    f(t+c21*dt,tmp,rtmp); copyat_or_push!(k,21,rtmp,Val{false})
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern9ConstantCache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if (length(k) < 16 || calcVal) || ((calcVal2 && length(k)< 26) || calcVal3)
  end
  if length(k) < 16 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0806,a0807,a0901,a0906,a0907,a0908,a1001,a1006,a1007,a1008,a1009,a1101,a1106,a1107,a1108,a1109,a1110,a1201,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1306,a1307,a1308,a1309,a1310,a1311,a1312,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1613,b1,b8,b9,b10,b11,b12,b13,b14,b15,bhat1,bhat8,bhat9,bhat10,bhat11,bhat12,bhat13,bhat16 = cache
    copyat_or_push!(k,1,f(t,uprev))
    copyat_or_push!(k,2,f(t+c1*dt,uprev+dt*(a0201*k[1])))
    copyat_or_push!(k,3,f(t+c2*dt,uprev+dt*(a0301*k[1]+a0302*k[2])))
    copyat_or_push!(k,4,f(t+c3*dt,uprev+dt*(a0401*k[1]       +a0403*k[3])))
    copyat_or_push!(k,5,f(t+c4*dt,uprev+dt*(a0501*k[1]       +a0503*k[3]+a0504*k[4])))
    copyat_or_push!(k,6,f(t+c5*dt,uprev+dt*(a0601*k[1]                +a0604*k[4]+a0605*k[5])))
    copyat_or_push!(k,7,f(t+c6*dt,uprev+dt*(a0701*k[1]                +a0704*k[4]+a0705*k[5]+a0706*k[6])))
    copyat_or_push!(k,8,f(t+c7*dt,uprev+dt*(a0801*k[1]                                  +a0806*k[6]+a0807*k[7])))
    copyat_or_push!(k,9,f(t+c8*dt,uprev+dt*(a0901*k[1]                                  +a0906*k[6]+a0907*k[7]+a0908*k[8])))
    copyat_or_push!(k,10,f(t+c9*dt,uprev+dt*(a1001*k[1]                                  +a1006*k[6]+a1007*k[7]+a1008*k[8]+a1009*k[9])))
    copyat_or_push!(k,11,f(t+c10*dt,uprev+dt*(a1101*k[1]                                  +a1106*k[6]+a1107*k[7]+a1108*k[8]+a1109*k[9]+a1110*k[10])))
    copyat_or_push!(k,12,f(t+c11*dt,uprev+dt*(a1201*k[1]                                  +a1206*k[6]+a1207*k[7]+a1208*k[8]+a1209*k[9]+a1210*k[10]+a1211*k[11])))
    copyat_or_push!(k,13,f(t+c12*dt,uprev+dt*(a1301*k[1]                                  +a1306*k[6]+a1307*k[7]+a1308*k[8]+a1309*k[9]+a1310*k[10]+a1311*k[11]+a1312*k[12])))
    copyat_or_push!(k,14,f(t+c13*dt,uprev+dt*(a1401*k[1]                                  +a1406*k[6]+a1407*k[7]+a1408*k[8]+a1409*k[9]+a1410*k[10]+a1411*k[11]+a1412*k[12]+a1413*k[13])))
    copyat_or_push!(k,15,f(t+dt,uprev+dt*(a1501*k[1]                                  +a1506*k[6]+a1507*k[7]+a1508*k[8]+a1509*k[9]+a1510*k[10]+a1511*k[11]+a1512*k[12]+a1513*k[13]+a1514*k[14])))
    copyat_or_push!(k,16,f(t+dt,uprev+dt*(a1601*k[1]                                  +a1606*k[6]+a1607*k[7]+a1608*k[8]+a1609*k[9]+a1610*k[10]+a1611*k[11]+a1612*k[12]+a1613*k[13])))
  end
  if (calcVal2 && length(k)< 26) || calcVal3 # Have not added the extra stages yet
    @unpack c17,a1701,a1708,a1709,a1710,a1711,a1712,a1713,a1714,a1715,c18,a1801,a1808,a1809,a1810,a1811,a1812,a1813,a1814,a1815,a1817,c19,a1901,a1908,a1909,a1910,a1911,a1912,a1913,a1914,a1915,a1917,a1918,c20,a2001,a2008,a2009,a2010,a2011,a2012,a2013,a2014,a2015,a2017,a2018,a2019,c21,a2101,a2108,a2109,a2110,a2111,a2112,a2113,a2114,a2115,a2117,a2118,a2119,a2120,c22,a2201,a2208,a2209,a2210,a2211,a2212,a2213,a2214,a2215,a2217,a2218,a2219,a2220,a2221,c23,a2301,a2308,a2309,a2310,a2311,a2312,a2313,a2314,a2315,a2317,a2318,a2319,a2320,a2321,c24,a2401,a2408,a2409,a2410,a2411,a2412,a2413,a2414,a2415,a2417,a2418,a2419,a2420,a2421,c25,a2501,a2508,a2509,a2510,a2511,a2512,a2513,a2514,a2515,a2517,a2518,a2519,a2520,a2521,c26,a2601,a2608,a2609,a2610,a2611,a2612,a2613,a2614,a2615,a2617,a2618,a2619,a2620,a2621 = cache
    copyat_or_push!(k,17,f(t+c17*dt,uprev+dt*(a1701*k[1]+a1708*k[8]+a1709*k[9]+a1710*k[10]+a1711*k[11]+a1712*k[12]+a1713*k[13]+a1714*k[14]+a1715*k[15])))
    copyat_or_push!(k,18,f(t+c18*dt,uprev+dt*(a1801*k[1]+a1808*k[8]+a1809*k[9]+a1810*k[10]+a1811*k[11]+a1812*k[12]+a1813*k[13]+a1814*k[14]+a1815*k[15]+a1817*k[17])))
    copyat_or_push!(k,19,f(t+c19*dt,uprev+dt*(a1901*k[1]+a1908*k[8]+a1909*k[9]+a1910*k[10]+a1911*k[11]+a1912*k[12]+a1913*k[13]+a1914*k[14]+a1915*k[15]+a1917*k[17]+a1918*k[18])))
    copyat_or_push!(k,20,f(t+c20*dt,uprev+dt*(a2001*k[1]+a2008*k[8]+a2009*k[9]+a2010*k[10]+a2011*k[11]+a2012*k[12]+a2013*k[13]+a2014*k[14]+a2015*k[15]+a2017*k[17]+a2018*k[18]+a2019*k[19])))
    copyat_or_push!(k,21,f(t+c21*dt,uprev+dt*(a2101*k[1]+a2108*k[8]+a2109*k[9]+a2110*k[10]+a2111*k[11]+a2112*k[12]+a2113*k[13]+a2114*k[14]+a2115*k[15]+a2117*k[17]+a2118*k[18]+a2119*k[19]+a2120*k[20])))
    copyat_or_push!(k,22,f(t+c22*dt,uprev+dt*(a2201*k[1]+a2208*k[8]+a2209*k[9]+a2210*k[10]+a2211*k[11]+a2212*k[12]+a2213*k[13]+a2214*k[14]+a2215*k[15]+a2217*k[17]+a2218*k[18]+a2219*k[19]+a2220*k[20]+a2221*k[21])))
    copyat_or_push!(k,23,f(t+c23*dt,uprev+dt*(a2301*k[1]+a2308*k[8]+a2309*k[9]+a2310*k[10]+a2311*k[11]+a2312*k[12]+a2313*k[13]+a2314*k[14]+a2315*k[15]+a2317*k[17]+a2318*k[18]+a2319*k[19]+a2320*k[20]+a2321*k[21])))
    copyat_or_push!(k,24,f(t+c24*dt,uprev+dt*(a2401*k[1]+a2408*k[8]+a2409*k[9]+a2410*k[10]+a2411*k[11]+a2412*k[12]+a2413*k[13]+a2414*k[14]+a2415*k[15]+a2417*k[17]+a2418*k[18]+a2419*k[19]+a2420*k[20]+a2421*k[21])))
    copyat_or_push!(k,25,f(t+c25*dt,uprev+dt*(a2501*k[1]+a2508*k[8]+a2509*k[9]+a2510*k[10]+a2511*k[11]+a2512*k[12]+a2513*k[13]+a2514*k[14]+a2515*k[15]+a2517*k[17]+a2518*k[18]+a2519*k[19]+a2520*k[20]+a2521*k[21])))
    copyat_or_push!(k,26,f(t+c26*dt,uprev+dt*(a2601*k[1]+a2608*k[8]+a2609*k[9]+a2610*k[10]+a2611*k[11]+a2612*k[12]+a2613*k[13]+a2614*k[14]+a2615*k[15]+a2617*k[17]+a2618*k[18]+a2619*k[19]+a2620*k[20]+a2621*k[21])))
  end
  nothing
end

"""

"""
function ode_addsteps!{calcVal,calcVal2,calcVal3}(k,t,uprev,u,dt,f,cache::Vern9Cache,always_calc_begin::Type{Val{calcVal}} = Val{false},allow_calc_end::Type{Val{calcVal2}} = Val{true},force_calc_end::Type{Val{calcVal3}} = Val{false})
  if length(k) < 16 || calcVal
    @unpack c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,a0201,a0301,a0302,a0401,a0403,a0501,a0503,a0504,a0601,a0604,a0605,a0701,a0704,a0705,a0706,a0801,a0806,a0807,a0901,a0906,a0907,a0908,a1001,a1006,a1007,a1008,a1009,a1101,a1106,a1107,a1108,a1109,a1110,a1201,a1206,a1207,a1208,a1209,a1210,a1211,a1301,a1306,a1307,a1308,a1309,a1310,a1311,a1312,a1401,a1406,a1407,a1408,a1409,a1410,a1411,a1412,a1413,a1501,a1506,a1507,a1508,a1509,a1510,a1511,a1512,a1513,a1514,a1601,a1606,a1607,a1608,a1609,a1610,a1611,a1612,a1613,b1,b8,b9,b10,b11,b12,b13,b14,b15,bhat1,bhat8,bhat9,bhat10,bhat11,bhat12,bhat13,bhat16 = cache.tab
    @unpack k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,utilde,update,tmp,atmp = cache
    uidx = eachindex(uprev)
    f(t,uprev,k1)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0201*k1[i])
    end
    f(t+c1*dt,tmp,k2)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0301*k1[i]+a0302*k2[i])
    end
    f(t+c2*dt,tmp,k3)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0401*k1[i]+a0403*k3[i])
    end
    f(t+c3*dt,tmp,k4)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0501*k1[i]+a0503*k3[i]+a0504*k4[i])
    end
    f(t+c4*dt,tmp,k5)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0601*k1[i]+a0604*k4[i]+a0605*k5[i])
    end
    f(t+c5*dt,tmp,k6)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0701*k1[i]+a0704*k4[i]+a0705*k5[i]+a0706*k6[i])
    end
    f(t+c6*dt,tmp,k7)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0801*k1[i]+a0806*k6[i]+a0807*k7[i])
    end
    f(t+c7*dt,tmp,k8)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a0901*k1[i]+a0906*k6[i]+a0907*k7[i]+a0908*k8[i])
    end
    f(t+c8*dt,tmp,k9)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1001*k1[i]+a1006*k6[i]+a1007*k7[i]+a1008*k8[i]+a1009*k9[i])
    end
    f(t+c9*dt,tmp,k10)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1101*k1[i]+a1106*k6[i]+a1107*k7[i]+a1108*k8[i]+a1109*k9[i]+a1110*k10[i])
    end
    f(t+c10*dt,tmp,k11)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1201*k1[i]+a1206*k6[i]+a1207*k7[i]+a1208*k8[i]+a1209*k9[i]+a1210*k10[i]+a1211*k11[i])
    end
    f(t+c11*dt,tmp,k12)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1301*k1[i]+a1306*k6[i]+a1307*k7[i]+a1308*k8[i]+a1309*k9[i]+a1310*k10[i]+a1311*k11[i]+a1312*k12[i])
    end
    f(t+c12*dt,tmp,k13)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1401*k1[i]+a1406*k6[i]+a1407*k7[i]+a1408*k8[i]+a1409*k9[i]+a1410*k10[i]+a1411*k11[i]+a1412*k12[i]+a1413*k13[i])
    end
    f(t+c13*dt,tmp,k14)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1501*k1[i]+a1506*k6[i]+a1507*k7[i]+a1508*k8[i]+a1509*k9[i]+a1510*k10[i]+a1511*k11[i]+a1512*k12[i]+a1513*k13[i]+a1514*k14[i])
    end
    f(t+dt,tmp,k15)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1601*k1[i]+a1606*k6[i]+a1607*k7[i]+a1608*k8[i]+a1609*k9[i]+a1610*k10[i]+a1611*k11[i]+a1612*k12[i]+a1613*k13[i])
    end
    f(t+dt,tmp,k16)
    copyat_or_push!(k,1,k1)
    copyat_or_push!(k,2,k2)
    copyat_or_push!(k,3,k3)
    copyat_or_push!(k,4,k4)
    copyat_or_push!(k,5,k5)
    copyat_or_push!(k,6,k6)
    copyat_or_push!(k,7,k7)
    copyat_or_push!(k,8,k8)
    copyat_or_push!(k,9,k9)
    copyat_or_push!(k,10,k10)
    copyat_or_push!(k,11,k11)
    copyat_or_push!(k,12,k12)
    copyat_or_push!(k,13,k13)
    copyat_or_push!(k,14,k14)
    copyat_or_push!(k,15,k15)
    copyat_or_push!(k,16,k16)
  end
  if (calcVal2 && length(k)< 26) || calcVal3 # Have not added the extra stages yet
    rtmp = similar(cache.k1)
    uidx = eachindex(uprev)
    @unpack tmp = cache
    @unpack c17,a1701,a1708,a1709,a1710,a1711,a1712,a1713,a1714,a1715,c18,a1801,a1808,a1809,a1810,a1811,a1812,a1813,a1814,a1815,a1817,c19,a1901,a1908,a1909,a1910,a1911,a1912,a1913,a1914,a1915,a1917,a1918,c20,a2001,a2008,a2009,a2010,a2011,a2012,a2013,a2014,a2015,a2017,a2018,a2019,c21,a2101,a2108,a2109,a2110,a2111,a2112,a2113,a2114,a2115,a2117,a2118,a2119,a2120,c22,a2201,a2208,a2209,a2210,a2211,a2212,a2213,a2214,a2215,a2217,a2218,a2219,a2220,a2221,c23,a2301,a2308,a2309,a2310,a2311,a2312,a2313,a2314,a2315,a2317,a2318,a2319,a2320,a2321,c24,a2401,a2408,a2409,a2410,a2411,a2412,a2413,a2414,a2415,a2417,a2418,a2419,a2420,a2421,c25,a2501,a2508,a2509,a2510,a2511,a2512,a2513,a2514,a2515,a2517,a2518,a2519,a2520,a2521,c26,a2601,a2608,a2609,a2610,a2611,a2612,a2613,a2614,a2615,a2617,a2618,a2619,a2620,a2621 = cache.tab
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1701*k[1][i]+a1708*k[8][i]+a1709*k[9][i]+a1710*k[10][i]+a1711*k[11][i]+a1712*k[12][i]+a1713*k[13][i]+a1714*k[14][i]+a1715*k[15][i])
    end
    f(t+c17*dt,tmp,rtmp); copyat_or_push!(k,17,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1801*k[1][i]+a1808*k[8][i]+a1809*k[9][i]+a1810*k[10][i]+a1811*k[11][i]+a1812*k[12][i]+a1813*k[13][i]+a1814*k[14][i]+a1815*k[15][i]+a1817*k[17][i])
    end
    f(t+c18*dt,tmp,rtmp); copyat_or_push!(k,18,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a1901*k[1][i]+a1908*k[8][i]+a1909*k[9][i]+a1910*k[10][i]+a1911*k[11][i]+a1912*k[12][i]+a1913*k[13][i]+a1914*k[14][i]+a1915*k[15][i]+a1917*k[17][i]+a1918*k[18][i])
    end
    f(t+c19*dt,tmp,rtmp); copyat_or_push!(k,19,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2001*k[1][i]+a2008*k[8][i]+a2009*k[9][i]+a2010*k[10][i]+a2011*k[11][i]+a2012*k[12][i]+a2013*k[13][i]+a2014*k[14][i]+a2015*k[15][i]+a2017*k[17][i]+a2018*k[18][i]+a2019*k[19][i])
    end
    f(t+c20*dt,tmp,rtmp); copyat_or_push!(k,20,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2101*k[1][i]+a2108*k[8][i]+a2109*k[9][i]+a2110*k[10][i]+a2111*k[11][i]+a2112*k[12][i]+a2113*k[13][i]+a2114*k[14][i]+a2115*k[15][i]+a2117*k[17][i]+a2118*k[18][i]+a2119*k[19][i]+a2120*k[20][i])
    end
    f(t+c21*dt,tmp,rtmp); copyat_or_push!(k,21,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2201*k[1][i]+a2208*k[8][i]+a2209*k[9][i]+a2210*k[10][i]+a2211*k[11][i]+a2212*k[12][i]+a2213*k[13][i]+a2214*k[14][i]+a2215*k[15][i]+a2217*k[17][i]+a2218*k[18][i]+a2219*k[19][i]+a2220*k[20][i]+a2221*k[21][i])
    end
    f(t+c22*dt,tmp,rtmp); copyat_or_push!(k,22,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2301*k[1][i]+a2308*k[8][i]+a2309*k[9][i]+a2310*k[10][i]+a2311*k[11][i]+a2312*k[12][i]+a2313*k[13][i]+a2314*k[14][i]+a2315*k[15][i]+a2317*k[17][i]+a2318*k[18][i]+a2319*k[19][i]+a2320*k[20][i]+a2321*k[21][i])
    end
    f(t+c23*dt,tmp,rtmp); copyat_or_push!(k,23,rtmp)
    @tight_loop_macros for i in uidx
      tmp[i]  = uprev[i]+dt*(a2401*k[1][i]+a2408*k[8][i]+a2409*k[9][i]+a2410*k[10][i]+a2411*k[11][i]+a2412*k[12][i]+a2413*k[13][i]+a2414*k[14][i]+a2415*k[15][i]+a2417*k[17][i]+a2418*k[18][i]+a2419*k[19][i]+a2420*k[20][i]+a2421*k[21][i])
    end
    f(t+c24*dt,tmp,rtmp); copyat_or_push!(k,24,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2501*k[1][i]+a2508*k[8][i]+a2509*k[9][i]+a2510*k[10][i]+a2511*k[11][i]+a2512*k[12][i]+a2513*k[13][i]+a2514*k[14][i]+a2515*k[15][i]+a2517*k[17][i]+a2518*k[18][i]+a2519*k[19][i]+a2520*k[20][i]+a2521*k[21][i])
    end
    f(t+c25*dt,tmp,rtmp); copyat_or_push!(k,25,rtmp)
    @tight_loop_macros for i in uidx
      @inbounds tmp[i] = uprev[i]+dt*(a2601*k[1][i]+a2608*k[8][i]+a2609*k[9][i]+a2610*k[10][i]+a2611*k[11][i]+a2612*k[12][i]+a2613*k[13][i]+a2614*k[14][i]+a2615*k[15][i]+a2617*k[17][i]+a2618*k[18][i]+a2619*k[19][i]+a2620*k[20][i]+a2621*k[21][i])
    end
    f(t+c26*dt,tmp,rtmp); copyat_or_push!(k,26,rtmp,Val{false})
 end
  nothing
end
