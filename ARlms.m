function [estimate, error, matrix] = ARlms(input, gain, order)
x = input; 
N = length(x); 
%initialising 
AR_data = zeros(order, N); 

estimates = zeros(1, N); 
error_v = zeros(1, N); 
for n = order+1:N
    t = n-1;
    
    a = AR_data(:, t); 
    
    est  = a' * x(n-1:-1:n-order); 
    
    e = x(n) - est; 
    
    AR_data(:, n) = AR_data(:, t) + gain*e*x(n-1:-1:n-order); 
    
    estimates(1, n) = est; 
    error_v(1, n) = e; 
    
   
end 

matrix = AR_data; 
estimate = estimates'; 
error = error_v'; 

end 