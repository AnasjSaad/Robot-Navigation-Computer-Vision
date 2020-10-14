%Read Image
url='http://answers.opencv.org/upfiles/13420457486282093.jpg';
RGB = imread(url);
imshow(RGB)
%Convert Image to black and White
I = rgb2gray(RGB);
bw = imbinarize(I);
imshow(bw)
%Removing objects smaller than 30 pixels
bw = bwareaopen(bw,30);
imshow(bw)
%Fill in any close gaps
se = strel('disk',2);
bw = imclose(bw,se);
imshow(bw)
%Fill in any holes
bw = imfill(bw,'holes');
imshow(bw)
%Overlay Boundaries
[B,L] = bwboundaries(bw,'noholes');
imshow(label2rgb(L,@jet,[.5 .5 .5]))
hold on
%Displaying label on boundary
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
end
%Determining which objects are round
stats = regionprops(L,'Area','Centroid');

threshold = 0.94;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  %Calculate the radius
  radiuspi=perimeter/(2*pi)
  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;
end
hold on
title('Pixel Area of Each Circle Calculated')

%Assuming 96 dpi
%1cm=37.795276 pixels
pi2cm=37.795276
radiuscm=radiuspi/pi2cm

%%%
% figure(2)
% imshow(RGB)
% title('Initial Image')

% subplot(2,1,2)
% imshow(bw)
% hold on
% J=insertText(I, [44 90], 'Raidus=2.2580');
% imshow(J)
% title('Radius Calculated')
