using DiffEqSensitivity, Test

function ishi(X)
    A= 7
    B= 0.1
    [sin(X[1]) + A*sin(X[2])^2+ B*sin(X[3])^4 *sin(X[1])]
end
p_range = [[0.0,1.0] for i in 1:4]
N = 60000
sobol = gsa(ishi,p_range,Sobol(N=N,order=[0,1]))

for (first_order, r_sens) in zip(sobol.S1,[0.0242498108,0.9801111059,0.0000346274,0.0000000000])
     @test first_order[1] ≈ r_sens atol=1e-2
end
for (total_order, r_sens) in zip(sobol.ST,[2.682048e-02,9.693216e-01,6.910431e-05,0.000000e+00])
    @test total_order[1] ≈ r_sens atol=1e-2
end 

######################################################################
#sobol2007(model = ishigami.fun, X1 = X1, X2 = X2, nboot = 100)

#Model runs: 600000 
#
#First order indices:
#       original          bias   std. error     min. c.i.    max. c.i.
#X1 0.0242498108 -6.038174e-05 1.130665e-03  0.0219442397 0.0266505624
#X2 0.9801111059  1.318961e-03 9.755089e-03  0.9619890024 1.0038331890
#X3 0.0000346274  1.564015e-06 7.342856e-05 -0.0001075782 0.0001843829
#X4 0.0000000000  0.000000e+00 0.000000e+00  0.0000000000 0.0000000000
#
#Total indices:
#       original          bias   std. error     min. c.i.    max. c.i.
#X1 2.682048e-02  1.087146e-04 1.177283e-03  2.462456e-02 0.0294033066
#X2 9.693216e-01 -7.482170e-04 7.634399e-03  9.550214e-01 0.9875516033
#X3 6.910431e-05  8.949816e-06 7.376054e-05 -9.023791e-05 0.0002100689
#X4 0.000000e+00  0.000000e+00 0.000000e+00  0.000000e+00 0.0000000000
######################################################################