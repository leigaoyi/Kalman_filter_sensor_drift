function [fre_1Hz,VSD_1Hz] = My_PSD(ad_data,fs)
data=detrend(ad_data);%去除直流分量
[PSD,f] = periodogram(data,hann(length(data)),length(data),fs,'PSD');
df=fs/2/length(f);%fs/2表示由采样定理，FFT分解得到最高频率，length（f）表示periodogram函数生成的0-fs/2之间有多少个频率点数
PSD_1Hz = zeros(1,(round(fs/2)+2));
%%%%%%%%%1Hz平均
n=round(1/df);%平均点数，表示1Hz宽度中，有多少个频率点数
f0=n*df/2;%1Hz平均后的起始频率
% f0=df/2;
for i=1:n:length(PSD)-n+1
    j=floor(i/n)+1;
    PSD_1Hz(j)=mean(PSD(i:i+n-1));
end
VSD_1Hz=sqrt(PSD_1Hz);%幅度
fre_1Hz=f0+(1:length(VSD_1Hz));%横坐标