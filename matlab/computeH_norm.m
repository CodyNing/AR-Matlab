function [H2to1] = computeH_norm(x1, x2)

assert(size(x1, 1) == size(x2, 1));

n = size(x1, 1);

%% Compute centroids of the points
centroid1 = [mean(x1(:, 1)), mean(x1(:, 2))];
centroid2 = [mean(x2(:, 1)), mean(x2(:, 2))];
T1t = eye(3);
T2t = eye(3);
T1t(1:2,3) = -centroid1;
T2t(1:2,3) = -centroid2;

%% Shift the origin of the points to the centroid
x1t = T1t * [x1, ones(n, 1)]';
x2t = T2t * [x2, ones(n, 1)]';

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
dist1 = sqrt(sum(x1t(1:2, :).^2));
dist2 = sqrt(sum(x2t(1:2, :).^2));

m1 = mean(dist1);
m2 = mean(dist2);
scale1 = 1;
scale2 = 1;
if m1 ~= 0
    scale1 = sqrt(2) / mean(dist1);
end
if m2 ~= 0
    scale2 = sqrt(2) / mean(dist2);
end
T1s = [scale1, 0, 0;
        0, scale1, 0;
        0, 0, 1];
T2s = [scale2, 0, 0;
        0, scale2, 0;
        0, 0, 1];

%% similarity transform 1
T1 = T1s * T1t;

%% similarity transform 2
T2 = T2s * T2t;

%% Compute Homography
x1n = (T1s * x1t)';
x2n = (T2s * x2t)';
h = computeH(x1n, x2n);
%% Denormalization
H2to1 = T1 \ h * T2;
