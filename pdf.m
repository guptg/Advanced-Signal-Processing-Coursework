function x=pdf(v)
x = histogram(v, 30, 'Normalization','pdf');
%NOTE: using the function histogram because it is a more updated function
%for hist and its basically better (Learned this in bioeng DSP) 
xlabel('bins');
ylabel('Probability density');
end