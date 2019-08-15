clear all;clc;close all;

%% Image Enhancement

%read image
colorImage1 = imread('t (7).jpg');
image_gray = rgb2gray(colorImage1);
figure
subplot(121)
imshow(image_gray)
% % Gama correction
% I=imadjust(image_gray,stretchlim(image_gray),[],1.5);
% subplot(122)
% imshow(I)
I=image_gray;

%% Region Detection
%ROI region
Imagesize=size(I);
ROI=[80,160,Imagesize(2)-160,Imagesize(1)-320];

%Detect MSER regions.
[regions,mserCC] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',0.8,'ROI',ROI);
[regions1,mserCC1] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',0.2,'ROI',ROI);
[regions2,mserCC2] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',1.4,'ROI',ROI);
[regions3,mserCC3] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',2,'ROI',ROI);

% regions=[regions1;regions2;regions3];

%Show all detected MSER Regions.
figure
subplot(121)
imshow(I)
hold on
plot(regions,'showPixelList',true,'showEllipses',false)

%% Measure the MSER region eccentricity to gauge region circularity. 
stats = regionprops('table',mserCC,'Eccentricity');

%Threshold eccentricity values to only keep the circular regions. 
%(Circular regions have low eccentricity.)

eccentricityIdx = stats.Eccentricity < 0.45;
circularRegions = regions(eccentricityIdx);

%Show the circular regions.
subplot(122)
imshow(I)
hold on
plot(circularRegions,'showPixelList',true,'showEllipses',false)
%plot(circularRegions(1,1),'showPixelList',true,'showEllipses',false)
%plot(circularRegions(2,1),'showPixelList',true,'showEllipses',false)
%plot(circularRegions(3,1),'showPixelList',true,'showEllipses',false)

