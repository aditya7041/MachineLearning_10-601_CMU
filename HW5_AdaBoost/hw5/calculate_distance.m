% inputs are A and B matrix of certain dimension.
function [ dis ] = calculate_distance(A,B)
dis = sum(abs(minus(A,B)).^2).^.5;
end

