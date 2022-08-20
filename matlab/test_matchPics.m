% I1 = imread('../data/cv_cover.jpg');
% I2 = imread('../data/cv_desk.png');
I1 = imread('../data/pano_left.jpg');
I2 = imread('../data/pano_right.jpg');
[locs1, locs2] = matchPics(I1, I2);
showMatchedFeatures(I1, I2, locs1, locs2, 'montage')