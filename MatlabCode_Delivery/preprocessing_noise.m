function img = preprocessing_noise(img, visualize)

    grayscale = 0:1/255:1; 

    % Sigmoidal enhancement
    B= 15; Q= 0.5; M=0.5;
    img = sig_processing(img,B,Q,M); 

    if visualize
        figure; hold on; plot(grayscale, grayscale); plot(grayscale, sig_processing(grayscale,B,Q,M)); legend("Original", "Sig. Transf.");
    end
end 