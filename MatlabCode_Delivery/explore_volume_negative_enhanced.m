function areas = explore_volume_negative_enhanced(plane, starting_point, volume, dim)

    n= starting_point; template = im2double(imcomplement(extract_slice(volume, plane, n)));
    figure; imshow(template, [], 'InitialMagnification', 'fit'); title('Select a portion in the lesion area'); loc = getrect; close;
    rect = imcrop(template, loc);
    avg_gray_level = mean(rect, 'all'); 
    
    pp_template = enhanced_preprocessing(template, avg_gray_level, true);
    figure;
    subplot(121); imshow(template, [], 'InitialMagnification', 'fit'); title('Original'); xlabel(['Slice = ', num2str(n)]);
    subplot(122); imshow(pp_template, [], 'InitialMagnification', 'fit'); title('Processed');

    areas = zeros(1,dim);
    
    %   previous slices (RIGHT SIDE)
    for i = starting_point:-1:1
        img = extract_slice(volume, plane, i);
        img = imcomplement(img);
        proc_img = enhanced_preprocessing(img, avg_gray_level, false);
        roi = ROI_extraction(proc_img, 'filling', false, true);
        area = sum(sum(roi));
        areas(i) = area;
        
        figure; 
        subplot(131); imshow(img, [], 'InitialMagnification', 'fit'); title('Original'); xlabel(['Slice = ', num2str(i)]);
        subplot(132); imshow(proc_img, [], 'InitialMagnification', 'fit'); title('Processed');
        subplot(133); imshow(roi, [], 'InitialMagnification', 'fit'); title('ROI'); xlabel(['Area = ', num2str(area)]);
    
        if (area<=0)
            break;
        end
    end

    %   next slices (LEFT SIDE)
    for i = starting_point+1:dim
        img = extract_slice(volume, plane, i);
        img = imcomplement(img);
        proc_img = enhanced_preprocessing(img, avg_gray_level, false);
        roi = ROI_extraction(proc_img, 'filling', false, true);
        area = sum(sum(roi));
        areas(i) = area;
        
        figure; 
        subplot(131); imshow(img, [], 'InitialMagnification', 'fit'); title('Original'); xlabel(['Slice = ', num2str(i)]);
        subplot(132); imshow(proc_img, [], 'InitialMagnification', 'fit'); title('Processed');
        subplot(133); imshow(roi, [], 'InitialMagnification', 'fit'); title('ROI'); xlabel(['Area = ', num2str(area)]);
       
        if (area<=0)
            break;
        end
    end

end