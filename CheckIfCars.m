% Training Part
% Train wit positive and negative images

clear; close all; clc;

% Add Path to svm library
addpath './svm_mex601/matlab/';
addpath './svm_mex601/bin/';

pathPos = './OIRDS Car/';       % positive example
pathNeg = './OIRDS NonCar/'; 


%[fpos, fneg] = features(pathPos, pathNeg);  % extract features
%[ model ] = trainSVM( fpos,fneg );          % train SVM
%save model;
load('model.mat')
tSize = [32,32];

%% To select single image and observe the results uncomment the sections below 
[filename, pathname] = uigetfile('*.tif',' Select an Image With A Car ');
img = imread([pathname,filename]);
img = imresize(img,[256,256]);
%imwrite(img,'New_Image5.tif','tif');
figure, imshow(img); title(' Selected Image ');
hold on;
detect(img,model,tSize);
%% The section below detects faces in all images at a single run
%delete('./results/*.tif');
%testImPath = './OIRDS Dataset/';
%imlist = dir([testImPath '*.tif']);
%for j = 1:length(imlist)
%    img = imread([testImPath imlist(j).name]);
%    img = imresize(img,[256,256]);
%    axis equal; axis tight; axis off;
%    disp(['Processing Image no.',num2str(j)]);
%    imshow(img); hold on;
%    detect(img,model,tSize);
%    saveas(gcf, ['./results/' imlist(j).name], 'tif');
%    close all;
%end