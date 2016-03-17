% %% MAT-file objects allow partial saving/loading.
% A = rand(1000);
% save('MyMAT', 'A', '-v7.3') % Save to disk (partial loading/saving only works for version 7.3 onwards (2006)).
% 
% % %% Partial loading.
% % mf = matfile('MyMAT');
% % partialA = mf.A(1:100, 1:100); % Top-left 100-by-100 block.

%% How to work out the chunks automatically?
mf = matfile('MyMAT');
spmd
    % Step 1: Define the distribution scheme.
    % Dimension 2: split by columns.
    % [] - work out partition automatically
    % size(mf, 'A') - return size of A without loading in A
    sz = size(mf, 'A');
    c = codistributor1d(2, [], sz);
    
    % Step 2: Compute the local indices for each lab.
    idx = globalIndices(c, 2);
    % e.g. if A is 1000-by-1000, we expect idx to be 1:250 on lab 1,
    % 251:500 on lab 2, 501:750 on lab 3 and 751:1000 on lab 4.
    
    % Step 3: Partial loading (note that not all indexing commands are
    % supported by MAT-file objects, e.g. :, 1:end is not supported).
    partialA = mf.A(1:sz(1), idx);
    % (Exists separately on each lab - not codistributed).
    
    % Step 4: "Glue" the pieces together into a codistributed array.
    codisA = codistributed.build(partialA, c);
    
end