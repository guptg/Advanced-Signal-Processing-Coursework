%% 4.1 Weiner filter 

clear all; close all; clc; 

%Generating a 1000-sample WGN sequence x

X = randn(1000,1); %WGN

%feeding it through an unknown system 

Y = filter([1 2 3 2 1], 1, X); 

%normalizing the output 

mean_Y = mean(Y); 
std_Y = std(Y); 

y = (Y - mean_Y)/std_Y; 

%Checking for unit varaince and zero mean

% mean_y = mean(y); 
% std_y = std(y); 

% Generating 1000-sample WGN sequence n with std dev 0.1 

n = (2)^0.5*randn(1000,1); 

%adding noise to the output to produce the measured output 

z = y + n; %Change Y TO y FOR COMPARISON!!! y scales it by 1/5!!!

Z = Y + n; 

%calculating the signal to noise ratio, ratio between power of z to power
%of noise 

power_z = var(z); %z is a zero mean process 
power_n = var(n); 

SNR= 10*log10(power_z/power_n); 

%calculating the autocorrelation matrix Rxx Nw = 4! but length is 5

ACF = xcorr(X, 'unbiased'); 

rxx = ACF(1000: length(ACF)); 

W_data = zeros(10); 

for m = 1:10

    for p = m

        Rxx = zeros(p, p); 


        for K = 1:p
            for i = 1:p
                Rxx(K, i) = rxx(abs(K-i)+1); 
            end 
        end

    end


    %calculating the cross correlation matrix between z and x Pzx

    CCF = xcorr(z, X, 'unbiased'); 

    CCF2 = xcorr(Z, X, 'unbiased'); 

    Pxz = CCF(1000:(1000+(m-1))); 

    Pxz2 = CCF2(1000:(1000 +(m-1)));

    %Getting the optimal weiner coefficients 

    Wopt = inv(Rxx)*Pxz; 

    %This is for the unnormlized output y 

    Wopt2 = inv(Rxx)*Pxz2; 
    
    W_data(m, 1:m) = Wopt2; 
    
end 

[y_est, err, Wdata ] = lms(X, Z, 0.01, 4); 
%% 4.1.2 Changing variance of additive noise 
clear all; close all; clc;
X = randn(1000,1); %WGN

SNR_data = [];

W_data = [];

i = 0; 

for V = [0.1 2.1 4.1 6.1 8.1 10] 
    
    i = i+1; 

    %feeding it through an unknown system 

    Y = filter([1 2 3 2 1], 1, X); 

    %normalizing the output 

    mean_Y = mean(Y); 
    std_Y = std(Y); 

    y = (Y - mean_Y)/std_Y; 

    % Generating 1000-sample WGN sequence n with std dev 0.1 

    n = ((V)^0.5)*randn(1000,1); 

    %adding noise to the output to produce the measured output 

    z = y + n; %Change Y TO y FOR COMPARISON!!! y scales it by 1/5!!!

    %calculating the signal to noise ratio, ratio between power of z to power
    %of noise 

    power_z = var(z); %z is a zero mean process 
    power_n = var(n); 

    SNR= 10*log10(power_z/power_n); 
    
    SNR_data = [SNR_data SNR]; 

    %calculating the autocorrelation matrix Rxx Nw = 4! but length is 5

    ACF = xcorr(X, 'unbiased'); 

    rxx = ACF(1000: length(ACF)); 

    for p = 1:5

        Rxx = zeros(p, p); 


        for K = 1:p
            for i = 1:p
                Rxx(K, i) = rxx(abs(K-i)+1); 
            end 
        end

    end


    %calculating the cross correlation matrix between z and x Pzx

    CCF = xcorr(z, X, 'unbiased'); 

    Pxz = CCF(1000:1004); 

    %Getting the optimal weiner coefficients 

    Wopt = inv(Rxx)*Pxz; 
    
    W_data = [W_data ; Wopt']; 
    
     
end 

%% Assuming Nw is 9 
clear all; close all; clc; 

%Generating a 1000-sample WGN sequence x

X = randn(1000,1); %WGN

%feeding it through an unknown system 

Y = filter([1 2 3 2 1], 1, X); 

%normalizing the output 

mean_Y = mean(Y); 
std_Y = std(Y); 

y = (Y - mean_Y)/std_Y; 

%Checking for unit varaince and zero mean

% mean_y = mean(y); 
% std_y = std(y); 

% Generating 1000-sample WGN sequence n with std dev 0.1 

n = 0.1*randn(1000,1); 

%adding noise to the output to produce the measured output 

z = Y + n; %Change Y TO y FOR COMPARISON!!! y scales it by 1/5!!!

%calculating the signal to noise ratio, ratio between power of z to power
%of noise 

power_z = var(z); %z is a zero mean process 
power_n = var(n); 

SNR= 10*log10(power_z/power_n); 

%calculating the autocorrelation matrix Rxx Nw = 4! but length is 5

ACF = xcorr(X, 'unbiased'); 

rxx = ACF(1000: length(ACF)); 

for p = 1:9
    
    Rxx = zeros(p, p); 
    
      
    for K = 1:p
        for i = 1:p
            Rxx(K, i) = rxx(abs(K-i)+1); 
        end 
    end
      
end


%calculating the cross correlation matrix between z and x Pzx

CCF = xcorr(z, X, 'unbiased'); 

Pxz = CCF(1000:1008); 

%Getting the optimal weiner coefficients 

Wopt = inv(Rxx)*Pxz; 


%% 4.1.3 Calculating the computational complexity of this algorithm 


