function img = grayscaling_preprocessing(image, avg, min, max, visualize)
   
    % Normalize - double
    img = im2double(image);
    grayscale = 0:1/255:1; 

    % Modified gray level slicing
    A= 0; K= 1; C= 1; B= 40; Q= 0.5; M= min;
    sig1 = @(x) (A + ( (K - A) ./ (C + Q*exp(-1*B*(x-M)) )));

    A= 1; K= 0; C= 1; B= 40; Q= 1.5; M= max;
    sig2 = @(x) (A + ( (K - A) ./ (C + Q*exp(-1*B*(x-M)) )));

    syms f(x)
    f(x) = piecewise(x<avg , sig1(x) ,x>avg , sig2(x));
    
    img = double(f(img));

    if visualize
        figure; hold on; plot(grayscale, grayscale); plot(grayscale, f(grayscale)); legend("Original", "Int. Transf.");
    end
end 
