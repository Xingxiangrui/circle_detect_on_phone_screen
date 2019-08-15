clear all;close all;clc;

%% use circle find
%Read the image into the workspace.
A = imread('t (6).jpg');

%Find all the circles with radius R
Rmin=10;Rmax=50;
Imagesize=size(A);
ROI=[80,160,Imagesize(2)-160,Imagesize(1)-320];
[centers, radii, metric] = imfindcircles(A,[15 40],...
    'ObjectPolarity','bright','Sensitivity',0.85,...
    'EdgeThreshold',0.02);

%Draw the circle perimeters.
figure
imshow(A);
viscircles(centers, radii,'EdgeColor','b');
hold on;

%% use MSER region
% Region Detection
%ROI region
I = rgb2gray(A);
Imagesize=size(I);
ROI=[80,160,Imagesize(2)-160,Imagesize(1)-320];

%Detect MSER regions.
[regions,mserCC] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',0.1,'ROI',ROI);
[regions1,mserCC1] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',0.8,'ROI',ROI);
[regions2,mserCC2] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',1.4,'ROI',ROI);
[regions3,mserCC3] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',2.5,'ROI',ROI);

% Measure the MSER region eccentricity to gauge region circularity. 
stats = regionprops('table',mserCC,'Eccentricity');
stats1 = regionprops('table',mserCC1,'Eccentricity');
stats2 = regionprops('table',mserCC2,'Eccentricity');
stats3 = regionprops('table',mserCC3,'Eccentricity');

%Threshold eccentricity values to only keep the circular regions. 
%(Circular regions have low eccentricity.)
eccentricityIdx = stats.Eccentricity < 0.8;
circularRegions = regions(eccentricityIdx);
eccentricityIdx1 = stats1.Eccentricity < 0.8;
circularRegions1 = regions1(eccentricityIdx1);
eccentricityIdx2 = stats2.Eccentricity < 0.8;
circularRegions2 = regions2(eccentricityIdx2);
eccentricityIdx3 = stats3.Eccentricity < 0.8;
circularRegions3 = regions3(eccentricityIdx3);

%Show the circular regions.
plot(circularRegions,'showPixelList',true,'showEllipses',false)
plot(circularRegions1,'showPixelList',true,'showEllipses',false)
plot(circularRegions2,'showPixelList',true,'showEllipses',false)
plot(circularRegions3,'showPixelList',true,'showEllipses',false)

