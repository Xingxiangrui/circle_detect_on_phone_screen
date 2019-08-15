function circlefind(A)

% % object enhancement
% A=imadjust(A,[0.4 1],[]);

%Find all the circles with radius R
Rmin=10;Rmax=50;
[centers, radii, metric] = imfindcircles(A,[15 45],...
    'ObjectPolarity','bright','Sensitivity',0.85,...
    'EdgeThreshold',0.01);

%Draw the five strongest circle perimeters.
figure
imshow(A);
viscircles(centers, radii,'EdgeColor','b');