function [ratio_odd, backward_elements] = analyzerEx()
% Bookkeeping: function names should coincide with the
% filename.

% Note: we can use Ctrl+A, Ctrl+I to automatically indent
% code.
% Generate a 100-by-100 matrix where A(i,j) = i + j;
A = NaN(100); % Or, zeros/ones.
for ii = 1:100
    for jj = 1:100
        A(ii,jj) = ii + jj;
        % Note: use semicolons by default. To display
        % something, use DISP/FPRINTF.
    end
end

% Bonus question.
oneToHundred = 1:100;
% Replicate it.
rep = repmat(oneToHundred, 100, 1);
repTransposed = rep.';
% Add together.
A = rep + repTransposed;

% Calculate the percentage of elements that are odd
num_pos = sum(rem(A(:), 2) == 1);
num_elements = numel(A);
ratio_odd = num_pos / num_elements;

% Create an array of elements in backwards order
backward_elements = sort(A(:), 'descend');

