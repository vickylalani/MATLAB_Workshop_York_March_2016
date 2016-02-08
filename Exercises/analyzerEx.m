function [percent_odd, backward_elements] = analyzerEx

% Generate a 100-by-100 matrix where A(i,j) = i + j;
% for ii = 100:-1:1
%     for jj = 100:-1:1
%         A(ii,jj) = ii + jj;
%     end
% end
% Method 1: MESHGRID.
[X, Y] = meshgrid(1:100, 1:100);
A = X + Y;
% Method 2: Matrix multiplication.
A = (1:100).' * ones(1, 100) + ones(100, 1) * (1:100);
% Method 3: REPMAT.
A = repmat(1:100, 100, 1) + repmat((1:100).', 1, 100);
% Method 4: CUMSUM.
A = cumsum(ones(100)) + cumsum(ones(100), 2);
% Method 5: BSXFUN.
A = bsxfun(@plus, 1:100, (1:100).');














% Calculate the percentage of elements that are odd
num_pos = sum(rem(A(:), 2) == 1);
num_elements = numel(A);
percent_odd = 100*num_pos/num_elements;

% Create an array of elements in backwards order
backward_elements = sort(A(:), 'descend');

