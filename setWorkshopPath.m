function setWorkshopPath()

rootDir = fileparts(which(mfilename));

foldersToAdd = {'', 'Data', 'Exercises', 'Reference'};

for k = 1:numel(foldersToAdd)
    addpath(genpath([rootDir, filesep, foldersToAdd{k}]))
end

end