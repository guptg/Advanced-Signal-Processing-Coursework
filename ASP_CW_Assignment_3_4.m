%% 3.4.1 London landline number 

close all; clear all; clc;

%Generate a random London landline number, a sequence, where the last eight
%digits are range between intergers 0 to 9 (uniform probability)

number = []; 

number(1)= 0;
number(2) = 2; 
number(3) = 0; 

for i = 1:8
    x = round(9*rand); 
    number = [number x];
end 

%Number is now a vector that has 11 elements 

%Matrix corresponding to frequency pairs where the first row
%corresponds to digit 0, 2nd row to digit 1, etc

f = [1336, 941;
     1209, 697;
     1336, 697;
     1477, 697; 
     1209, 770;
     1336, 770;
     1447, 770; 
     1209, 852;
     1336, 852;
     1447, 852]; 

samp_freq = 32768; %Hz The sampling frequency corresponds to the numner of samples in 1 second

%each tone lasts half a second so the number of samples per tone is half
%the sampling frequency

N = 0.5*samp_freq; 

%The dialed tone lasts have the tone (which includes the pause)
n = 1:N/2; %discrete time for the dialed tone

%We define an empty matix with sampling points spanning the length of the
%signal, i.e. corresponding to 5.25sec (N*11 -N/2)

y = zeros(1, N*length(number) - N/2);

%In the following loop we generate the appropriate signal for each digit in
%the number 

for i = 1:length(number)
    
    digit = number(i); 
    freqs = f(digit+1, :); 
    F1 = freqs(1);
    F2 = freqs(2); 
    
    signal = (sin((2*pi*F1*n)/samp_freq) + sin((2*pi*F2*n)/samp_freq)); %NOTE we divide by samp_freq to get continuous time signal as X[n] = Xc(nT)
    
    %Place the signal in the correct place

    y(((i*N) - N)+1:((i*N)-N/2)) = signal;
    
end 

figure(1); %Entire signal
plot((1:length(y))/samp_freq, y)    %Dividing by freq_samp gives the x-axis in discrete time
xlim([0 5.25])
xlabel('Time (seconds)');
ylabel('Amplitude');
number_tostr = sprintf('%d', number);
t = sprintf('London landline number: %s, in the DMTF system', number_tostr);
title(t); 

figure(2); %First two numbers 0 and 2
plot((1:length(y))/samp_freq, y)    %Dividing by freq_samp gives the x-axis in discrete time
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 0.75]);
title('Dial tone pad: keys 0 and 2'); 

figure(3); %First two numbers 0 and 2
plot((1:length(y))/samp_freq, y)    %Dividing by freq_samp gives the x-axis in discrete time
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0.5 0.515]);
title('Dial tone pad, key 2'); 

figure(4); %First two numbers 0 and 2
plot((1:length(y))/samp_freq, y)    %Dividing by freq_samp gives the x-axis in discrete time
xlabel('Time (seconds)');
ylabel('Amplitude');
xlim([0 0.015]);
title('Dial tone pad, key 0'); 

%%3.4.2 Spectrogram 
    
% Use Spectrogram to analyse the spectral components of the sequence y 

figure(5);
spectrogram(y, hann(8192), 0, [], samp_freq, 'yaxis');
title('Spectrogram of entire dialled number: signal y'); 
ylim([0 2]); 

% FFT segments 

f = (((samp_freq).*(1:N))./N); 
y0 = fft(y(1:N)); 
y1 = fft(y(N+1:2*N));
figure(6); 
plot(f, (abs(y0)));
hold on; 
plot(f, (abs(y1)));
xlim([0 2000]); 

xlabel('Frequency Hz');
ylabel('Magnitude'); 
title('FFT segments of the two-tone signals for digits 0 and 2'); 
legend('digit 0', 'digit 1'); 

%Periodograms of digits 0 and 2

pgm0 = pgm(y(1:N)); 
pgm1 = pgm(y(N+1:2*N));
figure(7); 
plot(f, 10*log10(pgm0));
hold on; 
plot(f, 10*log10(pgm1));
xlim([0 2500]); 
xlabel('Frequency Hz');
ylabel('Magnitude (dB)'); 
title('periodograms of the two-tone signals for digits 0 and 2');
legend('digit 0', 'digit 1'); 

%Adding noise (low varaince)

size = length(y); 

y = y + 0.25*randn(1, length(y)); 
figure(8); %Entire signal
plot((1:length(y))/samp_freq, y)    %Dividing by freq_samp gives the x-axis in discrete time
xlim([0.23 0.265])
xlabel('Time (seconds)');
ylabel('Amplitude');
title('signal for digit 0 immeresed in low noise variance');

figure(9);
spectrogram(y, hann(8192), 0, [], samp_freq, 'yaxis');
title('Spectrogram of signal with low noise variance'); 
ylim([0 2]); 

f = (((samp_freq).*(1:N))./N); 
y0 = fft(y(1:N)); 
y1 = fft(y(N+1:2*N));
figure(10); 
plot(f, (abs(y0)));
hold on; 
plot(f, (abs(y1)));
xlim([0 2000]); 
xlabel('Frequency Hz');
ylabel('Magnitude'); 
title('FFT segments of the two-tone signals for digits 0 and 2, low noise'); 
legend('digit 0', 'digit 1'); 

%Adding noise (middle varaince)

y = y + 3.5*randn(1, length(y)); 
figure(11); %Entire signal
plot((1:length(y))/samp_freq, y)    %Dividing by freq_samp gives the x-axis in discrete time
xlim([0.23 0.265])
xlabel('Time (seconds)');
ylabel('Amplitude');
title('signal for digit 0 immeresed in medium noise variance');

figure(12);
spectrogram(y, hann(8192), 0, [], samp_freq, 'yaxis');
title('Spectrogram of signal with medium noise variance'); 
ylim([0 2]); 

f = (((samp_freq).*(1:N))./N); 
y0 = fft(y(1:N)); 
y1 = fft(y(N+1:2*N));
figure(13); 
plot(f, (abs(y0)));
hold on; 
plot(f, (abs(y1)));
xlim([0 2000]); 
xlabel('Frequency Hz');
ylabel('Magnitude'); 
title('FFT segments of the two-tone signals for digits 0 and 2, medium noise'); 
legend('digit 0', 'digit 1'); 

%Adding noise (high varaince)

y = y + 10*randn(1, length(y)); 
figure(14); %Entire signal
plot((1:length(y))/samp_freq, y)    %Dividing by freq_samp gives the x-axis in discrete time
xlim([0.23 0.265])
xlabel('Time (seconds)');
ylabel('Amplitude');
title('signal for digit 0 immeresed in high noise variance');

figure(15);
spectrogram(y, hann(8192), 0, [], samp_freq, 'yaxis');
title('Spectrogram of signal with high noise variance'); 
ylim([0 2]); 

f = (((samp_freq).*(1:N))./N); 
y0 = fft(y(1:N)); 
y1 = fft(y(N+1:2*N));
figure(16); 
plot(f, (abs(y0)));
hold on; 
plot(f, (abs(y1)));
xlim([0 2000]); 
xlabel('Frequency Hz');
ylabel('Magnitude'); 
title('FFT segments of the two-tone signals for digits 0 and 2, high noise'); 
legend('digit 0', 'digit 1'); 


