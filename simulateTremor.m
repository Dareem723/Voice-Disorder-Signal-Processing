function simulateTremor(F0_signal, F0_amplitude, fs, baseDir)
    % Define tremor parameters
    ft = 6;  % Tremor frequency (Hz)
    
    duration = length(F0_signal) / fs;  
    
    % Generate time vector for the entire signal length
    t = linspace(0, duration, length(F0_signal));  

    % Generate the tremor signal
    tremor_signal = F0_amplitude * sin(2 * pi * F0_signal .* t) .* (1 + 0.1 * sin(2 * pi * ft * t));

    % Normalize the tremor signal to avoid clipping
    tremor_signal = tremor_signal / max(abs(tremor_signal));

    % Check lengths of the signals
    fprintf('Length of F0_signal: %d samples\n', length(F0_signal));
    fprintf('Length of tremor_signal: %d samples\n', length(tremor_signal));
    
    % Generate incremental filename
    baseFileName = 'tremor_signal';
    fileExtension = '.mp3';
    counter = 1;  % Initialize counter for file naming
    outputFile = fullfile(baseDir, [baseFileName, num2str(counter), fileExtension]);

    % Check for existing files and increment the filename
    while exist(outputFile, 'file')
        counter = counter + 1;
        outputFile = fullfile(baseDir, [baseFileName, num2str(counter), fileExtension]);
    end

    % Save the simulated tremor signal as an MP3 file
    audiowrite(outputFile, tremor_signal, fs);
    fprintf('Tremor signal saved as: %s\n', outputFile);
end
