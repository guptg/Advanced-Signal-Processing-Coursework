%1.2.0 Stochastic processes 

%% 1.2.1 Mean and Standard deviation of random processes 1,2,3 (M=100, N= 100)

% Random Process 1

RP1 = rp1(100,100);
RP1_mean = mean(RP1); %This takes the mean of each column, so the mean of all the values at the same time instance for each realisation (ensemble) 
RP1_std = std(RP1);   %This takes the standard deviation of each column, so the std dev of all the values at the same time instance for each realization (ensemble) 

figure(1)
subplot(2,1,1)
plot(RP1_mean); title('Mean of Random Process 1 vs. time'); xlabel('time instance n'); ylabel('mean value') %This plots the means of each time instance against the time instance 

subplot(2,1,2)
plot(RP1_std); title('Standard deviation of Random Process 1 vs. time'); xlabel('time instance n'); ylabel('std value')

% Random Process 2

RP2 = rp2(100,100);
RP2_mean = mean(RP2);
RP2_std = std(RP2);

figure(2)
subplot(2,1,1)
plot(RP2_mean); title('Mean of Random Process 2 vs. time'); xlabel('time instance n'); ylabel('mean value')

subplot(2,1,2) 
plot(RP2_std); title('Standard deviation of Random Process 2 vs. time'); xlabel('time instance n'); ylabel('std value')

% Random Process 3

RP3 = rp3(100,100);
RP3_mean = mean(RP3);
RP3_std = std(RP3);

figure(3)
subplot(2,1,1)
plot(RP3_mean); title('Mean of Random Process 3 vs. time'); xlabel('time instance n'); ylabel('mean value')

subplot(2,1,2) 
plot(RP3_std); title('Standard deviation of Random Process 3 vs. time'); xlabel('time instance n'); ylabel('std value')

%% 1.2.2 Mean and Standard deviation of random processes 1,2,3 (M=4, N= 1000)

M = 4;
N = 1000; 

%calculating the mean for each of the four realizations in all random processes 1,2,3 

rp1_mean = mean(rp1(M,N)'); %To get the mean of all the sample values in each realization (rather than the mean of a time instance) we must transpose the matrix so that each realization (4 in total) are in each column instead 
rp2_mean = mean(rp2(M,N)');  
rp3_mean = mean(rp3(M,N)');

%calculating the stddev for each of the four realizations in all random processes 1,2,3

rp1_std = std(rp1(M,N)'); 
rp2_std = std(rp2(M,N)'); 
rp3_std = std(rp3(M,N)'); 


%% Comparing Endemble Averages and Theoretical Values 

% Random Process 1

RP1 = rp1(1000,1000);
RP1_mean = mean(RP1); %This takes the mean of each column, so the mean of all the values at the same time instance for each realisation (ensemble) 
RP1_std = std(RP1);   %This takes the standard deviation of each column, so the std dev of all the values at the same time instance for each realization (ensemble) 

figure(1)
subplot(2,1,1)
plot(RP1_mean); title('Mean of Random Process 1 vs. time'); xlabel('time instance n'); ylabel('mean value') %This plots the means of each time instance against the time instance 
hold on 
n = [0:1:999]; 
plot(0.02*n)


subplot(2,1,2)
plot(RP1_std); title('Standard deviation of Random Process 1 vs. time'); xlabel('time instance n'); ylabel('std value')
hold on 
plot((2.08*(sin(n*pi/1000)).^2).^0.5); 
legend('Ensemble av', 'Theoretical value');

% Random Process 2

RP2 = rp2(1000,1000);
RP2_mean = mean(RP2);
RP2_std = std(RP2);

figure(2)
subplot(2,1,1)
plot(RP2_mean); title('Mean of Random Process 2 vs. time'); xlabel('time instance n'); ylabel('mean value')
hold on 
y = 0.5;
line([0,1000],[y,y], 'color', 'r')

subplot(2,1,2) 
plot(RP2_std); title('Standard deviation of Random Process 2 vs. time'); xlabel('time instance n'); ylabel('std value')
hold on 
l = (1/9)^0.5;
line([0,1000],[l,l], 'color', 'r')
legend('Ensemble av', 'Theoretical value');

% Random Process 3

RP3 = rp3(1000,1000);
RP3_mean = mean(RP3);
RP3_std = std(RP3);

figure(3)
subplot(2,1,1)
plot(RP3_mean); title('Mean of Random Process 3 vs. time'); xlabel('time instance n'); ylabel('mean value')
hold on 
line([0,1000],[y,y], 'color', 'r')

subplot(2,1,2) 
plot(RP3_std); title('Standard deviation of Random Process 3 vs. time'); xlabel('time instance n'); ylabel('std value')
hold on 
s = ((9/12 )^0.5); 
line([0,1000],[s,s], 'color', 'r')
legend('Ensemble av', 'Theoretical value');







