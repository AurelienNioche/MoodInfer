%% filter code for the heart beating
file = load('dataset.mat'); %% load data
dataset_laser = file.dataset;
sz = size(dataset_laser);
N_people = sz(1); %number of people
N_rec = sz(2); %number of recordings for each person
N_samp = sz(3);% number of samples per recording 

f_sample =1500; %sampling frequency
%parameters of the filter
low_stop = 20; 
high_stop = 700;

d_st = fdesign.bandpass('N,F3dB1,F3dB2',8,low_stop,high_stop,f_sample);
Hd_st = design(d_st,'butter');
%% filtering
filtered_dataset = filter(Hd_st,permute(dataset_laser,[3,1,2]));
%% Normalize the amplitude to [-1 1]
for i = 1:N_people
    for j = 1:N_rec
        filtered_dataset_Normalized(:,i,j) = rescale(filtered_dataset(:,i,j),-1,1);
    end
end
%% plot 3s data for subject 01 and repetition 01
figure
plot(filtered_dataset_Normalized(1:4410,1,1));
xlabel('time');
ylabel('amplitude');

