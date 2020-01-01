%%3.5.1 

clear all; close all; clc;

load joanna_ecg.mat; 

%Extracting unconstrained breathing data without artifacts and making sure
%it is zero mean using detrend 
trial1 = data(1: 252200); %Unconstrained breathing 
trial2 = data(282900: 501300); % 50 beats per minute 
trial3 = data(583100:752100); %15 beats per minute 

[x1, RFS1] = ECG_to_RRI(trial1, 1000);
[x2, RFS2] = ECG_to_RRI(trial2, 1000);
[x3, RFS3] = ECG_to_RRI(trial3, 1000); 

%Converting the data to RRI 
RRI_trial1 = detrend(x1); 
RRI_trial2 = detrend(x2); 
RRI_trial3 = detrend(x3); 

frequencies1 = 0:(length(RRI_trial1)-1); 
normalized_frequencies1 = frequencies1./(length(RRI_trial1)); 

frequencies2 = 0:(length(RRI_trial2)-1); 
normalized_frequencies2 = frequencies2./(length(RRI_trial2)); 

frequencies3 = 0:(length(RRI_trial3)-1); 
normalized_frequencies3 = frequencies3./(length(RRI_trial3)); 

peri1 = pgm(RRI_trial1); 
peri2 = pgm(RRI_trial2); 
peri3 = pgm(RRI_trial3); 

figure;
plot(normalized_frequencies1, peri1); 
xlim([0 0.15]); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('Periodogram of trial1');

hold on; 

Divisions = [];

for i = 1:150:751
    d = RRI_trial1(i:(i+149)); 
    Divisions = [Divisions; d]; 
end 

Peris = []; 

for i = 1:6
    peri = pgm(Divisions(i, :)); 
    Peris = [Peris; peri]; 
end 

mean_peri = mean(Peris);
frequencies = 0:(150-1); 
normalized_frequencies = frequencies./150; 
plot(normalized_frequencies, mean_peri); 


Divisions = [];

for i = 1:50:951
    d = RRI_trial1(i:(i+49)); 
    Divisions = [Divisions; d]; 
end 

Peris = []; 

for i = 1:20
    peri = pgm(Divisions(i, :)); 
    Peris = [Peris; peri]; 
end 

mean_peri = mean(Peris);
frequencies = 0:(50-1); 
normalized_frequencies = frequencies./50; 
plot(normalized_frequencies, mean_peri); 

legend('orginal', 'av. 50', 'av. 150'); 

hold off; 

figure;
plot(normalized_frequencies2, peri2); 
hold on; 
xlim([0 0.15]); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('Periodogram of trial2');

Divisions = [];

for i = 1:150:601
    d = RRI_trial2(i:(i+149)); 
    Divisions = [Divisions; d]; 
end 

Peris = []; 

for i = 1:5
    peri = pgm(Divisions(i, :)); 
    Peris = [Peris; peri]; 
end 

mean_peri = mean(Peris);
frequencies = 0:(150-1); 
normalized_frequencies = frequencies./150; 
plot(normalized_frequencies, mean_peri); 


Divisions = [];

for i = 1:50:801
    d = RRI_trial2(i:(i+49)); 
    Divisions = [Divisions; d]; 
end 

Peris = []; 

for i = 1:17
    peri = pgm(Divisions(i, :)); 
    Peris = [Peris; peri]; 
end 

mean_peri = mean(Peris);
frequencies = 0:(50-1); 
normalized_frequencies = frequencies./50; 
plot(normalized_frequencies, mean_peri); 
legend('orginal', 'av. 150', 'av. 50')


hold off; 

figure;
plot(normalized_frequencies3, peri3); 
hold on; 
xlim([0 0.15]); 
xlabel('Normalized frquency');
ylabel('Magnitude');
title('Periodogram of trial3');

Divisions = [];

for i = 1:150:451
    d = RRI_trial3(i:(i+149)); 
    Divisions = [Divisions; d]; 
end 

Peris = []; 

for i = 1:4
    peri = pgm(Divisions(i, :)); 
    Peris = [Peris; peri]; 
end 

mean_peri = mean(Peris);
frequencies = 0:(150-1); 
normalized_frequencies = frequencies./150; 
plot(normalized_frequencies, mean_peri); 

Divisions = [];

for i = 1:50:601
    d = RRI_trial3(i:(i+49)); 
    Divisions = [Divisions; d]; 
end 

Peris = []; 

for i = 1:13
    peri = pgm(Divisions(i, :)); 
    Peris = [Peris; peri]; 
end 

mean_peri = mean(Peris);
frequencies = 0:(50-1); 
normalized_frequencies = frequencies./50; 
plot(normalized_frequencies, mean_peri); 


legend('orginal', 'av. 150', 'av. 50')

hold off; 