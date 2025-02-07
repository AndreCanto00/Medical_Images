function explore_preprocessing(input_image)
    tot = 1;    
    grayscale = 0:1/255:1; 

    %   Local Contrast 
    edgeThreshold = 0.4; % Amplitude of strong edges to leave intact, specified as a numeric scalar in the range [0,1]
    amount = 0.5; % Amount of enhancement or smoothing desired, specified as a numeric scalar in the range [-1,1]
    img_enh = localcontrast(input_image, edgeThreshold, amount);
    tot = tot+1;
    
    %   Multi-threshold
    g=[]; 
   
    num_thr = 6; img_mt_1 = multi_tresh(input_image, num_thr); n1= num2str(num_thr); tot = tot+1; g(1,:)=multi_tresh(grayscale, num_thr);
    num_thr = 10; img_mt_2 = multi_tresh(input_image, num_thr); n2= num2str(num_thr); tot = tot+1; g(2,:)=multi_tresh(grayscale, num_thr);
    num_thr = 15; img_mt_3 = multi_tresh(input_image, num_thr); n3= num2str(num_thr); tot = tot+1; g(3,:)=multi_tresh(grayscale, num_thr);
    
    %   Customed enhancement 
    n_image = im2double(input_image);
    f=[]; M=0.5;
   
    B= 10; Q= 1; img_ce_0 = sig_processing(n_image,B,Q,M); t0 = ['B= ', num2str(B), ' Q= ', num2str(Q)]; tot = tot+1; f(1,:)=sig_processing(grayscale,B,Q,M); 
    B= 15; Q= 1; img_ce_1 = sig_processing(n_image,B,Q,M); t1 = ['B= ', num2str(B), ' Q= ', num2str(Q)]; tot = tot+1; f(2,:)=sig_processing(grayscale,B,Q,M); 
    B= 15; Q= 1.5; img_ce_2 = sig_processing(n_image,B,Q,M); t2 = ['B= ', num2str(B), ' Q= ', num2str(Q)]; tot = tot+1; f(3,:)=sig_processing(grayscale,B,Q,M); 
    B= 15; Q= 0.5; img_ce_3 = sig_processing(n_image,B,Q,M); t3 = ['B= ', num2str(B), ' Q= ', num2str(Q)]; tot = tot+1; f(4,:)=sig_processing(grayscale,B,Q,M); 
    
    columns = 5;
    rows = ceil(tot/columns);
    

    figure; 
    subplot(rows, columns, 1); imshow(input_image, [], 'InitialMagnification', 'fit'); title('Original image');
    subplot(rows, columns, 2); imshow(img_enh, [], 'InitialMagnification', 'fit'); title('Contrast');
    subplot(rows, columns, 3); imshow(img_mt_1, [], 'InitialMagnification', 'fit'); title(['Multithreshold (',n1,')']);
    subplot(rows, columns, 4); imshow(img_mt_2, [], 'InitialMagnification', 'fit'); title(['Multithreshold (',n2,')']);
    subplot(rows, columns, 5); imshow(img_mt_3, [], 'InitialMagnification', 'fit'); title(['Multithreshold (',n3,')']);
    subplot(rows, columns, 6); imshow(img_ce_0, [], 'InitialMagnification', 'fit'); title(['Sigmoid (',t0,')']);
    subplot(rows, columns, 7); imshow(img_ce_1, [], 'InitialMagnification', 'fit'); title(['Sigmoid (',t1,')']);
    subplot(rows, columns, 8); imshow(img_ce_2, [], 'InitialMagnification', 'fit'); title(['Sigmoid (',t2,')']);
    subplot(rows, columns, 9); imshow(img_ce_3, [], 'InitialMagnification', 'fit'); title(['Sigmoid (',t3,')']);

    figure; hold on; 
    for i = 1:size(f)
        plot(grayscale, f(i,:));
    end
    hold off; legend(t0, t1, t2, t3); title("Sigmoid transformation");

    figure; hold on; 
    for i = 1:size(g)
        plot(grayscale, g(i,:));
    end
    hold off; legend(n1,n2,n3); title("Multi-threshold")
    
end 
