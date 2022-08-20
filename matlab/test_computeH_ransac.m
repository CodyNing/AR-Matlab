n = 20;
I1 = imread('../data/cv_cover.jpg');
I2 = imread('../data/cv_desk.png');
% I1 = imread('../data/pano_left.jpg');
% I2 = imread('../data/pano_right.jpg');
[locs1, locs2] = matchPics(I1, I2);
[H, inliers, four_pairs ] = computeH_ransac(locs1, locs2);
pairs1 = locs1(four_pairs, :);
pairs2 = locs2(four_pairs, :);
inliers1 = locs1(inliers, :);
inliers2 = locs1(inliers, :);
% showMatchedFeatures(I1, I2, x1l, x2(:, 1:2), 'montage');
showMatchedFeatures(I1, I2, pairs1, pairs2, 'montage'); figure
showMatchedFeatures(I1, I2, inliers1, inliers2, 'montage');