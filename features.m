function [fpos, fneg] = features(pathPos,pathNeg)
    % extract features for positive examples
    imlist = dir([pathPos '*.jpg']);
    for i = 1:length(imlist)
        im = imread([pathPos imlist(i).name]);
        im = imresize(im,[32,32]);
        fpos{i} = HOG(double(im));
    end
    % extract features for negative examples
    imlist = dir([pathNeg '*.jpg']);
    for i = 1:length(imlist)
        im = imread([pathNeg imlist(i).name]);
        im = imresize(im,[32,32]);
        fneg{i} = HOG(double(im));
    end

end
