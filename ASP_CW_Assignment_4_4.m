
clear all; close all; clc; 

%Generating a 1000-sample WGN sequence x

X = randn(1000,1); %WGN

%feeding it through an unknown system 

a = [1, 0.9, 0.2]; 

Y = filter(1, a, X); 

[y_est, error, AR_est] = ARlms(Y, 0.004, 2); 

for i = 1:2
    c = AR_est(i, :); 
    figure(1); 
    plot(1:1000,-c);
    hold on;
end
    yline(0.9);
    yline(0.2);
    title('Evolution of AR parameters vs time \mu    = 0.004'); 
    xlabel('time instance'); 
    ylabel('coefficient value'); 
    legend ('a1', 'a2'); 