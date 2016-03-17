% Main Module of Car Detection

[filename,pathname] = uigetfile({'*.tif'},'Pick an Image File');
I = imread([pathname,filename]);
I = imresize(I,[256,256]);
figure, imshow(I);title(' Selected Image');
Img = rgb2gray(I);

% Extract HOG features from the original image with window size of 64
%fun = @(block_struct) hog_feature_vector(block_struct.data);
%out = blockproc(double(Img),[32 64],fun);
%figure, imshow(out);

%
%load('AllFeatures.mat')
%X = TotalFeat;
% Create Label
%CarLabel = ones(4,1);
%NonCarLabel = 2*ones(38,1);
%Label = [CarLabel;NonCarLabel];
%Label = ones(length(out),1);
%SVMStruct = svmtrain(X,Label);
%[~, predictions] = svmclassify(out,Label,SVMStruct);

[fpos, fneg] = features(pathPos, pathNeg);  % extract features
[ model ] = trainSVM( fpos,fneg );          % train SVM
save car_model;