function stuttered_signal = simulateStuttering(F0_signal, F1_signal, F2_signal, fs, baseDir)
    % Define parameters 
    N = 3;  % Number of repetitions
    stuttered_signal = zeros(size(F0_signal));  % Initialize stuttered signal
    duration = length(F0_signal);  % Duration of the original signal

    % Create random interruption points
    interrupt_points = randi([1, duration-1], 1, N);  % Random indices for interruptions

    for i = 1:N
        % Calculate the segment to be repeated
        segment_start = interrupt_points(i);
        segment_end = min(segment_start + fs, duration);  % Limit segment end to duration
        segment = F0_signal(segment_start:segment_end) + F1_signal(segment_start:segment_end) + F2_signal(segment_start:segment_end);
        
        % Insert the repeated segment at the interrupt point
        stuttered_signal(segment_start:segment_end) = stuttered_signal(segment_start:segment_end) + segment;
    end

    % Normalize 
    stuttered_signal = stuttered_signal / max(abs(stuttered_signal));
    
    % filing
    baseFileName = 'stuttered';  
    fileExtension = '.mp3';  
    fileIndex = 1;  

    
    while true
        outputPath = fullfile(baseDir, [baseFileName, '_', num2str(fileIndex), fileExtension]);  
        if ~isfile(outputPath) 
            break;  
        end
        fileIndex = fileIndex + 1;  % Increment 
    end

   
    audiowrite(outputPath, stuttered_signal, fs);
    
    disp(['Stuttered signal saved as: ', outputPath]);
end
