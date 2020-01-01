function [estimate, error, matrix] = lms_gs(input, output, gain, Nw)

order = Nw + 1; 
x = input; 
z = output;

N = length(x); 

%initialising 

W_data = zeros(order, N); 

s = 0;

estimates = zeros(1, N); 

error_v = zeros(1, N); 


for n = order:N
    t = n-1;
    
    est = W_data(:, t)'*x(order+s:-1:s+1); 
    
    e = z(order+s) - est; 
    
    g = e/z(order+s);
    
    if g <= 0.1
        gain = 0.02;
    end 
    
    W_data(:, n) = W_data(:, t) + gain*e*x(order+s:-1:s+1); 
    
    estimates(1, n) = est; 
    error_v(1, n) = e; 
    
    s = s+1; 
    
end 

matrix = W_data; 
estimate = estimates'; 
error = error_v'; 

end 