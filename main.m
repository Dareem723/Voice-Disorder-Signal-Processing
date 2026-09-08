
[x, fs] = audioread('s_10.wav');  % Replace with  data

baseDir_1 = ""; % Stutter base dir 
baseDir_2 = "";  % Tremor base directory
baseDir_3 = "";  % Dysarthia base dir Change to your desired path


if size(x, 2) == 2
    x = mean(x, 2);
end

x = x / max(abs(x));  % Normalize the signal

% Call the method to find F0, F1, and F2
[F0, F0_amplitude, F1, F1_amplitude, F2, F2_amplitude] = analyzeFormants(x, fs);


disp(['Fundamental Frequency (F0): ', num2str(F0), ' Hz']);
disp(['F0 Amplitude: ', num2str(F0_amplitude)]);
disp(['First Formant (F1) Frequency: ', num2str(F1), ' Hz']);
disp(['F1 Amplitude: ', num2str(F1_amplitude), ' dB']);
disp(['Second Formant (F2) Frequency: ', num2str(F2), ' Hz']);
disp(['F2 Amplitude: ', num2str(F2_amplitude), ' dB']);


[F0_signal, F1_signal, F2_signal] = splitVoiceSignal(F0, F0_amplitude, F1, F1_amplitude, F2, F2_amplitude, x, fs);


simulateStuttering(F0_signal, F1_signal, F2_signal, fs, baseDir_1);


simulateTremor(F0_signal, F0_amplitude, fs, baseDir_2);


simulateDysarthria(F0_signal, F1_signal, F2_signal, fs, baseDir_3);
