%% 3.0.0 Periodogram function testing 

clear all; close all; clc; 

x1 = randn(1, 128);
peri1 = pgm(x1); 
frequencies1 = 0:(length(x1)-1); 
normalized_frequencies1 = frequencies1./(length(x1)); 
figure(1); 
stem(normalized_frequencies1, peri1, 'marker', 'none'); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('Periodogram of WGN, N=128');
xlim([0 0.5]); 

x2 = randn(1, 256);
peri2 = pgm(x2);
frequencies2 = 0:(length(x2)-1); 
normalized_frequencies2 = frequencies2./(length(x2)); 
figure(2); 
stem(normalized_frequencies2, peri2, 'marker', 'none'); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('Periodogram of WGN, N=256');
xlim([0 0.5]); 

x3 = randn(1, 512);
peri3 = pgm(x3); 
frequencies3 = 0:(length(x3)-1); 
normalized_frequencies3 = frequencies3./(length(x3)); 
figure(3); 
stem(normalized_frequencies3, peri3, 'marker', 'none'); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('Periodogram of WGN, N=512');
xlim([0 0.5]); 


