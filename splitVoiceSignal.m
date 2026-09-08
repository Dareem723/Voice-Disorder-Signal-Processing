function [F0_signal, F1_signal, F2_signal] = splitVoiceSignal(F0, F0_amplitude, F1, F1_amplitude, F2, F2_amplitude, x, fs)
    t = (0:length(x)-1) / fs; 

    % Generate sine wave signals for F0, F1, and F2
    F0_signal = F0_amplitude * sin(2 * pi * F0 * t);  % F0 component
    F1_signal = F1_amplitude * sin(2 * pi * F1 * t);  % F1 component
    F2_signal = F2_amplitude * sin(2 * pi * F2 * t);  % F2 component
end