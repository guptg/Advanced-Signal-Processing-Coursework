%% 2.3.1 Plotting AR(2) and looking at its convergence 

%Generating the uniformly distributed coefficients in their specified range

a1 = 5*(rand(1000,1) - 0.5);
a2 = 3*(rand(1000,1) - 0.5);


a = [ones(1000,1) -a1 -a2];

%Converging coefficients 

a1c = []; 
a2c = []; 

%Non converging coefficients 

a1n = []; 
a2n = []; 

for i = 1:1000
    
    randn('state',2);  %2 produces the desired shape better than 1 for some reason 

    x = filter(1, a(i,:), randn(10000,1));
    
    if (sum(x)<Inf)  %The output of AR(2) converges is the sum of its values is less than infinity 
        a1c = [a1c a1(i)];
        a2c = [a2c a2(i)]; 
    else 
        a1n = [a1n a1(i)]; 
        a2n = [a2n a2(i)]; 
    end 
    
end 

figure(1); 

for i = 1:length(a1c)
    plot(a1c(i),a2c(i),'*', 'color', 'r');
    hold on; 
end 


for i = 1:length(a1n)
    plot(a1n(i),a2n(i),'*', 'color', 'b');
    hold on; 
end 

title('Plot of coefficient pairs for converging and non-converging AR(2) outputs');
xlabel('a1')
ylabel('a2')

%% Sunspot series 
clear all; close all; clc; 
%DO WE NORMALIZE EVERYTHING BY THE MAXIMUM PEAK?!! DONE USING COEFF INSTEAD
%OF UNBIASED, DO THIS TO SEE DC OFFSET BETTER 

% Load the real world sunspot time series4 and plot its ACFs for data lengths N = 5; 20; 250.

load sunspot.dat;

sunspot = sunspot(:,2);

ACF5 = xcorr(sunspot(1:6), 'coeff'); 
ACF20 = xcorr(sunspot(1:21), 'coeff'); 
ACF250 = xcorr(sunspot(1:251), 'coeff'); 
    
figure(2);     

subplot(3,1,1); 
stem(-5:5, ACF5); 
title('ACF estimate of sunspot time series for N = 5')
xlabel('Lag \tau')
ylabel('estimated norm. R_x(\tau)')

subplot(3,1,2); 
stem(-20:20, ACF20);
title('ACF estimate of sunspot time series for N = 20')
xlabel('Lag \tau')
ylabel('estimated norm. R_x(\tau)')

subplot(3,1,3); 
stem(-250:250, ACF250); 
title('ACF estimate of sunspot time series for N = 250')
xlabel('Lag \tau')
ylabel('estimated norm. R_x(\tau)')

% Comment on any differences in the shape of the ACFs.
% Explain the effects of the mean of the series. 

mean5 = mean(sunspot(1:6)); 
mean20 = mean(sunspot(1:21)); 
mean250 = mean(sunspot(1:251)); 

% Verify this by computing the ACF of a zero-mean version of the sunspot series and comment on the differences from the original (non-centred)signal.

%ACF of original series 

figure(3); 

%subplot(1,2,1)
ACF = xcorr(sunspot, 'coeff'); 
stem(-287:287, ACF); 
hold on; 
title('ACF estimate of sunspot time series for N = 288')
xlabel('Lag \tau')
ylabel('estimated norm. R_x(\tau)')


%ACF of zero mean series 

sample_mean = mean(sunspot); 
new_sunspot = sunspot - sample_mean; 

%subplot(1,2,2)
ACF0 = xcorr(new_sunspot, 'coeff'); 
stem(-287:287, ACF0); 
legend('non-centered data', 'centered data'); 
xlim([-288 288]);
% title('ACF estimate of zero mean sunspot time series for N = 288')
% xlabel('Lag \tau')
% ylabel('estimated R_x(\tau)')

figure(4);

ACF = xcorr(sunspot, 'coeff'); 
stem(-287:287, ACF); 
hold on; 
title('ACF estimate of sunspot time series for N = 288 zoomed')
xlabel('Lag \tau')
ylabel('estimated norm. R_x(\tau)')


%ACF of zero mean series 

sample_mean = mean(sunspot); 
new_sunspot = sunspot - sample_mean; 

%subplot(1,2,2)
ACF0 = xcorr(new_sunspot, 'coeff'); 
stem(-287:287, ACF0); 
legend('non-centered data', 'centered data'); 
xlim([-50 50]);
% title('ACF estimate of zero mean sunspot time series for N = 288')
% xlabel('Lag \tau')
% ylabel('estimated R_x(\tau)')


%% Yule-Walker 

%Use the Yule-Walker equations to calculate the partial correlation functions up until the model order p = 10

load sunspot.dat;
sunspot = sunspot(:,2);

akk = []; 

