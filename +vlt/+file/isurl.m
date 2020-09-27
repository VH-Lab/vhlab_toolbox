function b = isurl(inputstring)
% ISURL - Does this string point to a URL?
%
% B = vlt.file.isurl(INPUTSTRING)
%
% Returns 1 if the string contains '://'. Returns 0 otherwise.
%

b = ~isempty(strfind(inputstring,'://'));


