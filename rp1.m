function v=rp1(M,N)             %Function takes in parameters M and N for M realizations of the ensemble and N number of samples for each realization (length)
a=0.02;
b=5;
Mc=ones(M,1)*b*sin((1:N)*pi/N); %ones is a column vector multiplied by the scalar b and the following ro sin vector. This returns a M*N matrix where each row is the same 
Ac=a*ones(M,1)*[1:N];           %column vector with M rows and each element of the value a is multiplied by a row vector , returns a M*N matrix where each row is the same (i.e. 0.02. 0.04...2)
v=(rand(M,N)-0.5).*Mc+Ac;       %Random noise is incoorperated by multiplying each element in Mc by the corrospinding random noise element, this matrix is then added to Ac
end                             %v is a matrix where each row is a realization of the random process 