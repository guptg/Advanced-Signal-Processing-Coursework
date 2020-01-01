%1.3.0 Estimation of probability distributions 

%% 1.3.1 pdf estimate function 

v = randn(1, 1000);
figure(1); pdf(v); title('Gaussian pdf estimate of a random variable')

%% 1.3.2 pdf with increasing N for rp 3 

v1 = rp3(1,100);
v2 = rp3(1,1000);
v3 = rp3(1,10000);

% The estimated pdf is 1/3 because LOGIC 

figure(2);
subplot(3,1,1); 
    pdf(v1);
    hold on
    a=-1; b=2; y=unifpdf(v1,a,b); plot(v1,y);
    title('pdf approximation and theoretical pdf N = 100')
subplot(3,1,2); 
    pdf(v2);
    hold on
    a=-1; b=2; y=unifpdf(v2,a,b); plot(v2,y);
    title('pdf approximation and theoretical pdf N = 1000')
subplot(3,1,3); 
    pdf(v3); 
    hold on
    a=-1; b=2; y=unifpdf(v3,a,b); plot(v3,y);
    title('pdf approximation and theoretical pdf N = 10000')
    legend('pdf estimate', 'Theoretical pdf');
%% 1.3.3 pdfs of nonstationary processes 

figure(3);
%NOTE: changed a to 0.002 in rp1 function 
v4 = rp1(1,100);
v5 = rp1(1,1000);
v6 = rp1(1, 10000);

subplot(3,1,1);
    pdf(v4); 
    title('pdf estimate for random process 1, N = 100')

subplot(3,1,2);
    pdf(v5); 
    title('pdf estimate for random process 1, N = 1000')

subplot(3,1,3);
    pdf(v6); 
    title('pdf estimate for random process 1, N = 10000')



