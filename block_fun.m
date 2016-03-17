function feats = block_fun(block_struct) %// Change
descriptors= hog_feature_vector(single(block_struct.data)); %// Change
whos descriptors
feats = descriptors;
end
