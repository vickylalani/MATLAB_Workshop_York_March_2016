function U = heateqGPU(nPoints)
% HEATEQ Solves the 2D heat equation
%
%    U = HEATEQ(nPoints)  returns a matrix U representing the
%    temperature at each row, column location.
%    The function discretizes a 2D square copper (thermal diffusivity =
%    1.13e-4) plate of length L = 1 by using nPoints points and computes
%    the temperature distribution after Tend = 60.
%    Note: the computation time will be proportional to nPoints^3 since
%    it's a 2D grid and a finer grid results in smaller time steps.
%
%    Example: Computation with 100 grid points
%    U = heateq(100);
%    imagesc(U)

diffusivity = 1.13e-4;              % thermal diffusivity of copper
width = 1;                          % side length of plate

% Calculate the mesh spacing
dWidth = width/nPoints;

% Length and number of time steps
dt = dWidth^2/(4*diffusivity);      % time step that ensures stability
Tend = 60;                          % simulate 1 minute
numIter = round(Tend/dt);  

% Initialize square grid with starting temperatures
U = initialTempDistrib(nPoints);

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

function Uinit = initialTempDistrib(nPoints)

% Initialize the grid at room temperature.
roomTemp = 23;
Uinit = roomTemp * ones(nPoints+2, 'gpuArray');
% (Build the initial matrix directly on the GPU.)

% Center and radius of the coffee cup.
gridCenter = round(size(Uinit)/2); % The middle of the grid.
cupRadiusSq = round(size(Uinit, 1)/4).^2; % A quarter of the grid dimension, squared.

% Assume that placing the cup on the grid provides an initial heat
% distribution at the immediate contact points. In reality, placing the cup of
% coffee on the grid defines an initial annulus (ring band) of heat,
% hottest at the immediate contact points and tapering off at the edges of
% the annulus.

% Define the semi-bandwidth of the annulus.
semiBandWidthSq = round(size(Uinit, 1)/10).^2; % 10% of the grid dimension, squared.

% Coffee cup parameters.
nHeatBands = 25;
cupLowerTemp = 50;
cupUpperTemp = 80;
bandTemps = linspace(cupLowerTemp, cupUpperTemp, nHeatBands);
inner = cupRadiusSq - semiBandWidthSq;
outer = cupRadiusSq + semiBandWidthSq;

% Pre-compute squared distances from grid points to the centre of the annulus.
x = 1:nPoints+2;
[X, Y] = meshgrid(x, x);
D = (X - gridCenter(2)).^2 + (Y - gridCenter(1)).^2;

% Initialize the bands of heat caused by the placement of the cup.
for k = 1:nHeatBands
    inBands = ( D >= inner + semiBandWidthSq * (k-1)/nHeatBands & ...
                D <= inner + semiBandWidthSq * k/nHeatBands )  | ...
              ( D >= cupRadiusSq + semiBandWidthSq * (1-k/nHeatBands) & ...
                D <= outer + semiBandWidthSq * (1-(k-1)/nHeatBands) );
    Uinit(inBands) = bandTemps(k);
end % for
    
end % function
