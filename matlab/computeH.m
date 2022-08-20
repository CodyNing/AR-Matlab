function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
assert(size(x1, 1) == size(x2, 1));

A = double(zeros(size(x1, 1) * 2, 9));
for i = 1: size(x1, 1)
    rowi = (i - 1) * 2 + 1;
    A(rowi, :) = [-x2(i, 1), -x2(i, 2), -1, 0, 0, 0, x2(i, 1) * x1(i, 1), x2(i, 2) * x1(i, 1), x1(i, 1)];
    A(rowi + 1, :) = [0, 0, 0, -x2(i, 1), -x2(i, 2), -1, x2(i, 1) * x1(i, 2), x2(i, 2) * x1(i, 2), x1(i, 2)];
end
[U, S, V] = svd(double(A));
H2to1 = V(:, 9);
% H2to1 = H2to1 / H2to1(9);
H2to1 = reshape(H2to1, 3, 3)';