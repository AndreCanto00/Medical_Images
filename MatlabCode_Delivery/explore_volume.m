function areas = explore_volume(plane, starting_point, volume, dim)

    areas = zeros(1,dim);
    
    %   previous slices (RIGHT SIDE)
    for i = starting_point:-1:1
        img = extract_slice(volume, plane, i);
        proc_img = preprocessing(img, false);
        roi = ROI_extraction(proc_img, 'filling', false, false);
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
        proc_img = preprocessing(img, false);
        roi = ROI_extraction(proc_img, 'filling', false, false);
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