%% Step 1: Read Images
% Read the reference image containing the object of interest.
ref_img = imread('butterflyvalve.png');
boxImage = rgb2gray(ref_img);
figure;
imshow(boxImage);
title('Image of a Butterfly Valve');

%%
% Read the target image containing a cluttered scene.
ref_img2 = imread('background.PNG');
sceneImage = rgb2gray(ref_img2);
figure; 
imshow(sceneImage);
title('Image of Background Scene');

%% Step 2: Detect Feature Points
% Detect feature points in both images.
boxPoints = detectSURFFeatures(boxImage);
scenePoints = detectSURFFeatures(sceneImage);

%% 
% Visualize the strongest feature points found in the reference image.
figure; 
imshow(boxImage);
title('100 Strongest Feature Points from Image');
hold on;
plot(selectStrongest(boxPoints, 100));

%% 
% Visualize the strongest feature points found in the target image.
figure; 
imshow(sceneImage);
title('300 Strongest Feature Points from Background Image');
hold on;
plot(selectStrongest(scenePoints, 300));

%% Step 3: Extract Feature Descriptors
[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

%% Step 4: Find Putative Point Matches
boxPairs = matchFeatures(boxFeatures, sceneFeatures);

%% 
% Display putatively matched features. 
matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');

%% Step 5: Locate the Object in the Scene Using Putative Matches
[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

%%
% Display the matching point pairs with the outliers removed
figure;
showMatchedFeatures(boxImage, sceneImage, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');
hold on
A=[[1617 1587]]
B=[[281.51965 446.4]]
line(A,B)
plot(1602,366, 'r+', 'MarkerSize', 20, 'LineWidth', 2)
centroid=[((1617+1587)/2) ((446.4+285.91)/2)]
viscircles(centroid,83.75)
rect = patches.Rectangle([1518 425],118.44,118.44)
ax.add_patch(rect)
% rectangle('Position',[1518,425,118.44,118.44],...
%          'LineWidth',2,'LineStyle','--')
hold off
distance=[281.51,1617; 446.4,1587]
diamter=pdist(distance,'euclidean')
%%
% Transform the polygon into the coordinate system of the target image.
newBoxPolygon = transformPointsForward(tform, boxPolygon);    

%%
%taking min and max values for centroid calculation
[val,loc] = min(inlierScenePoints.Location(:,2))
[val,loc] = max(inlierScenePoints.Location(:,2))
