clear all;clc;close all;

%% Step 1: Detect Candidate Text Regions Using MSER
format COMPACT;
clear all;close all;clc;

colorImage = imread('c1.jpg');
I = rgb2gray(colorImage);


% Detect MSER regions.
[mserRegions, mserConnComp] = detectMSERFeatures(I, ...
    'RegionAreaRange',[10 2000],'ThresholdDelta',4);

figure
imshow(I)
hold on
plot(mserRegions, 'showPixelList', true,'showEllipses',false)
title('MSER regions')
hold off