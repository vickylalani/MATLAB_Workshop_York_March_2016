function parallelImageReadStart(filename)
% PARALLELIMAGEREAD Reads data from an image in parallel
%
% The input is the name of the file that will be read simultaneously on
% multiple labs. The image is then filtered to remove noise, and displayed
% in a figure.
%
% Example:
% parallelImageRead('MarsNoisy.tif')

% Serial version.
I = imread(filename);
figure
imshow(I, 'InitialMagnification', 25);
title('Noisy Image');

J = medfilt2(I, [4, 4]);
figure
imshow(J, 'InitialMagnification', 25);
title('Filtered Image, Processed in Serial');

% Parallel version.
% Get and display the size of the image file.
fileInfo = imfinfo(filename);
imageWidth = fileInfo.Width;
imageHeight = fileInfo.Height;
fprintf('\nImage Size: %d by %d\n', imageWidth, imageHeight);

% Specify dimensions for overlapping border.
borderWidth = 2;

spmd
  % TODO: Create a codistribution scheme using codistributor1d.
  % The width and height of the image define the total size of the object.
    
  % TODO: Identify the start and end image indices to import into each lab, 
  % using the globalIndices function with two outputs.
   
  % Take care of the overlap.
  startIndex = max(1, startIndex - borderWidth);
  endIndex = min(imageWidth, endIndex + borderWidth);
  
  % TODO: Import sections of the image on each lab into a variable
  % named localImagePart. Use the 'PixelRegion' option of IMREAD to achieve
  % this.
   
  % TODO: Filter the local data and store the output in the variable 
  % "localData". Specify a filter width that's twice as much as 
  % the border width (look at the documentation for MEDFILT2).
  
  % Unpad the data.
  if startIndex ~= 1 && endIndex ~= imageWidth
     localData = localData(:, borderWidth+1:end-borderWidth); % If we're neither at the beginning nor the end of the image, take care of overlap
  elseif startIndex == 1
     localData = localData(:, 1:end-borderWidth); % If we're at the image beginning, subtract the borderWidth
  elseif endIndex == imageWidth
     localData = localData(:, borderWidth+1:end); % If we're at the image end, add the borderWidth
  end % if
  
   % TODO: Build the codistributed array from the local data and the
   % codistribution scheme defined above.
     
end % spmd

% TODO: Display the image stored in the variable  
figure
title('Filtered Image, Processed in Parallel')
