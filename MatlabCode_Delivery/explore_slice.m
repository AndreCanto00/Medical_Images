function explore_slice(volume, plane, slice)

    input_image = extract_slice(volume, plane, slice);
    
    %   Apply optimal pre-processing
    pp_img = preprocessing_noise(input_image, true); % Original
    pp_neg_img = preprocessing_noise(imcomplement(input_image), false); % Negative
    
    %   ROI extraction and Cross-sectional area estimation
    %       technique = 'filling' or 'median'
    img = pp_img; % Original
    [filled_img, fill_area] = ROI_extraction(img, 'filling', true, false);
    [medfilt_img, medfilt_area] = ROI_extraction(img, 'median', true, false);
    
    img = pp_neg_img; % Negative
    [filled_img_n, fill_area_n] = ROI_extraction(img, 'filling', true, true);
    [medfilt_img_n, medfilt_area_n] = ROI_extraction(img, 'median', true, true);
    
    % ----->   Filling is the best option

end