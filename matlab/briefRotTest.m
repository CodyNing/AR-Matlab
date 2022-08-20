% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
img = im2gray(imread('../data/cv_cover.jpg'));

%% Compute the features and descriptors
corners = detectFASTFeatures(img);
[desc, locs] = computeBrief(img, corners.Location);
% corners = detectSURFFeatures(img);
% [desc,locs] = extractFeatures(img, corners, 'Method', 'SURF');

counts = zeros(37, 1);
rori = randperm(36, 3);
for i = 0:36
    %% Rotate image
    r_img = imrotate(img, 10 * i);
    
    %% Compute features and descriptors
    r_corners = detectFASTFeatures(r_img);
    [r_desc, r_locs] = computeBrief(r_img, r_corners.Location);
%     r_corners = detectSURFFeatures(r_img);
%     [r_desc, r_locs] = extractFeatures(r_img, r_corners, 'Method', 'SURF');
    
    %% Match features
    pairs = matchFeatures(desc, r_desc, 'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    
    %% Update histogram
    counts(i + 1) = size(pairs, 1);
    
    if ismember(i, rori)
        locs1 = locs(pairs(:,1),:);
        locs2 = r_locs(pairs(:,2),:);
        figure;
        showMatchedFeatures(img, r_img, locs1, locs2, 'montage');
    end
end

%% Display histogram
figure;
bar(counts);
xticks(0:1:37)
xticklabels({'', 0:10:360});
xlabel('Rotation Degree');
ylabel('Matching Count');