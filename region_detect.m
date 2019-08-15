function region_detect(A)
image_gray = rgb2gray(A);

%% ROI detect
% adaptive im2bw
level=graythresh(image_gray);
image_bw=im2bw(image_gray,level);
figure
subplot(131)
imshow(image_bw)


%Fill image regions and holes
%若是屏幕被弄成黑色反过来
if image_bw(640,480)==0
    image_bw=~image_bw;
end 
image_bwr=bwareaopen(image_bw,60000);%去除小值区域

subplot(132)
imshow(image_bwr);hold on;

% Specify initial contour location close to the object.
Imagesize=size(image_bwr);          %确定图片的大小 
ROI=[80,160,Imagesize(2)-160,Imagesize(1)-320];  
%将初始ROI比图片大小稍小一些
mask = false(size(image_bwr));               
mask(80:Imagesize(1)-80,160:Imagesize(2)-160) = true;

% Segment the image using the 'edge' method with maxIterations.
maxIterations = 50;    %迭代次数，具体参考activecontour函数
%目的是将ROI一次一次往里面缩小，最终缩小到不能再缩小
bw = activecontour(image_bwr, mask, maxIterations, 'edge',...
    'SmoothFactor',50,'ContractionBias',4);

% pick out the ROI
roi_mask=bwconvhull(bw);%这里是用凸图形包裹ROI确定新的ROI
%我们需要用长方形好象是boundingbox来包裹
ROI_image = immultiply(roi_mask,image_gray);
subplot(133)
imshow(ROI_image);

%% use circle find

%Find all the circles with radius R
Rmin=10;Rmax=50;
[centers, radii, metric] = imfindcircles(ROI_image,[15 40],...
    'ObjectPolarity','bright','Sensitivity',0.85,...
    'EdgeThreshold',0.02);

%Draw the five strongest circle perimeters.
figure
imshow(A);
viscircles(centers, radii,'EdgeColor','b');
hold on;

%% use MSER region
% Region Detection
%ROI region
I = ROI_image;
Imagesize=size(I);
%Detect MSER regions.
[regions,mserCC] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',0.1,'ROI',ROI);
[regions1,mserCC1] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',0.8,'ROI',ROI);
[regions2,mserCC2] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',1.4,'ROI',ROI);
[regions3,mserCC3] = detectMSERFeatures(I,'RegionAreaRange',[600 3000],...
    'ThresholdDelta',2.5,'ROI',ROI);

% %Show all detected MSER Regions.
% figure
% subplot(121)
% imshow(I)
% hold on
% plot(regions,'showPixelList',true,'showEllipses',false)
% plot(regions1,'showPixelList',true,'showEllipses',false)
% plot(regions2,'showPixelList',true,'showEllipses',false)
% plot(regions3,'showPixelList',true,'showEllipses',false)

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
