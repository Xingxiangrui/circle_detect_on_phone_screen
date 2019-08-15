clear all;close all;clc;

%Read the image into the workspace and display it.
image_gray = imread('t (1).jpg');

% % object enhancement
% A=imadjust(image_gray,[0.4 1],[]);
A=image_gray;

%Find all the circles with radius R
Rmin=10;Rmax=50;
[centers, radii, metric] = imfindcircles(A,[15 40],...
    'ObjectPolarity','bright','Sensitivity',0.85,...
    'EdgeThreshold',0.02);

%Draw the five strongest circle perimeters.
figure
imshow(A);
viscircles(centers, radii,'EdgeColor','b');