for i = 1:10
    A = aryule(sunspot, i); 
    akk = [akk A(i+1)];     %The PACs are the last elements in the array of a coefficents determined by the Y-W eqns 
end 

figure(4); 

%subplot(1,2,1);
stem(1:10, akk) 
title('Partial Autocorrelation function: orginal data');
xlabel('Lag \tau')
ylabel('PAC')


%Comment on the most likely model order of the sunspot time series
%Repeat the procedure for the sunspot series standardised to zero mean and unit variance

sample_mean = mean(sunspot);
sample_std = std(sunspot); 

new_sunspot = (sunspot - sample_mean)./sample_std; 

Nakk = []; 

for i = 1:10
    NA = aryule(new_sunspot, i); 
    Nakk = [Nakk NA(i+1)];     %The PACs are the last elements in the array of a coefficents determined by the Y-W eqns 
end 

figure(5); 
%subplot(1,2,2);
stem(1:10, Nakk) 
title('Partial Autocorrelation function: normalized data');
xlabel('Lag \tau')
ylabel('PAC')


%Explain the differences 


%% deterimining correct model order via MDL, AIC, and AICc 

clear all; close all; clc; 

load sunspot.dat;
sunspot = sunspot(:,2);
sample_mean = mean(sunspot);
sample_std = std(sunspot); 
new_sunspot = (sunspot - sample_mean)./sample_std; 

N = length(new_sunspot);

MDL = [];
AIC = [];
AICc = []; 
Error = [];


for i = 1:25
   
   [a, E] = aryule(new_sunspot, i);
   MDL = [MDL (log(E) + (i*log(N)/N))];
   AIC = [AIC (log(E) + 2*i/N)];
   
   %AICc = [AICc (AIC + (2*i*(i+1))/(N-i-1))]
   Error = [Error log(E)];
end

figure(6);
plot(MDL);
hold on;
plot(AIC, 'r');
%plot(AICc, 'b'); 
plot(Error, 'g')
legend('MDL','AIC', 'Cumulative Squared Error');
xlabel('Model Order');
ylabel('Model Error');
title('MDL, AIC and Cumulative Squared Error');

AIC = [];
AICc = []; 


for i = 1:15
   
   [a, E] = aryule(new_sunspot, i);

   AIC = [AIC (log(E) + 2*i/N)];
   x = (log(E) + 2*i/N) + (2*i*(i+1))/(N-i-1); 
   AICc = [AICc x]

end

figure(7);
plot(AICc); 
xlabel('Model Order');
ylabel('AICc');
title('Corrected AIC');

%% Predicting the sunspot time series 

clear all; close all; clc; 

load sunspot.dat;
sunspot = sunspot(:,2);
sample_mean = mean(sunspot);
sample_std = std(sunspot); 
time_series = (sunspot - sample_mean)./sample_std; 
%time_series = iddata(new_sunspot,[]); 


%Generating the AR models  
AR1 = ar(time_series,1);
AR2 = ar(time_series,2);
AR20 = ar(time_series,20);


%m = 1
P11 = predict(AR1,time_series,1);
P21 = predict(AR2,time_series,1);
P201 = predict(AR20,time_series,1);

figure(8); 

plot(P11);
hold on;
plot(P21);
plot(P201);
xlim([1 288])
plot(time_series); 
legend('AR(1)', 'AR(2)', 'AR(20)', 'Sunspot time series'); 
ylabel('Amplitude');
xlabel('sample number');
title('Prediction horizon: 1'); 


%m = 2
P12 = predict(AR1,time_series,2);
P22 = predict(AR2,time_series,2);
P202 = predict(AR20,time_series,2);

figure(9); 
plot(P12);
hold on;
plot(P22);
plot(P202);
xlim([1 288])
plot(time_series); 
legend('AR(1)', 'AR(2)', 'AR(20)', 'Sunspot time series'); 
ylabel('Amplitude');
xlabel('sample number');
title('Prediction horizon: 2'); 


%m = 5

P15 = predict(AR1,time_series,5);
P25 = predict(AR2,time_series,5);
P205 = predict(AR20,time_series,5);

figure(10); 
plot(P15);
hold on;
plot(P25);
plot(P205);
xlim([1 288])
plot(time_series); 
legend('AR(1)', 'AR(2)', 'AR(20)', 'Sunspot time series'); 
ylabel('Amplitude');
xlabel('sample number');
title('Prediction horizon:5'); 

%m = 10
P110 = predict(AR1,time_series,10);
P210 = predict(AR2,time_series,10);
P2010 = predict(AR20,time_series,10);

figure(11); 
plot(P110);
hold on;
plot(P210);
plot(P2010);
xlim([1 288])
plot(time_series); 
legend('AR(1)', 'AR(2)', 'AR(20)', 'Sunspot time series'); 
ylabel('Amplitude');
xlabel('sample number');
title('Prediction horizon: 10'); 