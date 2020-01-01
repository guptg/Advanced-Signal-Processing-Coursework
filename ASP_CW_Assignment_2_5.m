%% 2.5.1 PDEs of heart rates 

clear all; close all; clc;

load joanna_ecg.mat; 

%Viewing entire ECG data 

figure(1);
plot(data); 

%Extracting unconstrained breathing data without artifacts 
trial1 = data(132700: 249400); 

%Viewing unconstrained breathing ECG data 
figure(2); 
plot(trial1); 

%Converting ECG data to RRI data 
RRI_data = ECG_to_RRI(trial1, 1000); 

%getting heart rate 
hr = 60./RRI_data; 

figure(5); 
PDE = histogram(hr, 25, 'Normalization','pdf');
title('PDE of the original heart rates')
xlabel('heart rate intervals'); 
ylabel('probability density')
xlim([0 100]); 

hr1 = [];

for i = 1:10:451
    h = sum(hr(i:(i+9)))/10;
    hr1 = [hr1 h];
end 

figure(6); 
PDE1 = histogram(hr1, 25, 'Normalization','pdf');
title('PDE of the averaged heart rates, \alpha = 1')
xlabel('heart rate intervals'); 
ylabel('probability density')
xlim([0 100]); 

hr6 = [];

for i = 1:10:451
    h = sum(0.4*hr(i:(i+9)))/10;
    hr6 = [hr6 h];
end 

figure(7); 
PDE6 = histogram(hr6, 25, 'Normalization','pdf');
title('PDE of the averaged heart rates, \alpha = 0.6')
xlabel('heart rate intervals'); 
ylabel('probability density')
xlim([0 100]); 

%% 2.5.2 Ar modelling of heart rates 
clear all; close all; clc;

load joanna_ecg.mat; 

%Viewing entire ECG data 

figure(1);
plot(data); 

%Extracting unconstrained breathing data without artifacts and making sure
%it is zero mean usind detrend 
trial1 = data(132700: 249400); %Unconstrained breathing 
trial2 = data(343700: 501500); % 50 beats per minute 
trial3 = data(550800: 645200); %15 beats per minute 

%Converting the data to RRI 
RRI_trial1 = detrend(ECG_to_RRI(trial1, 1000)); 
RRI_trial2 = detrend(ECG_to_RRI(trial2, 1000)); 
RRI_trial3 = detrend(ECG_to_RRI(trial3, 1000)); 

%Find the autocorrelation sequence for the RRI data for the three trials

ACF1 = xcorr(RRI_trial1); 
ACF2 = xcorr(RRI_trial2); 
ACF3 = xcorr(RRI_trial3); 


figure; 
stem(-465:465, ACF1); 
title('ACF of trial 1: Unconstrained')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')
xlim([-200 200]); 


figure; 
stem(-630:630, ACF2); 
title('ACF of trial 2: 50 beats per minute')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')
xlim([-200 200]); 

figure; 
stem(-376:376, ACF3); 
title('ACF of trial 3: 15 beats per minute')
xlabel('Lag \tau')
ylabel('estimated R_x(\tau)')
xlim([-200 200]); 

%% Detremining optimal model number 

%Obtaining patial correlation

clear all; close all; clc;

load joanna_ecg.mat; 

%Extracting unconstrained breathing data without artifacts and making sure
%it is zero mean usind detrend 

trial1 = data(151900: 187000); %Unconstrained breathing 
trial2 = data(343700: 501500); % 50 beats per minute 
trial3 = data(569800: 736100); %15 beats per minute 

%Converting the data to RRI 
RRI_trial1 = zscore(ECG_to_RRI(trial1, 1000)); 
RRI_trial2 = zscore(ECG_to_RRI(trial2, 1000)); 
RRI_trial3 = zscore(ECG_to_RRI(trial3, 1000)); 

akk = []; 

for i = 1:20
    A = aryule(RRI_trial1, i); 
    akk = [akk A(i+1)];     %The PACs are the last elements in the array of a coefficents determined by the Y-W eqns 
end 

figure; 
stem(1:20, akk) 
title('Partial Autocorrelation function: trial 1');
xlabel('Lag \tau')
ylabel('PAC')

akk = []; 

for i = 1:20
    A = aryule(RRI_trial2, i); 
    akk = [akk A(i+1)];     %The PACs are the last elements in the array of a coefficents determined by the Y-W eqns 
end 

figure; 
stem(1:20, akk) 
title('Partial Autocorrelation function: trial 2');
xlabel('Lag \tau')
ylabel('PAC')

akk = []; 

for i = 1:20
    A = aryule(RRI_trial3, i); 
    akk = [akk A(i+1)];     %The PACs are the last elements in the array of a coefficents determined by the Y-W eqns 
end 

figure;  
stem(1:20, akk) 
title('Partial Autocorrelation function: trial 3');
xlabel('Lag \tau')
ylabel('PAC')

%Obtaining minimum crriteria 


N = length(RRI_trial1);

MDL = [];
AIC = [];
Error = [];


for i = 1:30
   
   [a, E] = aryule(RRI_trial1, i);
   MDL = [MDL (log(E) + (i*log(N)/N))];
   AIC = [AIC (log(E) + 2*i/N)]; 
   Error = [Error log(E)];
end

figure; 
plot(MDL);
hold on;
plot(AIC, 'r');
plot(Error, 'g')
legend('MDL','AIC', 'Cumulative Squared Error');
xlabel('Model Order');
ylabel('Model Error');
title('MDL, AIC and Cumulative Squared Error: trial 1');

N = length(RRI_trial2);

MDL = [];
AIC = [];
Error = [];


for i = 1:30
   
   [a, E] = aryule(RRI_trial2, i);
   MDL = [MDL (log(E) + (i*log(N)/N))];
   AIC = [AIC (log(E) + 2*i/N)]; 
   Error = [Error log(E)];
end

figure; 
plot(MDL);
hold on;
plot(AIC, 'r');
plot(Error, 'g')
legend('MDL','AIC', 'Cumulative Squared Error');
xlabel('Model Order');
ylabel('Model Error');
title('MDL, AIC and Cumulative Squared Error: trial 2');

N = length(RRI_trial3);

MDL = [];
AIC = [];
Error = [];


for i = 1:30
   
   [a, E] = aryule(RRI_trial3, i);
   MDL = [MDL (log(E) + (i*log(N)/N))];
   AIC = [AIC (log(E) + 2*i/N)]; 
   Error = [Error log(E)];
end

figure;
plot(MDL);
hold on;
plot(AIC, 'r');
plot(Error, 'g')
legend('MDL','AIC', 'Cumulative Squared Error');
xlabel('Model Order');
ylabel('Model Error');
title('MDL, AIC and Cumulative Squared Error: trial 3');

