function simulateDysarthria(F0_signal, F1_signal, F2_signal, fs, baseDir)
    % Calculate the dysarthria signal
    dysarthria_signal = 0.5 * (F0_signal + 0.7 * F1_signal + 0.6 * F2_signal);

    % Normalize the dysarthria signal
    dysarthria_signal = dysarthria_signal / max(abs(dysarthria_signal));

    % Find the next available filename
    existingFiles = dir(fullfile(baseDir, 'dysarthria_*.mp3'));
    if isempty(existingFiles)
        nextFileNum = 1;  % Start from 1 if no files exist
    else
        fileNumbers = zeros(1, length(existingFiles));
        for i = 1:length(existingFiles)
            numStr = regexp(existingFiles(i).name, '\d+', 'match');
            if ~isempty(numStr)
                fileNumbers(i) = str2double(numStr{1});  % Convert to double
            end
        end
        nextFileNum = max(fileNumbers) + 1;  % Increment the highest number
    end

    % Generate the output file name
    outputFile = fullfile(baseDir, ['dysarthria_', num2str(nextFileNum), '.mp3']);

    % Save the dysarthria simulation to MP3
    audiowrite(outputFile, dysarthria_signal, fs);

    % Indicate the file has been saved
    disp(['Dysarthria simulation saved to: ', outputFile]);
end
