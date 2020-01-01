%% 1.1.0 Statisitcal Estimation  

% a column vector x where each element is distributed randomly between 0 and 1
X = rand(1000, 1) 

%Vector x is a 1000-sample realization of a sationary stochastic process x[n]
figure(1);plot(X);title('1000-sample realization of a stationary stochsatic process x[n] vs. discrete time'); xlabel('time instance n'), ylabel('sample value x[n]');

%% 1.1.1 Sample Mean 

sample_mean = mean(X);

%% 1.1.2 Sample Standard Deviation 

Sample_std = std(X); 

%% 1.1.3 Bias 

X10 = rand(1000, 10);

sample_means10 = mean(X10);

sample_stds10 = std(X10);

figure(2); 
y1 = 0.5;
y2 = 0.2887;
plot(sample_means10, 'ko');
hold on 
plot(sample_stds10, 'ro');
line([0,10],[y1,y1], 'Color', 'k');
line([0,10],[y2,y2], 'Color', 'r');
title('Mean and Standard deviation'); xlabel('Realizaton number'); ylabel('Mean and Standard deviation'); legend({'mean', 'std dev', 'Theoretical mean', 'Theoretical std'});
hold off 

sm10_cw = round(sample_means10, 4); 
ss10_cw = round(sample_stds10, 4);

bias_means = round(0.5 - sample_means10 , 4);
bias_stds = round(0.288- sample_stds10, 4); 


%% 1.1.4 pdf 

X1 = rand(1000, 1); 
X2 = rand(10000, 1); 
X3 = rand(100000, 1); 

%Seeing the effect of increasing N 

figure(3); 
    subplot(3,1,1)
    histogram(X1, 50, 'Normalization','pdf');
    hold on
    a=0; b=1; y=unifpdf(X1,a,b); plot(X1,y);
    title('pdf approximation and theoretical pdf: uniform distribution, N = 1000');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: U(0,1)');
    xlabel('bins')
    ylabel('Density')

    subplot(3,1,2)
    histogram(X2, 50, 'Normalization','pdf');
    hold on
    a=0; b=1; y=unifpdf(X2,a,b); plot(X2,y);
    title('pdf approximation and theoretical pdf: uniform distribution, N = 10000');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: U(0,1)');
    xlabel('bins')
    ylabel('Density')

    subplot(3,1,3)
    histogram(X3, 50, 'Normalization','pdf');
    hold on
    a=0; b=1; y=unifpdf(X3,a,b); plot(X3,y);
    title('pdf approximation and theoretical pdf: uniform distribution, N = 100000');
    legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: U(0,1)');
    xlabel('bins')
    ylabel('Density')

%Seeing the effect of increasing bins 

figure(4); 
    subplot(3,1,1)
    histogram(X1, 10, 'Normalization','pdf');
    hold on
    a=0; b=1; y=unifpdf(X1,a,b); plot(X1,y);
    title('pdf approximation and theoretical pdf: uniform distribution, bins = 10');
    legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: U(0,1)');
    xlabel('bins')
    ylabel('Density')

    subplot(3,1,2)
    histogram(X1, 50, 'Normalization','pdf');
    hold on
    a=0; b=1; y=unifpdf(X1,a,b); plot(X1,y);
    title('pdf approximation and theoretical pdf: uniform distribution, bins = 50');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: U(0,1)');
    xlabel('bins')
    ylabel('Density')

    subplot(3,1,3)
    histogram(X1, 100, 'Normalization','pdf');
    hold on
    a=0; b=1; y=unifpdf(X1,a,b); plot(X1,y);
    title('pdf approximation and theoretical pdf: uniform distribution, bins = 100');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: U(0,1)');
    xlabel('bins')
    ylabel('Density')


%% 1.1.5 Repeat using normal distribution 

Xn = randn(1000, 1); 
figure(5);plot(Xn);title('1000-sample realization of a stationary stochsatic process x[n] vs. discrete time'); xlabel('time instance n'), ylabel('sample value x[n]');

sample_meann = mean(Xn);
Sample_stdn = std(Xn); 


X10n = randn(1000, 10);
sample_means10n = mean(X10n);
sample_stds10n = std(X10n);


sm10_cwn = round(sample_means10n, 4); 
ss10_cwn = round(sample_stds10n, 4);

bias_meann = sm10_cwn * (-1); 
bias_stdn = 1-ss10_cwn;
 
figure(6); 
y1n = 0;
y2n = 1;
plot(sample_means10n, 'ko');
hold on 
plot(sample_stds10n, 'ro');
line([0,10],[y1n,y1n], 'Color', 'k');
line([0,10],[y2n,y2n], 'Color', 'r');
title('Mean and Standard deviation'); xlabel('Realizaton number'); ylabel('Mean and Standard deviation'); legend({'mean', 'std dev', 'Theoretical mean', 'Theoretical std'});
hold off 

figure(7); histogram(Xn, 'Normalization','pdf');
hold on 
r = [-4:0.1:4];
y=normpdf(r, 0, 1); plot(r,y); %NOT SURE ABOUT THIS BIT 
title('pdf approximation and theoretical pdf: normal distributon');
xlabel('bins');
ylabel('Density');
legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: normal distribution');



X1n = randn(1000, 1); 
X2n = randn(10000, 1); 
X3n = randn(100000, 1); 

%Seeing the effect of increasing N 

figure(7); 
    subplot(3,1,1)
    histogram(X1n, 50, 'Normalization','pdf');
    hold on
    r = [-4:0.1:4];
    y=normpdf(r, 0, 1); plot(r,y); 
    title('pdf approximation and theoretical pdf: normal distributon, N = 1000');
    xlabel('bins');
    ylabel('Density');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: normal distribution');


    subplot(3,1,2)
    histogram(X2n, 50, 'Normalization','pdf');
    hold on
    r = [-4:0.1:4];
    y=normpdf(r, 0, 1); plot(r,y); 
    title('pdf approximation and theoretical pdf: normal distributon, N = 10000');
    xlabel('bins');
    ylabel('Density');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: normal distribution');


    subplot(3,1,3)
    histogram(X3n, 50, 'Normalization','pdf');
    hold on
    r = [-4:0.1:4];
    y=normpdf(r, 0, 1); plot(r,y); 
    title('pdf approximation and theoretical pdf: normal distributon, N = 100000');
    xlabel('bins');
    ylabel('Density');
    legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: normal distribution');
    
    
    %Seeing the effect of increasing bins

figure(8); 
    subplot(3,1,1)
    histogram(X1n, 10, 'Normalization','pdf');
    hold on
    r = [-4:0.1:4];
    y=normpdf(r, 0, 1); plot(r,y); 
    title('pdf approximation and theoretical pdf: normal distributon, bins = 10');
    xlabel('bins');
    ylabel('Density');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: normal distribution');


    subplot(3,1,2)
    histogram(X1n, 50, 'Normalization','pdf');
    hold on
    r = [-4:0.1:4];
    y=normpdf(r, 0, 1); plot(r,y); 
    title('pdf approximation and theoretical pdf: normal distributon, bine = 50');
    xlabel('bins');
    ylabel('Density');
    %legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: normal distribution');


    subplot(3,1,3)
    histogram(X1n, 100, 'Normalization','pdf');
    hold on
    r = [-4:0.1:4];
    y=normpdf(r, 0, 1); plot(r,y); 
    title('pdf approximation and theoretical pdf: normal distributon, bins = 100');
    xlabel('bins');
    ylabel('Density');
    legend('Actual pdf: normalized histogram of a realization of x[n]', 'Theoretical pdf: normal distribution');

