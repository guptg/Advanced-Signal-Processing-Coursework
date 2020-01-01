function v=rp2(M,N)
Ar=rand(M,1)*ones(1,N);   %Produces a matrix a M*N matrix where each row has the same realization and each realization is a sequence of random numbers 
Mr=rand(M,1)*ones(1,N);   %Same as above 
v=(rand(M,N)-0.5).*Mr+Ar; %each element in Mr is multiplied by a different random number and then added with Ar 
end 

