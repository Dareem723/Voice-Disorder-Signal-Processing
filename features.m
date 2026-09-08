
folder_path = '';  % Replace with your folder path for each disorder
filename='dysarthiafeatures.csv';
classname='dysarthia';


audio_files_wav = dir(fullfile(folder_path, '*.wav'));
audio_files_mp3 = dir(fullfile(folder_path, '*.mp3'));


audio_files = [audio_files_wav; audio_files_mp3];
num_files = length(audio_files);
feature_table = cell(num_files, 18);  % Adjust based on the number of features

% Loop through each audio file
for i = 1:num_files
    
    file_name = audio_files(i).name;
    file_path = fullfile(folder_path, file_name);
    [audio, fs] = audioread(file_path);
    
    
    coeffs = mfcc(audio, fs, 'NumCoeffs', 13);
    mfcc_mean = mean(coeffs, 1);  % Mean of MFCCs
    
    
    zcr = sum(abs(diff(audio > 0))) / length(audio);
    
    
    f0 = pitch(audio, fs, 'Range', [50 500]);
    f0_mean = mean(f0);
    
    
    energy = rms(audio);
    
    
    feature_table{i, 1} = file_name; 
    feature_table{i, 2} =  classname;  
    
    
    for mfcc_idx = 1:13
        feature_table{i, 2 + mfcc_idx} = mfcc_mean(mfcc_idx);
    end
    
    
    feature_table{i, 16} = zcr;
    feature_table{i, 17} = f0_mean;
    feature_table{i, 18} = energy;
end


feature_table = cell2table(feature_table, 'VariableNames', ...
    {'filename', 'class', 'mfcc_1', 'mfcc_2', 'mfcc_3', 'mfcc_4', 'mfcc_5', 'mfcc_6', 'mfcc_7', ...
     'mfcc_8', 'mfcc_9', 'mfcc_10', 'mfcc_11', 'mfcc_12', 'mfcc_13', 'zcr', 'f0_mean', 'energy'});

% Save the features to a CSV file
writetable(feature_table, filename);
disp('Feature extraction complete and saved to audio_features.csv');
