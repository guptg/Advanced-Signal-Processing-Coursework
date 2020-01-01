% Cross correlation function

x = randn(1000,1); 
y = filter(ones(9, 1), [1], x);

Rxy = xcorr(x,y,'unbiased');

figure(1); 
stem(-999:999,Rxy); 
title('CCF estimate of WGN and WGN filtered by MA order 9')
xlabel('Lag \tau')
ylabel('estimated R_x_y(\tau)')
zoom xon
zoom(50)
