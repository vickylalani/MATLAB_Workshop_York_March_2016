%% Working with Large Data.

%% Suppose we wish to solve the heat equation on a domain.
initTemp = initialTempDistrib(200);
figure
imagesc(initTemp, [20, 80])
axis square
title('Initial Temperature')

%% Save this data to disk.
% (Imagine we can only do this partially, since the data size is so large.)
U = initTemp(:, 1:101); %#ok<NASGU>
U2 = initTemp(:, 102:end);
save('InitTemp.mat', 'U', '-v7.3') 
% Only new MAT-files support partial loading/saving.
mf = matfile('InitTemp.mat', 'Writable', true);
mf.U(:, 102:202) = U2;

%% This construct now enables partial loading.
mf = matfile('InitTemp.mat');
partialU = mf.U(:, 1:5);

%% The SPMD construct.
spmd
    disp('Hello world!')
    x = 1;
    A = ones(2, 4, 'codistributed');
end
display(x)
display(A)

%% Building codistributed arrays from parts.
spmd
    % Retrieve the size of the variable stored in the MAT-file.
    s = size(mf, 'U'); 
    % Define the codistribution scheme.
    c = codistributor1d(2, [], s); % 2 - splits via columns.
    % Obtain the correct column indices for each lab.
    colIdx = globalIndices(c, 2);
    % Implement partial loading.
    localU = mf.U(:, colIdx);
    % Fuse the local (variant) arrays together to form a codistributed
    % array.
    Uco = codistributed.build(localU, c);
end
    
%% How do we apply this to an existing application?
U = heateq(200);

%% Example 1: Save the heateq function as "heateqSPMD1.m".
% Modify the initialisation command using the ones function to create a
% codistributed array. We also need to remove the internal 
% visualisation code.
spmd
    Ufinal = heateqSPMD1(200);
end
figure
imagesc(Ufinal, [20, 80])
axis square
title('Final Temperature Distribution')

%% Example 2: Save the heateq function as "heateqSPMD2.m".
% This function should load and build the initial heat distribution from
% the MAT-file created above.
spmd
    Ufinal = heateqSPMD2();
end
figure
imagesc(Ufinal, [20, 80])
axis square
title('Final Temperature Distribution')