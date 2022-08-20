function [ bestH2to1, inliers, four_pairs] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

assert(size(locs1, 1) == size(locs1, 1));

num_samples = 4;
N = 76; % assume 50%
len = size(locs1, 1);
threshold = 10;
inliers = zeros(len, 1);
max_num_inlier = 0;

if len < num_samples
    bestH2to1 = eye(3);
    return
end

for i = 1: N
    ridx = randperm(len, num_samples);
    % get random samples
    x1 = locs1(ridx, :);
    x2 = locs2(ridx, :);
    
    % use them compute H
    H = computeH_norm(x1, x2);
    
    % transform to 3 dim
    nlocs2 = [locs2, ones(len, 1)];
    % compute new x2
    nlocs1 = (H * nlocs2')';
    nlocs1 = nlocs1(:, 1:2) ./ nlocs1(:, 3);
    
    % compute distance
    diff = nlocs1 - locs1;
    dist = sqrt(sum(diff, 2).^2);
    iidx = dist < threshold;
    if sum(iidx) > max_num_inlier
        max_num_inlier = sum(iidx);
        inliers = iidx;
        four_pairs = ridx;
    end
end
if max_num_inlier == 0
    bestH2to1 = eye(3);
else
    nlocs1 = locs1(inliers, :);
    nlocs2 = locs2(inliers, :);
    bestH2to1 = computeH_norm(nlocs1, nlocs2);
end

end

