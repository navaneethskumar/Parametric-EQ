

buffer_size = 4096;
[wav, fs] = audioread("alone-rework.wav");
wav = wav(:,1) + wav(:,2);
wav = wav(1:10*fs,1);

wav_buffer = buffer(wav, buffer_size);
f_center=1000;
ratio=0.5;
Q = 0.3;
gain = 12.0;


output = zeros(size(wav_buffer, 1)*size(wav_buffer,2),1);

obj1 = parametricEQ(f_center,Q,gain,fs); 


for i = 1:size(wav_buffer, 2)
    start_ind = (i-1)*4096 + 1; 
    stop_ind = start_ind + 4095;

[output(start_ind:stop_ind,1)] = obj1.processAudio(wav_buffer(:,i));

end 
figure;
plot((output));
figure;
spectrogram(output,1024,512,512,fs);
soundsc(output, fs);
