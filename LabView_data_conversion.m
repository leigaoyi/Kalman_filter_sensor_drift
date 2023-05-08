function [time,data_out] = LabView_data_conversion(data_in,fs)
data_in = data_in';
[m,n] = size(data_in);
ADC_sample = zeros(1,m*n);
for i = 1:m*n
    ADC_sample(i) = data_in(i);
end
data_out = ADC_sample;
time = (1:length(data_out))/fs;
