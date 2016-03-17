% This is for feature extraction, trainig and labeling only

% Extract hog features
%[feature] = hog_feature_vector(image);


% Extract features for car regions only

close all
clear all
clc
srcFiles = dir('OIRDS Car\*.jpg');
for i = 1:length(srcFiles)
    disp(['Processing Frame no.',num2str(i)]);
    img = imread(['TrainWithCars\',num2str(i),'.jpg']);
    img = imresize(img,[54,34]);
   % (['Frames\',num2str(i),'.jpg'])
   % figure, imshow(img);
    feature = hog_feature_vector(img);
    OnlyCarFeat= feature;
    save OnlyCarFeat;
end




%srcFiles = dir('Train\*.jpg');
%for i = 1:length(srcFiles)
%    filename = strcat('Train\',srcFiles(i).name);
%    I = imread(filename);
%    I = imresize(I,[128,128]);
%    figure, imshow(I);
%    feat = hog_feature_vector(I);
%    NewFeat = feat;
%    save NewFeat;
%end


% Extract features for non car regions only

close all
clear all
clc
Files = dir('OIRDS NonCar\*.jpg');
Y=length(Files)
for i = 1:length(Files)
    disp(['Processing Frame no.',num2str(i)]);
    image = imread(['OIRDS NonCar\',num2str(i),'.jpg']);
    image = imresize(image,[54,34]);
    figure, imshow(image);
    feat = hog_feature_vector(image);
    NonCarFeat = feat;
    save NonCarFeat;
    close all
end

%% use of strcat for Non Car/Car features
clear all
close all
clc
srcFiles = dir('OIRDS NonCar\*.jpg');
for i =1:1:length(srcFiles)
    disp(['Processing Frame no.',num2str(i)]);
    filename = strcat('OIRDS NonCar\',srcFiles(i).name);
    %strcat('E:\New Folder\',srcFiles(i).name);
    I = imread(filename);
    I = imresize(I,[32,64]);
    feat(i,:) = hog_feature_vector(I);
    NonCarFeat = feat;
    save NonCarFeat;
end
%%
clear all
close all
clc
srcFiles = dir('OIRDS Car\*.jpg');
for i =1:1:length(srcFiles)
    disp(['Processing Frame no.',num2str(i)]);
    filename = strcat('OIRDS Car\',srcFiles(i).name);
    %strcat('E:\New Folder\',srcFiles(i).name);
    I = imread(filename);
    I = imresize(I,[32,64]);
    feat(i,:) = hog_feature_vector(I);
    OnlyCarFeat = feat;
    save OnlyCarFeat;
end
%%


clear all
clc
% Create Training Features
load('OnlyCarFeat.mat');
load('NonCarFeat.mat');
%X = OnlyCarFeat;
%Y = NonCarFeat;
TotalFeat = [OnlyCarFeat;NonCarFeat];
save TotalFeat

% Create Label
L1 = cell(1,1764);
for i = 1:1:1764
    L1{i} = 'OnlyCar';
end
L2 = cell(1,1764);
for j = 1:1:1764
    L2{j} = 'Non Car';
end

clc
meas = [OnlyCarFeat;NonCarFeat];
label = [L1;L2];
save TrainFeat.mat