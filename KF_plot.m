%%
clear
clc
close all
C1_sin_data = load('KF_y.txt');
C1_cos_data = load('yMeasure.txt');
%%
%fs = 100e3/25;
fs = 1000;
[C1_sin_time,adc_data_voltage] = LabView_data_conversion(C1_sin_data,fs);
C1_sin_adc_data_voltage = adc_data_voltage;%(end-40*fs+1:end);
[C1_cos_time,adc_data_voltage] = LabView_data_conversion(C1_cos_data,fs);
C1_cos_adc_data_voltage = adc_data_voltage;%(end-40*fs+1:end);
% plot(C1_sin_time,adc_data_voltage)
%% 功率谱密度分析
figure(2)
[C1_sin_fout_1Hz,C1_sin_PSD_1Hz] = My_PSD(C1_sin_adc_data_voltage,fs);
semilogy(C1_sin_fout_1Hz,C1_sin_PSD_1Hz,'LineWidth',1.5);
xlim([1,100]);
grid on
hold on
[C1_cos_fout_1Hz,C1_cos_PSD_1Hz] = My_PSD(C1_cos_adc_data_voltage,fs);
semilogy(C1_cos_fout_1Hz,C1_cos_PSD_1Hz,'LineWidth',1.5);
xlabel('Frequency/Hz','FontSize',12,'FontWeight','normal');
ylabel('Amplitude mV/Hz^{1/2}','FontSize',12,'FontWeight','normal');
% Add legend
legend('KF estimate', 'Measurement');
set(gca,'FontSize',12);
