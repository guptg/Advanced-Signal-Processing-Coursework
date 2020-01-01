function PGM = pgm(random_process)

PGM = ((abs(fft(random_process))).^2 )/length(random_process); 

end 