function [ model ] = trainSVM( fpos,fneg )
    SV = loadingV(fpos,fneg);   % loading and labeling each training example
    fprintf('Training SVM..\n');
    T = cell2mat(SV(2,:));
    % T = cell2mat(SV(:,:));
    tP = SV(3,:)';
   % tP = SV(:,:)';
    %tP = SV(:,:)';
    P = cell2mat(tP); % each row of P correspond to a training example 
    model = svmlearn(P, T', '-t -g 0.3 -c 0.5');
    fprintf('done. \n');
end

