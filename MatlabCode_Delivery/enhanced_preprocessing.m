function img = enhanced_preprocessing(image, center, visualize)
   
    % Normalize - double
    img = im2double(image);
    grayscale = 0:1/255:1; 

    % Sigmoidal enhancement
    B= 15; Q= 1.5; M= center;
    img = sig_processing(img,B,Q,M); 

    if visualize
        figure; hold on; plot(grayscale, grayscale); plot(grayscale, sig_processing(grayscale,B,Q,M)); legend("Original", "Sig. Transf.");
    end
end 