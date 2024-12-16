function[g] = func_sum_normal(m,n,a,b,K)
%sum of N Gauss noises
g = zeros([m,n],'double');
for k = 1:K
   g1 = randn(m,n);
   g1 = g1*b + a;
   g = g1 + g;
end;










