function [output, area] = ROI_extraction(input_image, technique, visualize, negative)

    % Binarization, to enahnce relevant areas
    input = input_image;
    T = graythresh(input);
    bin_img = imbinarize(input,T);
    
    if negative
        bin_img = 1 - bin_img;
    end 

    % ROI identification
    input= bin_img;
    figure; imshow(input, [], 'InitialMagnification', 'fit'); title('Click on the ROI (be sure to click on white points)'); [X,Y] = getpts; close;
    roi = bwselect(input,X,Y,4);
    
    % Holes filling
    input= roi;
    switch technique
        case "filling"
            output = imfill(input,'holes');
            t = 'Filling';
        case "median"
            output = medfilt2(input,[3 3], 'symmetric');
            t = 'Median filter';
    end

    area = sum(sum(output));

    if visualize
        figure; 
        subplot(321); imshow(input_image, [], 'InitialMagnification', 'fit'); title("Original image"); 
        subplot(322); imshow(bin_img, [], 'InitialMagnification', 'fit'); title('Binarized image');
        subplot(323); hold on; imhist(input_image); xline(T, 'r'); hold off; ylim([0 2000]);
        subplot(324); hold on; histogram(bin_img,2, 'EdgeColor',"#000000", 'FaceColor',"#7E2F8E"); hold off; xticks([0.25 0.75]); xticklabels(["0" "1"]);
        subplot(325); imshow(roi, [], 'InitialMagnification', 'fit'); title('Selected ROI');
        subplot(326); imshow(output, [], 'InitialMagnification', 'fit'); title(t); xlabel(['Area = ', num2str(area),' (pixels)']);
    end
    
end