
function visualize_slices(img, img_x, img_y, img_z)
    px = 'coronal'; x = extract_slice(img, px, img_x/2);
    py = 'sagittal'; y = extract_slice(img, py, img_y/2);
    pz = 'axial'; z = extract_slice(img, pz, img_z/2);
    
    figure; 
    subplot(131); im = x; p= px; imshow(im, []); title(p); xlabel(num2str(size(im,2))); ylabel(num2str(size(im,1)));
    subplot(132); im = y; p= py; imshow(im, []); title(p); xlabel(num2str(size(im,2))); ylabel(num2str(size(im,1)));
    subplot(133); im = z; p= pz; imshow(im, []); title(p); xlabel(num2str(size(im,2))); ylabel(num2str(size(im,1)));
end 