%main_sum_normal_noise
close all
clc
    STEP = 1  %NormalNoise
m = 256; n = 256;
K = 2 % number of fields
% NORMAL FIELD
mu = 30; stdev = 30; g3 = 0; g4 = 0;
% Parameters of the initial field
Mu = K*mu; % Expectation of the Resulting field
Variance = K*stdev^2 % Variance of the Resulting field
Stdev = sqrt(Variance)
G3 = 0
G4 = 0
% Parameters of the resulting field
% rng('default');  % For reproducibility
g = func_sum_normal(m,n,mu,stdev,K); whos g;
% figure(1000), imshow(g,[]), title('SumNormalNoise');
figure(100); imagesc(g); colorbar;
title('SumNormalNoise');
gu8 = uint8(g./K);
maxgu8 = max(gu8(:)) %max value
mingu8 = min(gu8(:)) %min value
figure(101),imhist(gu8), title('SumNormalHistogram'), grid;
func_norm_hist_visual(gu8,mu,stdev,K,51); % nbins = 51
  ts = input('STOP1','s');
    STEP = 2
    M = 8 % number of sample variants
 MEAN = zeros(1,M); VAR = zeros(1,M); SIGMA = zeros(1,M);
 GAMMA1 = zeros(1,M); GAMMA3 = zeros(1,M); GAMMA4 = zeros(1,M);
 NL = [1,2,5,10,20,50,100,256]; MN = zeros(1,M);
for k = 1:M  % number of rows
   N = NL(k);
 Y = zeros(m,N);
for i = 1:m
    for j = 1:N
   Y(i,j) = g(i,j)/K;    
    end;
end;
[mean,var,sigma,gamma1,mn] = func_mean_var_calc(Y);
MEAN(k) = mean;
VAR(k) = var;
SIGMA(k) = sigma;
GAMMA1(k) = gamma1;
[skew,gamma3,kurt,gamma4,mn] = func_skew_kurt_calc(Y);
GAMMA3(k) = gamma3;
GAMMA4(k) = gamma4;
MN(k) = mn;
end;

MEAN = MEAN 
VAR = VAR
SIGMA = SIGMA
GAMMA1 = GAMMA1
GAMMA3 = GAMMA3
GAMMA4 = GAMMA4
MN = MN

    STEP = 3
    for k = 1:M
        MU(k) = Mu/K;
        SM(k) = Stdev/sqrt(K*MN(k)); 
        SM(k) = SM(k)/sqrt(K);
        D1(k) = MU(k) + SM(k);
        D2(k) = MU(k) - SM(k);
    end;  
  
 x = 256:256:M*256;
 figure(300), plot(x,MEAN,'-*'), grid
 hold on
 plot(x,Mu*ones(size(x))/K,x,D1,x,D2), 
 title('Выборочное среднее'),
 xlabel('Число выборок'), ylabel('MEAN');
 
 figure(301), plot(x,VAR,'--*'), grid 
 title('Выборочная дисперсия'),
  hold on
 plot(x,Variance*ones(size(x))/K^2), 
 xlabel('Число выборок'), ylabel('VAR');
 
 figure(302), plot(x,GAMMA3,'--o'), grid
 title('Коэф асимметрии'),
   hold on
 plot(x,G3*ones(size(x))), 
 xlabel('Число выборок'), ylabel('Gamma3');
 
 figure(303), plot(x,GAMMA4,'--h'), grid
 title('Коэф эксцесса'),
     hold on
 plot(x,G4*ones(size(x))), 
 xlabel('Число выборок'), ylabel('Gamma4');

  ts = input('STOP2','s');
    END = 0
    
   

