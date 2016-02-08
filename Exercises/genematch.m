function [bestPercentMatch, matchStartIndex] = genematch(searchSeq, txtFileName, startIndex, endIndex)
% GENEMATCH Searches for best sequence match in a DNA string
% 
%   [bestPercentMatch, matchStartIndex] = ...
%               genematch(searchSeq, txtFileName, startIndex, endIndex)
%   locates the closest match for searchSeq in a DNA sequece existing in
%   txtFileName.  Returns the percentage of the sequence that matches as 
%   well as the index for the start of the match in the DNA sequence.
%   Optional arguments allow for a segment of the DNA sequence between
%   startIndex and endIndex to be searched.
%
%   Example:
%       [bpm, msi] = genematch('gattaca', 'gene.txt');
%

% Read the sequence
fid = fopen(txtFileName, 'rt');
geneSeq = fscanf(fid, '%c');
fclose(fid);

% Default the start and end index if values not provided
if nargin < 3
    startIndex = 1;
end

if nargin < 4
    endIndex = length(geneSeq);
end

% Search for the substring
[bestPercentMatch, matchStartIndex] = findsubstr(geneSeq(startIndex:endIndex), searchSeq);