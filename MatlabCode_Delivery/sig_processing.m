function output = sig_processing(image, B, Q, M)
    % the larger B the steeper the growth
    % Q shifts the point of maximum growth (<1 left) (>1 right)
    A= 0; K= 1; C= 1;
    sig = @(x) (A + ( (K - A) ./ (C + Q*exp(-1*B*(x-M)) ))); 
    output = sig(image);
end 