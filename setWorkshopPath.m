function setWorkshopPath()

rootDir = fileparts(which(mfilename));

foldersToAdd = {'', 'Data', 'Exercises', 'Reference', 'York files'};

for k = 1:numel(foldersToAdd)
    addpath(genpath([rootDir, filesep, foldersToAdd{k}]))
end

end