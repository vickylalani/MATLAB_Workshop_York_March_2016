function U = heateqSPMD2()

diffusivity = 1.13e-4;              % thermal diffusivity of copper
width = 1;                          % side length of plate

% Initialize square grid with starting temperatures
U = initialTempDistrib();

% Calculate the mesh spacing
nPoints = size(U, 2) - 2;
dWidth = width/nPoints;

% Length and number of time steps
dt = dWidth^2/(4*diffusivity);      % time step that ensures stability
Tend = 60;                          % simulate 1 minute
numIter = round(Tend/dt);  

% Calculate the coordinates for the neighboring grid points
nInnerRows = nPoints; % square plate
nInnerCols = nPoints;
idxRow = 2:(nInnerRows + 1);
idxCol = 2:(nInnerCols + 1);
north = idxRow - 1;
south = idxRow + 1;
west = idxCol - 1;
east = idxCol + 1;

% Perform time steps
for iter = 1:numIter
    U(idxRow,idxCol) = U(idxRow,idxCol) + diffusivity * dt/(dWidth^2) * ...
        ( U(north,idxCol) + U(idxRow,west) - 4*U(idxRow,idxCol) + ...
        U(idxRow,east) + U(south,idxCol) );    
end

end % heateq

function Uinit = initialTempDistrib()

% Open MAT-file reference.
mf = matfile('InitTemp.mat');

% Size of data.
s = size(mf, 'U');

% Codistribution scheme.
c = codistributor1d(2, [], s);

% Indices.
colIdx = globalIndices(c, 2);

% Local parts.
localU = mf.U(:, colIdx);

% Build codistributed array.
Uinit = codistributed.build(localU, c);
    
end % function
