function level = quotelevel(str, quotesymbol)
% QUOTELEVEL - Determine the enclosure depth level for text within quotes (0 = outside quotes, 1 = inside quotes)
%
%  LEVEL = vlt.string.quotelevel(STR)
%
%  For the string STR, returns an equally long array of numbers
%  LEVEL that indicates whether or not the text is inside quotes.
%
%  One can also call:
%  
%  LEVEL = vlt.string.quotelevel(STR, QUOTESYMBOL)
%
%  to specify a different symbol than '"' to be used for the quote.
%
%  Examples:
%     str = 'this is "a test" of quote depth';
%     level=vlt.string.quotelevel(str)
%
%     str2 = 'this is ''a test'' of quote depth';
%     level2=vlt.string.quotelevel(str2,'''')
%     % Note that '''' produces a single ' as a string in Matlab
%

if nargin<2,
	quotesymbol= '"';
end;

doublestr = double(str);

A = find(str==quotesymbol);
if mod(numel(A),2)~=0,
	error(['There are not an even number of quotes in the string ' str '.']);
end;

str(A(1:2:end)) = 10000;
str(A(2:2:end)) = 10001;

level = vlt.string.bracelevel(str,10000,10001); 
