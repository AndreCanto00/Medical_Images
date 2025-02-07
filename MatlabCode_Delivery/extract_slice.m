function img = extract_slice(img_3d, plane, slice)
    
    % Extract the chosen slice
    switch plane
        case 'sagittal'
            img = img_3d(slice,:,:);
            img = imrotate(reshape(img,[size(img,2) size(img,3)]), 90); % Reshape into a 2D image
        case 'axial'
            img = img_3d(:,:,slice);
            img = imrotate(reshape(img,[size(img,1) size(img,2)]), 90); % Reshape into a 2D image
        case 'coronal'
            img = img_3d(:,slice,:);
            img = imrotate(reshape(img,[size(img,1) size(img,3)]), 90); % Reshape into a 2D image
    end 
    
end