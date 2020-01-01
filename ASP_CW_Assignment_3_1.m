%% 3.1.1 
clear all; close all; clc; 

x1 = randn(1, 128);
peri1 = filtfilt( 0.2*[1 1 1 1 1], 1, pgm(x1)); 
frequencies1 = 0:(length(x1)-1); 
normalized_frequencies1 = frequencies1./(length(x1)); 
figure(1); 
stem(normalized_frequencies1, peri1, 'marker', 'none'); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('MA filtered Periodogram of WGN, N=128');
xlim([0 0.5]); 

x2 = randn(1, 256);
peri2 = filtfilt(0.2*[1 1 1 1 1], 1, pgm(x2));
frequencies2 = 0:(length(x2)-1); 
normalized_frequencies2 = frequencies2./(length(x2)); 
figure(2); 
stem(normalized_frequencies2, peri2, 'marker', 'none'); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('MA filtered Periodogram of WGN, N=256');
xlim([0 0.5]); 

x3 = randn(1, 512);
peri3 = filtfilt(0.2*[1 1 1 1 1], 1, pgm(x3)); 
frequencies3 = 0:(length(x3)-1); 
normalized_frequencies3 = frequencies3./(length(x3)); 
figure(3); 
stem(normalized_frequencies3, peri3, 'marker', 'none'); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('MA filtered Periodogram of WGN, N=512');
xlim([0 0.5]); 

%% 3.1.2 /3.1.3 

clear all; close all; clc; 

x = randn(1024,1); 

Divisions = [];

for i = 1:128:(length(x)-127)
    d = x(i:(i+127)); 
    Divisions = [Divisions d]; 
end 

Peris = []; 

for i = 1:8
    peri = pgm(Divisions(:, i)); 
    Peris = [Peris peri]; 
    frequencies3 = 0:(128-1); 
    normalized_frequencies3 = frequencies3./128; 
    %subplot(2, 4, i); 
    figure(i);
    stem(normalized_frequencies3, peri, 'marker', 'none'); 
    xlabel('Normalized frquency');
    ylabel('Magnitude');
    title('Periodogram of WGN, N=1024/8');
    xlim([0 0.5]); 
end 

mean_peri = mean(Peris');
frequencies3 = 0:(128-1); 
normalized_frequencies3 = frequencies3./128; 
figure; 
stem(normalized_frequencies3, mean_peri, 'marker', 'none'); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('Mean Periodogram of WGN, N=1024');
xlim([0 0.5]); 

 