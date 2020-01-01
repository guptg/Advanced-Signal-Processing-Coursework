%% 2.1.1 Unbiased estimate of the ACF for WGN 

X = randn(1000, 1); %1000 sample realization of white Gaussian noise 
ACF = xcorr(X, 'unbiased'); %Estimate of the ACF 

figure(1); 
subplot(2,1,1)
stem(-999:999, ACF); 
title('Unbiased estimate of the ACF of a 1000-sample realisation of WGN')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')

%Uncorrelated smples due to the predominant variation around zero, symmetry
%due to stationarity 

% 2.2.2 Comparing small lags with big lags 

subplot(2,1,2)
stem(-999:999, ACF); 
%axis([-999 999 -1.5 1.5])
title('Zoomed: Unbiased estimate of the ACF of a 1000-sample realisation of WGN')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')
zoom xon    
zoom(2)   %Zooming in on the x-axis by a factor of 20 

%% 2.1.3
T = 0:999;
x = 1./(1000-T);
x = 1000-T;
figure; plot(T, 1./(x)); ylim([0 0.1]); xlim([0 1000]);
title('Scaling constant of the variance of the unbised ACF estimate vs lag')
xlabel('lag \tau');
ylabel('1/(N - |\tau|), N = 1000');

%% Filtering WGN with moving average filter 
clear all; close all; clc; 

%COMMENT: shape of ACF and its relation to the MA coefficents (impulse
%response) of the considered filter 
%COMMENT: effect of filter order of the ACF, Is it possible to calculate the (local) sample mean this way? 

x = randn(1000,1); %Generating WGN 


y1 = filter(ones(9, 1), [1], x) %filtering with a moving average filters of different orders 
y2 = filter(ones(18, 1), [1], x)
y3 = filter(ones(3, 1), [1], x)

ACF1 = xcorr(y1, 'unbiased'); %Calculating the ACF 
ACF2 = xcorr(y2, 'unbiased');
ACF3 = xcorr(y3, 'unbiased');

figure(2); %Plotting

%subplot(3,2,1); stem(ones(3,1)); 

figure(2); 

subplot(1,3,1); 
stem(-999:999, ACF3); 
title('ACF estimate of WGN filtered by MA order 3')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')
zoom xon
zoom(50)

%subplot(3,2,3); stem(ones(9,1)); 

%figure(3);

subplot(1,3,2); 
stem(-999:999, ACF1); 
title('ACF estimate of WGN filtered by MA order 9')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')
zoom xon
zoom(50)

%subplot(3,2,5); stem(ones(20,1)); 

%figure(4);

subplot(1,3,3); 
stem(-999:999, ACF2); 
title('ACF estimate of WGN filtered by MA order 18')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')
zoom xon
zoom(40)

figure(5);

stem(-4:4, ones(9,1));
axis([-5 5 -1 2]); 
axis off 


m = mean(x);
m1 = mean(y1); %9 
m2 = mean(y2); %18
m3 = mean(y3); %3 
















