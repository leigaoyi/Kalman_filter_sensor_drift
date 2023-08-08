function [fre_1Hz,VSD_1Hz] = My_PSD(ad_data,fs)
data=detrend(ad_data);%ȥ��ֱ������
[PSD,f] = periodogram(data,hann(length(data)),length(data),fs,'PSD');
df=fs/2/length(f);%fs/2��ʾ�ɲ�������FFT�ֽ�õ����Ƶ�ʣ�length��f����ʾperiodogram�������ɵ�0-fs/2֮���ж��ٸ�Ƶ�ʵ���
PSD_1Hz = zeros(1,(round(fs/2)+2));
%%%%%%%%%1Hzƽ��
n=round(1/df);%ƽ����������ʾ1Hz����У��ж��ٸ�Ƶ�ʵ���
f0=n*df/2;%1Hzƽ�������ʼƵ��
% f0=df/2;
for i=1:n:length(PSD)-n+1
    j=floor(i/n)+1;
    PSD_1Hz(j)=mean(PSD(i:i+n-1));
end
VSD_1Hz=sqrt(PSD_1Hz);%����
fre_1Hz=f0+(1:length(VSD_1Hz));%������