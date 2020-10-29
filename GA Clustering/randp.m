function X = randp(P,varargin) ;

try
    X = rand(varargin{:}) ;    
catch
    E = lasterror ;
    E.message = strrep(E.message,'rand','randp') ;
    rethrow(E) ;
end

P = P(:) ;

if any(P<0),
    error('All probabilities should be 0 or larger.') ;
end

if isempty(P) || sum(P)==0
    warning([mfilename ':ZeroProbabilities'],'All zero probabilities') ;
    X(:) = 0 ;
else
    [junk,X] = histc(X,[0 ; cumsum(P(:))] ./ sum(P)) ;
end







