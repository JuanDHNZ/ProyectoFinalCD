%% PREPROCESSING
clear all;
%Get filenames in folder
list = dir("sports_trials");
list(1:2) = [];
%extract only file names
file_names = {list(:).name};
%take only names without extention
file_names = cellfun(@(file_names) file_names(1:end-4), file_names, 'Uniform', 0);
%Get attribute names
FID = fopen("headers.txt");
data = textscan(FID,'%s');
fclose(FID);
attr_names = string(data{:});

clear list;
clear FID;
clear data;

%amc to matrix
for i=1:length(file_names)
    folder = "sports_trials/";
    dest_folder = "sports_trials_csv/";
    fileext = ".amc";

    m = amc_to_matrix(folder + file_names(i) + fileext);
    m_t = array2table(m);
    m_t.Properties.VariableNames = attr_names;
    writetable(m_t,dest_folder + file_names(i)  + '.csv','Delimiter',',')
end
