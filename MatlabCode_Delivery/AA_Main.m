%% Data loading
clear all, close all, clc

load('MRIdata.mat');
img_3d= vol; 

% ref = im2double(imread("Reference.png"));
% figure; imshow(ref, []); title('Reference frame');

img_x = size(img_3d,1);
img_y = size(img_3d,2);
img_z = size(img_3d,3);

pix_x = pixdim(1);
pix_y = pixdim(2);
pix_z = pixdim(3);

sag_area_cm = (pix_x*img_x)*(pix_z*img_z)/1000;
cor_area_cm = (pix_y*img_y)*(pix_z*img_z)/1000;
ax_area_cm = (pix_x*img_x)*(pix_y*img_y)/1000;

voxel_vol = pix_x*pix_y*pix_z;

%% Visualize planes
px = 'coronal'; x = extract_slice(img_3d, px, img_x/2);
py = 'sagittal'; y = extract_slice(img_3d, py, img_y/2);
pz = 'axial'; z = extract_slice(img_3d, pz, img_z/2);

figure; im = x; p= px; imshow(im, []); title(p); xlabel(num2str(size(im,2))); ylabel(num2str(size(im,1)));
figure; im = y; p= py; imshow(im, []); title(p); xlabel(num2str(size(im,2))); ylabel(num2str(size(im,1)));
figure; im = z; p= pz; imshow(im, []); title(p); xlabel(num2str(size(im,2))); ylabel(num2str(size(im,1)));

close all;clc;
%% Visualize the volume with Alphamap
load camera_settings.mat
conf = shot0;
conf.Alphamap(1:169) = conf.Alphamap(1:169)*0.1;
conf.Alphamap(201:end) = conf.Alphamap(201:end)*0.1;
figure; volshow(vol,shot1,'ScaleFactors',pixdim); title("Original volume");
figure; volshow(vol,conf,'ScaleFactors',pixdim); title("Optimized transparency"); 
figure; hold on; plot(shot1.Alphamap); plot(conf.Alphamap); hold off; legend(["Original", "Optimized"]);

close all;clc;
%% Sagittal plane - slice 135

plane= 'sagittal';
slice= 135;

input_image = extract_slice(img_3d, plane, slice);

% Image processing workflow on slice 135

%   Explore
explore_preprocessing(input_image); % Original
explore_preprocessing(imcomplement(input_image)); % Negative

%   Apply optimal pre-processing
pp_img = preprocessing(input_image, true); % Original
pp_neg_img = preprocessing(imcomplement(input_image), false); % Negative

%   ROI extraction and Cross-sectional area estimation
%       technique = 'filling' or 'median'
img = pp_img; % Original
[filled_img, fill_area] = ROI_extraction(img, 'filling', true, false);
[medfilt_img, medfilt_area] = ROI_extraction(img, 'median', true, false);

img = pp_neg_img; % Negative
[filled_img_n, fill_area_n] = ROI_extraction(img, 'filling', true, true);
[medfilt_img_n, medfilt_area_n] = ROI_extraction(img, 'median', true, true);

% ----->   Filling is the best option

close all;clc;
%% 1. Evaluate the technique with insidious slices - ORIGINAL

% SAGITTAL PLANE 
plane= 'sagittal'; dim = img_y;
starting_point= 135;

areas = explore_volume(plane, starting_point, img_3d, dim);

volumes = areas*voxel_vol;
sag_volume_1 = sum(volumes);

% -----> not working, since the slicing is not enough to isolate the
%           tumoral mass with respect to the noise

close all;clc;

%% 2. Evaluate the technique with insidious slices - NEGATIVE

% SAGITTAL PLANE 
plane= 'sagittal'; dim = img_y;
starting_point= 135;

areas = explore_volume_negative(plane, starting_point, img_3d, dim);

volumes = areas*voxel_vol;
sag_volume_2 = sum(volumes);

% -----> not working, since the slicing is not enough to isolate the
%           tumoral mass with respect to the noise

close all; clc;
%% 3. Extend the quantification to the whole volume - with enhanced transformation

% SAGITTAL PLANE 
plane= 'sagittal'; dim = img_y;
starting_point= 132;

areas = explore_volume_negative_enhanced(plane, starting_point, img_3d, dim);

volumes = areas*voxel_vol;
sag_volume_3 = sum(volumes);

% -----> not working, since the transformation is to aggressive in the
% slides without artifacts and not enough in the insidious ones

close all; clc;

%% 4. Extend the quantification to the whole volume - with Grayscaling + PRECUT

% SAGITTAL PLANE 
plane= 'sagittal'; dim = img_y;
starting_point= 132;

areas = explore_volume_precut(plane, starting_point, img_3d, dim);

volumes = areas*voxel_vol;
sagittal_volume = sum(volumes);

close all; clc;

%% 5.1. Extend the quantification to the whole volume - with Grayscaling

% SAGITTAL PLANE 
plane= 'sagittal'; dim = img_y;
starting_point= 132;

areas = explore_volume_negative_grayscaling(plane, starting_point, img_3d, dim);

volumes = areas*voxel_vol;
sagittal_volume = sum(volumes);

template = im2double(extract_slice(img_3d, plane, starting_point));
figure; imshow(template, [], 'InitialMagnification', 'fit'); title(['Original - Slice = ', num2str(starting_point)]); xlabel(['Volume [cm^3] = ', num2str(sagittal_volume/1000)]);

save areas
save sagittal_volume
close all; clc;


%% 5.2. Extend the quantification to the whole volume - CORONAL

% CORONAL PLANE 
plane= 'coronal'; dim = img_y;
starting_point= 156;

areas = explore_volume_negative_grayscaling(plane, starting_point, img_3d, dim);

volumes = areas*voxel_vol;
coronal_volume = sum(volumes);

template = im2double(extract_slice(img_3d, plane, starting_point));
figure; imshow(template, [], 'InitialMagnification', 'fit'); title(['Original - Slice = ', num2str(starting_point)]); xlabel(['Volume [cm^3] = ', num2str(coronal_volume/1000)]);

save areas
save coronal_volume
close all; clc;

%% Extend the quantification to the whole volume - AXIAL
% AXIAL PLANE 
plane= 'axial'; dim = img_y;
starting_point= 79;

areas = explore_volume_negative_grayscaling(plane, starting_point, img_3d, dim);

volumes = areas*voxel_vol;
axial_volume = sum(volumes);

template = im2double(extract_slice(img_3d, plane, starting_point));
figure; imshow(template, [], 'InitialMagnification', 'fit'); title(['Original - Slice = ', num2str(starting_point)]); xlabel(['Volume [cm^3] = ', num2str(axial_volume/1000)]);

save areas
save axial_volume
close all; clc;


%% 
sagittal_volume/1000
coronal_volume/1000
axial_volume/1000

average_volume = mean([sagittal_volume, coronal_volume, axial_volume]); average_volume/1000
save average_volume
