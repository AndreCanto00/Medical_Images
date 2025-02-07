function areas = explore_volume_precut(plane, starting_point, volume, dim)

    n= starting_point; 
    template = im2double(imcomplement(extract_slice(volume, plane, n)));
    figure; imshow(template, [], 'InitialMagnification', 'fit'); title('Locate ROI'); loc = getrect; close;
    crop = imcrop(template, loc);
    
    pp_crop = enhanced_preprocessing(crop, mean(crop, 'all'), true);
    figure;
    subplot(121); imshow(template, [], 'InitialMagnification', 'fit'); title('Original'); xlabel(['Slice = ', num2str(n)]);
    subplot(122); imshow(pp_crop, [], 'InitialMagnification', 'fit'); title('Processed');

    areas = zeros(1,dim);
    
    %   previous slices (RIGHT SIDE)
    for i = starting_point:-1:1
        img = extract_slice(volume, plane, i);
        img = imcomplement(img);
        img = imcrop(img, loc);
        proc_img = preprocessing(img, false);
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
        img = imcrop(img, loc);
        proc_img = preprocessing(img, false);
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