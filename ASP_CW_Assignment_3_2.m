%% 3.2.0 

clear all; close all; clc; 

%Generating a 1064 sample WGN signal and filtering it with the specified
%coefficients 

%randn('state', 1); 

WGN = randn(1064, 1); 
b = 1; 
a = [1, 0.9];
f = filter(b, a, WGN); 

%Removing the first 40 values 

x = WGN(41:1064); 
y = f(41:1064); 

%Plotting the two signals 

figure(1); 
plot(x); 
ylabel('Value of WGN signal'); 
title('WGN signal'); 
xlabel('sample number'); 
xlim([0 1024]); 

figure(2); 
plot(y); 
ylabel('Value of filtered WGN signal'); 
title('WGN signal filtered with b = 1, a = [1, 0.9]'); 
xlabel('sample number'); 
xlim([0 1024]); 

%%3.2.1

%freqz is the frequency response of a digital filter, w corresponds to rad. Can compute PSD with
%this 

[h, w] = freqz([1], [1 0.9], 512); 

figure(3); 
plot(w/(2*pi), 10*log10(abs(h).^2)); 
hold on;
plot(0.2334,-3.005,'r*')
text(0.2334,-3.005,['(' num2str(0.2334) ',' num2str(-3.005) ')']);
xlabel('Normalized Frequency( x 2 \pi rad/sample)'); 
ylabel('Magnitude (dB/Hz/sample)');
title(' Exact PSD of AR(1) model of WGN'); 


figure(4); 
plot(w/(2*pi), abs(h).^2); 
hold on; 
peri = pgm(y); 
plot(w/(2*pi), peri(1:512)); 
xlabel('Normalized Frequency( x 2 \pi rad/sample)'); 
ylabel('Magnitude');
title('Exact PSD and periodogram of AR(1) model of WGN');
legend('Exact PSD', 'Periodogram');  

figure(5); 
plot(w/(2*pi), abs(h).^2); 
hold on; 
peri = pgm(y); 
plot(w/(2*pi), peri(1:512)); 
xlabel('Normalized Frequency( x 2 \pi rad/sample)'); 
ylabel('Magnitude');
title('Exact PSD and periodogram of AR(1) model of WGN: zoomed');
legend('Exact PSD', 'Periodogram');  
xlim([0.4 0.5]); 

%%3.2.4 

Ry = xcorr(y, 'unbiased'); 
R1y = Ry(1025); 
R0y = Ry(1024);

a1e = -R1y/R0y; 
ve = R0y + a1e*R1y; 

[PSDest, w] = freqz([ve], [1 a1e], 512); 

figure(6); 
plot(w/(2*pi), abs(PSDest).^2); 
hold on;
plot(w/(2*pi), peri(1:512)); 
plot(w/(2*pi), abs(h).^2, 'color', 'k'); 

xlabel('Normalized Frequency( x 2 \pi rad/sample)'); 
ylabel('Magnitude');
title('Model based PSD, exact PSD and periodogram of AR(1) model of WGN');
legend('model-based PSD estimate', 'Periodogram', 'Exact PSD');  
xlim([0.4 0.5]); 

%% 3.2.5 Sunspot time series 
clear all; close all; clc; 

%Original series for model numbers 2, 8, and 16


load sunspot.dat;
sunspot = sunspot(:,2);

peri = pgm(sunspot); 

figure(7); 


for i = [2, 7, 30] 
   [mPSD, w] = pyulear(sunspot, i, 288);  
   plot(w/(2*pi), mPSD); 
   hold on; 
end 
plot(w/(2*pi), peri(1:145)); 
hold off; 

xlabel('Normalized Frequency( x 2 \pi rad/sample)'); 
ylabel('Magnitude');
title('Model based PSD estimates and periodogram of sunspot time series');
legend('AR(2)', 'AR(7)', 'AR(30)', 'periodogram' );  
xlim([0, 0.16]); 

 

%Zero - mean data 
    
sample_mean = mean(sunspot);
new_sunspot = (sunspot - sample_mean);



peri2 = pgm(new_sunspot); 

figure(8); 


for i = [2, 7, 30] 
   [mPSD, w] = pyulear(new_sunspot, i, 288);  
   plot(w/(2*pi), mPSD); 
   hold on; 
end 
plot(w/(2*pi), peri2(1:145)); 
hold off; 

xlabel('Normalized Frequency( x 2 \pi rad/sample)'); 
ylabel('Magnitude');
title('Model based PSD estimates and periodogram of zero mean sunspot time series');
legend('AR(2)', 'AR(7)', 'AR(30)', 'periodogram' );  
xlim([0, 0.16]); 


