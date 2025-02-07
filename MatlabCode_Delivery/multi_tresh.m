function output = multi_tresh(input_image, num_thr)
    
    threshRGB = multithresh(input_image, num_thr);
    value = [0 threshRGB(2:end) 1];
    output = imquantize(input_image, threshRGB, value);
    
end 