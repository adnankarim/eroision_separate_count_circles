% Read in original image.
RGB = imread('img.png');
grayImage = 256-rgb2gray(RGB);

[rows, columns, numberOfColorChannels] = size(grayImage);
% Display RGB image
subplot(2,2,1);
imshow(RGB);
axis on;
title('Original image (RGB)');
% Display graysclae image
subplot(2,2,2);
imshow(grayImage);
axis on;
title('Original (graysclae) image');
% Display binary image
binaryImage=imbinarize(grayImage);
subplot(2,2,3);
imshow(binaryImage);
axis on;
title('Original (Binary) image  ');
% Define structuring element of disk of radius 9.
se = strel('disk',9);
se= se.Neighborhood;
[p, q]=size(se);
halfH = floor(p/2);
halfW = floor(q/2);
% Initialize output image
erodedImage = zeros(size(binaryImage), class(binaryImage));
% Perform morphological erosion.
for col = (halfW + 1) : (columns - halfW)
  for row = (halfH + 1) : (rows - halfH)
    % Get the neighborhood
    r1 = row-halfH;
    r2 = row+halfH;
    c1 = col-halfW;
    c2 = col+halfW;
    Neighborhood = binaryImage(r1:r2, c1:c2);
    % Applying the structuring element se
    overlapPixels = Neighborhood(se);
    erodedImage(row, col) = min(overlapPixels);
  end
end
% calculated 8 connected objects
[L,n] = bwlabel(erodedImage);
disp("Total coins are: "+n)
% Display Eroded Image image
subplot(2,2,4);
imshow(erodedImage);
axis on;
title('Eroded image contains coins: '+string(n));
