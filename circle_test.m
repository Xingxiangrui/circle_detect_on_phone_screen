clear all;clc;close all;

%% read and detect circle

colorImage1 = imread('t (1).jpg');
I1 = rgb2gray(colorImage1);
circle_detect(I1);

colorImage2 = imread('t (2).jpg');
I2 = rgb2gray(colorImage2);
circle_detect(I2)

colorImage3 = imread('t (3).jpg');
I3 = rgb2gray(colorImage3);
circle_detect(I3)

colorImage4 = imread('t (4).jpg');
I4 = rgb2gray(colorImage4);
circle_detect(I4)

colorImage5 = imread('t (5).jpg');
I5 = rgb2gray(colorImage5);
circle_detect(I5)

colorImage6 = imread('t (6).jpg');
I6 = rgb2gray(colorImage6);
circle_detect(I6)

colorImage7 = imread('t (7).jpg');
I7 = rgb2gray(colorImage7);
circle_detect(I7)

colorImage8 = imread('t (8).jpg');
I8 = rgb2gray(colorImage8);
circle_detect(I8)

colorImage9 = imread('t (9).jpg');
I9 = rgb2gray(colorImage9);
circle_detect(I9)

colorImage10 = imread('t (10).jpg');
I10 = rgb2gray(colorImage10);
circle_detect(I10)