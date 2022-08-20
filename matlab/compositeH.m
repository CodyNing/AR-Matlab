function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
H_template_to_img = inv(H2to1);

composite_img = img;
%% Create mask of same size as template
mask = true(size(template));

%% Warp mask by appropriate homography
warped_mask = warpH(mask, H_template_to_img, size(img));

%% Warp template by appropriate homography
warped_template = warpH(template, H_template_to_img, size(img));

%% Use mask to combine the warped template and the image
composite_img(warped_mask) = warped_template(warped_mask);

end