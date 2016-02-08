function [bestPercentMatch, matchStartIndex] = findsubstr(baseString, searchString)
% FINDSUBSTR Finds the closest match for search string in larger string.
%
%   [BESTPERCENTMATCH, MATCHSTARTINDEX] = FINDSUBSTR(BASESTRING,
%	SEARCHSTRING) Locates the best match for SEARCHSTRING within
%	BASESTRING, returning the percentage of characters that match and the
%	starting index for the best match within BASESTRING.
%
%   Example:
%       baseString = 'abcdefghijklmnopqrstuvwxyz';
%       [bpm, msi] = findsubstr(baseString, 'abc')
%
%       returns bpm = 100, msi = 1
%
%
%       [bpm, msi] = findsubstr(baseString, 'wayz');
%
%       returns bpm = 75, msi = 23;
%       


% Default the match parameters to 0
bestPercentMatch = 0;
matchStartIndex = 0;

for startIndex = 1:(length(baseString) - length(searchString) + 1)
    
    % Extract the current section of the base string
    currentSection = baseString(startIndex:startIndex + length(searchString) - 1);
    
    % Determine the percentage of letters that match
    percentMatch = 100 * nnz(currentSection == searchString) / length(searchString);
    
    % If the current match reaches or exceeds the threshold, return
    if percentMatch >= bestPercentMatch
        bestPercentMatch = percentMatch;
        matchStartIndex = startIndex;
    end
    
end