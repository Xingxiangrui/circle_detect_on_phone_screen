clear all;clc;close all;

%% Image Enhancement

%read image
colorImage1 = imread('t (5).jpg');
image_gray = rgb2gray(colorImage1);
figure
subplot(121)
imshow(image_gray)

% object enhancement
I=imadjust(image_gray,stretchlim(image_gray),[],2);
subplot(122)
imshow(I)


%% Region Detection
%ROI region
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

%Show all detected MSER Regions.
figure
subplot(121)
imshow(I)
hold on
plot(regions,'showPixelList',true,'showEllipses',false)
plot(regions1,'showPixelList',true,'showEllipses',false)
plot(regions2,'showPixelList',true,'showEllipses',false)
plot(regions3,'showPixelList',true,'showEllipses',false)

%% Measure the MSER region eccentricity to gauge region circularity. 
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
subplot(122)
imshow(I)
hold on
plot(circularRegions,'showPixelList',true,'showEllipses',false)
plot(circularRegions1,'showPixelList',true,'showEllipses',false)
plot(circularRegions2,'showPixelList',true,'showEllipses',false)
plot(circularRegions3,'showPixelList',true,'showEllipses',false)


