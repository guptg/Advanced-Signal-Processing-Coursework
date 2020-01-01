%% lms algorithm

clear all; close all; clc; 

%Generating a 1000-sample WGN sequence x

X = randn(1000,1); %WGN

%feeding it through an unknown system 

Y = filter([1 2 3 2 1], 1, X); 

% Generating 1000-sample WGN sequence n with std dev 0.1 

n = 0.1*randn(1000,1); 

%adding noise to the output to produce the measured output 

Z = Y + n; 

[y_est, err, Wdata ] = lms(X, Z, 0.5, 4); 

%% Evolution of lms algorithm 


for i = 1:5
    c = Wdata(i, :); 
    figure(1); 
    plot(1:1000,c);
    hold on;
end
    title('Evolution of adaptive weights vs time \mu    = 0.5'); 
    xlabel('time instance'); 
    ylabel('coefficient value'); 
    
figure(2); 
plot(1:1000, 10*log10(err.^2)); 
title('Learning curve \mu = 0.5'); 
ylabel('error value');
xlabel('time instance'); 

figure(3); 
plot(1:1000, err); 
title('Evolution of estimate error vs time \mu = 0.5'); 
ylabel('error value');
xlabel('time instance'); 

