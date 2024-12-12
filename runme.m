clc;
close all;


image_path = 'airplane_grayscale.png'; 
T = 25;  % Threshold value for Gradient
L_B = 0;  % Background gray level
L_G = 255;  % Edge gray level

% Reading the input image
input_image_unpadded = imread(image_path);
%converts the image matrix from integer precision to floating point precision.
%This helps in easier computation while calculating the gradient.
input_image_unpadded = double(input_image_unpadded);

% Defining Roberts Gradient convolution masks. 
% It is the Cross Difference convolution mask
h1 = [1 0; 0 -1];
h2 = [0 1; -1 0];

% Finding the gradient image using the Roberts masks
gradient_image = compute_gradient(input_image_unpadded, h1, h2);

%For displaying the figures it should be converted back from double to
%uint8 as imshow only supports image of uint8 type to be displayed.

% Display the original image.
figure;
subplot(2, 3, 1);
imshow(uint8(input_image_unpadded));
title('Original Image');

% Case 1: Gradient Image
subplot(2, 3, 2);
case1_img = gradient_image;
imshow(uint8(case1_img));
title('Case 1: Gradient Image');

% Case 2: Retain Smooth Background
case2_img = use_gradient_threshold(input_image_unpadded, gradient_image, T, NaN, NaN);
subplot(2, 3, 3);
imshow(uint8(case2_img));
title('Case 2: Retain Background with Edges = Gradient');

% Case 3: Edges Set to Gray Level 255
case3_img = use_gradient_threshold(input_image_unpadded, gradient_image, T, L_G, NaN);
subplot(2, 3, 4);
imshow(uint8(case3_img));
title('Case 3: Retain Background with Edges = 255');

% Case 4: Background Set to Gray Level 0
case4_img = use_gradient_threshold(input_image_unpadded, gradient_image, T, NaN, L_B);
subplot(2, 3, 5);
imshow(uint8(case4_img));
title('Case 4: Background = 0 with Edges = Gradient');

% Case 5: Binary Gradient (Edges = 255, Background = 0)
case5_img = use_gradient_threshold(input_image_unpadded, gradient_image, T, L_G, L_B);
subplot(2, 3, 6);
imshow(uint8(case5_img));
title('Case 5: Background set 0 with Edges = 255');


%% Function to compute the gradient using Roberts convolution masks
function grad_img = compute_gradient(input_image_unpadded, h1, h2)
    % Adding padding to make sure convolution with roberts gradient can happen
    % for last row & column in the input 512x512 image.
    pad_value = 0; % Padding value for the new row and column
    [rows, cols] = size(input_image_unpadded);
    image = pad_value * ones(rows + 1, cols + 1);
    % Copy the original image into the new matrix
    image(1:rows, 1:cols) = input_image_unpadded;

    [width, height] = size(image);
    grad_img = zeros(width-1, height-1);
    
    % Convolution with Roberts masks and finding the gradient.
    for i = 1:width-1
        for j = 1:height-1
            % Finding the gradient using L2 Norm
            G1 = sum(sum(h1 .* image(i:i+1, j:j+1)));
            G2 = sum(sum(h2 .* image(i:i+1, j:j+1)));
            grad_img(i, j) = sqrt(G1^2 + G2^2);
        end
    end
end

%% Function to apply the edge enhancement transformation based on given threshold and gray levels
function final_image = use_gradient_threshold(input_image_unpadded, grad_img, T, L_G, L_B)
    [rows, cols] = size(input_image_unpadded);
    final_image = zeros(rows, cols);
    
    for i = 1:rows
        for j = 1:cols
            if grad_img(i,j) >= T
                if isnan(L_G) && isnan(L_B)
                    % Pixel value is Gradient value if Gradient >= T.
                    % L_G and L_B values are not used.
                    % Case 2
                    final_image(i,j) = grad_img(i,j);
                elseif isnan(L_B)
                    % Edges set to gray level L_G if LB is not used.
                    % Case 3
                    final_image(i,j) = L_G;
                elseif isnan(L_G)
                    % Edges set to gradient is only LB is used as
                    % background.
                    % Case 4
                    final_image(i,j) = grad_img(i,j);
                else
                    % If Both LG and LB values are there then set edges to
                    % L_G
                    % Case 5
                    final_image(i,j) = L_G;
                end
            else
                if isnan(L_B)
                    % Retain the original image for smooth regions.
                    %Case 2, Case 3
                    final_image(i,j) = input_image_unpadded(i,j);
                else
                    % Background set to gray level L_B, that is dark
                    % background
                    % Case 4, Case 5.
                    final_image(i,j) = L_B;
                end
            end
        end
    end
end
