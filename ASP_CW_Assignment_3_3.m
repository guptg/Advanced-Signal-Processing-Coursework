%% 3.3.3 AND 3.3.4 

clear all; close all; clc; 

load sunspot.dat

% Normalizing the data 
sunspot = sunspot(:,2); 
X = (sunspot - mean(sunspot))/std(sunspot) ; 

ACF = xcorr(X, 'unbiased'); 

%Getting the ACF in terms of rxx(0) rxx(1) etc where ACF(288) = rxx(0)
rxx = ACF(288: length(ACF)); 

MSE = []; %Empty matrix to store the MSE

LSE = zeros(10); 

for p = 1:10
    
    % Getting the Autocorrelation matrix for the given model order 
    R = zeros(p, p); 
    
      
    for K = 1:p
        for i = 1:p
            R(K, i) = rxx(abs(K-i)+1); %R is the same as H!!!
        end 
    end

    %YW solution same as LSE
    ay = inv(R) *rxx(2:p+1); 
    
    %LSE solution 
    aLSE = inv((R'*R))*R'*rxx(2:p+1);
    
    %Solution from aryule function 
    
%     [ayf e] = aryule(X, p); 
    
    e = filter([1 (-aLSE)'], 1 , X); 
    E = var(e); %This should be the same as the e from the aryule function 
    
    model = filter(e, [1 (-aLSE)'], X); %b is the the estimated variance of the white noise input 
    
    error = sum((X - model).^2)/length(X);    %Getting the MSE 
    
    MSE = [MSE error]; %storing the MSE
    
    e1 = X - model; %getting the approximation error 
    
    figure(1); %Plot of the aproximation error for each model 
     
    LSE(p, 1:p) = round(aLSE, 4); 
    plot(sunspot, e1, '*');
    
    hold on; 
    
    
end

title('Approximation error vs originl sunspot data for model orders 1 to 10'); 
legend('AR(1)', 'AR(2)', 'AR(3)', 'AR(4)', 'AR(5)', 'AR(6)', 'AR(7)', 'AR(8)', 'AR(9)', 'AR(10)'); 
ylabel('approximation error');
xlabel('original data'); 

figure(2); 
plot(1:10, MSE); 
title('MSE vs model order');
ylabel('MSE');
xlabel('model order number'); 

%% 3.3.5
clear all; close all; clc; 

load sunspot.dat

% Normalizing the data 
sunspot = sunspot(:,2); 
X = (sunspot - mean(sunspot))/std(sunspot) ; 

ACF = xcorr(X, 'unbiased'); 

rxx = ACF(288: length(ACF)); 

for p = 1:10
    
    R = zeros(p, p); 
    
      
    for K = 1:p
        for i = 1:p
            R(K, i) = rxx(abs(K-i)+1); %R is the same as H!!!
        end 
    end
    
    aLSE = inv((R'*R))*R'*rxx(2:p+1);
    
%    [ayf e] = aryule(X, p); 
    
    e = filter([1 (-aLSE)'], 1 , X); 
    E = var(e); %This should be the same as the e from the aryule function 
    
      
    [h,w]=freqz([E], [1 (-aLSE)'] ,144);
    
    figure(1);
    
    plot(w/(2*pi), abs(h).^2); 
    
    hold on; 
    
end

title('Power spectra of the AR models of the susnpot data')
legend('AR(1)', 'AR(2)', 'AR(3)', 'AR(4)', 'AR(5)', 'AR(6)', 'AR(7)', 'AR(8)', 'AR(9)', 'AR(10)'); 
ylabel('Magnitude');
xlabel('Normalized frequency');



%% 3.3.6


clear all; close all; clc; 

load sunspot.dat

sunspot = sunspot(:,2); 
X = (sunspot - mean(sunspot))/std(sunspot) ; 

J = [];
for N = 5:5:250
    x = X;
    x = x(1:N);
    ACF = xcorr(x, 'unbiased'); 
    rxx = ACF(N: length(ACF)); 
    
    for p = 2
        R = zeros(p, p); 
        for K = 1:p
            for i = 1:p
                R(K, i) = rxx(abs(K-i)+1); %R is the same as H!!!
            end 
        end
        
        [ayf e] = aryule(x, p); 
        
 
        aLSE = inv((R'*R))*R'*rxx(2:p+1);
        
%          e = filter([1 (-aLSE)'], 1 , x); 
%          E = var(e);
        model = filter(e, [ 1 (-aLSE)'], x); 
        
        %error = (x(1:2) - R*aLSE)'*(x(1:2) - R*aLSE)/N; 
        error = sum((x - model).^2)/N;     
        J = [J error];
        
    end
end

 figure(1); plot(5:5:250, J);  
 title('MSE vs data length for model order 2 of the sunspot data');
 ylabel('MSE');
 xlabel('Data length'); 
