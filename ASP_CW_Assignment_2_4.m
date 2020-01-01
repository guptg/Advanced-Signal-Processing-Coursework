%% 2.4.1a AR model 

close all; clear all; clc; 

%Loading the historical time series of the NASDAQ financial index, which
%represents end of day prices for the index between Jone 2003 and Feb 2007 

load NASDAQ.mat;

%Show that AR(1) model is sufficient to describe daily returns of the
%index. HINT: use metrics such as partial correlation and information
%theoretic criteria (AIC, MDL) to support your answer 


data = NASDAQ.Close; 

sample_mean = mean(data); %Standardizing the data 
sample_std = std(data); 
closing_prices = (data - sample_mean)./sample_std; 

%Obtaining patial correlation

akk = []; 

for i = 1:10
    A = aryule(closing_prices, i); 
    akk = [akk A(i+1)];     %The PACs are the last elements in the array of a coefficents determined by the Y-W eqns 
end 

figure(1); 
stem(1:10, akk) 
title('Partial Autocorrelation function');
xlabel('Lag \tau')
ylabel('PAC')

%Obtaining theoretic criteria (AIC, MDL)

N = length(closing_prices);

MDL = [];
AIC = [];
Error = [];


for i = 1:25
   
   [a, E] = aryule(closing_prices, i);
   MDL = [MDL (log(E) + (i*log(N)/N))];
   AIC = [AIC (log(E) + 2*i/N)]; 
   Error = [Error log(E)];
end

figure(2);
plot(MDL);
hold on;
plot(AIC, 'r');
plot(Error, 'g')
legend('MDL','AIC', 'Cumulative Squared Error');
xlabel('Model Order');
ylabel('Model Error');
title('MDL, AIC and Cumulative Squared Error');


%% 2.4.1 c) 
close all; clear all; clc; 

load NASDAQ.mat;

data = NASDAQ.Close; 

sample_mean = mean(data); %Standardizing the data 
sample_std = std(data); 
closing_prices = (data - sample_mean)./sample_std; 

%Getting values of a1 and the "true variance" as [a,e]= aryule(x,p) returns the estimated variance, e, of the white noise input.


% a = aryule(closing_prices,1);
% a1 = -a(2); %a1 is determined from the time series data 

CRLBsig = [];
CRLBa1 = []; 

a = aryule(closing_prices,1);

for N = 1:50:1001
    
    a1 = -a(2);
    CRLBa1 = [CRLBa1 (1-a1^2)/N];
    CRLBsig = [CRLBsig (2*(N)^2)/N];  %value range of sigma2 is the same as value range of N 
end 
    
%In separate figures, plot the CRLB for both unknown parameters against the
%number of data points 

figure(3); 
plot(1:50:1001, 10*log10(CRLBsig), 'o'); 
xlabel('Number of data samples, N');
ylabel('CRLB (dB)'); 
title('CRLB for unknown vector paramater \sigma^2'); 
xlim([0 1001]); 


figure(4);
plot(1:50:1001, 10*log10(CRLBa1), 'o'); 
xlabel('Number of data samples, N');
ylabel('CRLB (dB)'); 
title('CRLB for unknown vector paramater a_1'); 
xlim([0 1001]); 

a = aryule(closing_prices,1);
a1 = -a(2);
vara1 = (1-a1^2)/924; 

% cdata = [45 60 32; 43 54 76; 32 94 68; 23 95 58];
% xvalues = {'Small','Medium','Large'};
% yvalues = {'Green','Red','Blue','Gray'};
% h = heatmap(xvalues,yvalues,cdata);

CRLBsig = [];
CRLBa1 = []; 

a = aryule(closing_prices,1);
a1 = -a(2);

for N = 1:50:1001
    CRLBa1 = [CRLBa1 (1-a1^2)/N];
    for sig = 1:50:1001
    CRLBsig = [CRLBsig (2*(sig)^2)/N];  
    end 
end 

table_CRLBsig = []; 

for i = 441:-21:1
    X= CRLBsig(i-20:i);
    table_CRLBsig = [table_CRLBsig ;X];
end 

table_CRLBa1 = [];
for i = 1:21
    X= CRLBa1;
    table_CRLBa1 = [table_CRLBa1 ;X];
end 
    
figure(5); 
cdata = 10*log10(table_CRLBsig); 
xvalues = 1:50:1001;
yvalues = 1001:-50:1;
h = heatmap(xvalues,yvalues,cdata);
h.Colormap = parula; 
xlabel('N');
ylabel('sigma^2');
title('CRLB (dB) for unknown vector paramater sigma^2'); 

figure(6); 
cdata = 10*log10(table_CRLBa1); 
xvalues = 1:50:1001;
yvalues = 1001:-50:1;
h = heatmap(xvalues,yvalues,cdata);
h.Colormap = parula; 
title('CRLB (dB) for unknown vector paramater a1'); 
xlabel('N');
ylabel('sigma^2');
