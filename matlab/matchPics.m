function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if size(I1, 3) == 3
    I1 = im2gray(I1);
end
if size(I2, 3) == 3
    I2 = im2gray(I2);
end
%% Detect features in both images
I1_corners = detectFASTFeatures(I1);
I2_corners = detectFASTFeatures(I2);

%% Obtain descriptors for the computed feature locations
[I1_desc, I1_locs] = computeBrief(I1, I1_corners.Location);
[I2_desc, I2_locs] = computeBrief(I2, I2_corners.Location);

%% Match features using the descriptors
pairs = matchFeatures(I1_desc, I2_desc, 'MatchThreshold', 10.0, 'MaxRatio', 0.68);

locs1 = I1_locs(pairs(:,1),:);
locs2 = I2_locs(pairs(:,2),:);
end

