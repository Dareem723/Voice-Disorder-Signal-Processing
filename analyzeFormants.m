%% Method to Analyze Formants
function [F0, F0_amplitude, F1, F1_amplitude, F2, F2_amplitude] = analyzeFormants(x, fs)
    % Fundamental Frequency (F0) Calculation using Autocorrelation Method
    [acf, lags] = xcorr(x);
    acf = acf(lags >= 0);
    lags = lags(lags >= 0);
    
    % Find the first peak in the autocorrelation after the zero lag
    [~, loc] = max(acf(ceil(fs/500):ceil(fs/50)));  % Typical F0 ranges from 50 to 500 Hz
    lag = lags(loc + ceil(fs/500) - 1);
    
    % Calculate the fundamental frequency (F0)
    F0 = fs / lag;
    
    % Amplitude Envelope Calculation using Hilbert Transform
    analytic_signal = hilbert(x);  % Hilbert transform to get the analytic signal
    amplitude_envelope = abs(analytic_signal);  % Instantaneous amplitude
    F0_amplitude = max(amplitude_envelope);  % Peak amplitude

    % Formant Frequency Calculation using LPC (for F1 and F2)
    order = 12;  % LPC order (typically 8-12 for speech signals)
    a = lpc(x, order);  % Perform LPC analysis
    [H, w] = freqz(1, a, 512, fs);  % Frequency response
    PSD = 20*log10(abs(H));  % Power spectral density
    
    % Find the peaks in the power spectrum
    [pks, locs] = findpeaks(PSD, w);
    
    % Initialize formant frequencies and amplitudes
    F1 = NaN; F1_amplitude = NaN; F2 = NaN; F2_amplitude = NaN;

    % Check if there are enough peaks
    if length(locs) >= 2
        % Identify the first formant (F1)
        F1 = locs(1);  % First peak corresponds to F1
        F1_amplitude = pks(1);  % Amplitude at F1 frequency
        
        % Identify the second formant (F2)
        F2 = locs(2);  % Second peak corresponds to F2
        F2_amplitude = pks(2);  % Amplitude at F2 frequency
    else
        disp('Could not find enough formants in the signal.');
    end
end