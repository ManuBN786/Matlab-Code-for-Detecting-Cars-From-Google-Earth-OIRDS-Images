% Demo of blockproc in two different ways.
% One uses an anonymous function to return a block of pixels
% the same size as the sliding window block.
% The other uses a custom written function to return a
% single value for each sliding window position.
function blockproc_demo()
try
	clc; % Clear the command window.
	close all; % Close all figures (except those of imtool.)
	workspace; % Make sure the workspace panel is showing.
	fontSize = 20;

	% Change the current folder to the folder of this m-file.
	if(~isdeployed)
		cd(fileparts(which(mfilename)));
	end

	% Read in standard MATLAB demo image.
	grayImage = imread('cameraman.tif');
	[rows, columns, numberOfColorChannels] = size(grayImage);
	% Display the original image.
	subplot(2, 2, 1);
	imshow(grayImage, []);
	caption = sprintf('Original Image\n%d by %d pixels', ...
	rows, columns);
	title(caption, 'FontSize', fontSize);
	% Enlarge figure to full screen.
	set(gcf, 'Position', get(0,'Screensize'));
	set(gcf, 'name','Image Analysis Demo', 'numbertitle','off')

	% Block process the image.
	windowSize = 3;
	% Each 3x3 block will get replaced by one value.
	% Output image will be smaller by a factor of windowSize.
	myFilterHandle = @myFilter;
	blockyImage = blockproc(grayImage,[windowSize windowSize], myFilterHandle);
	[rowsP, columnsP, numberOfColorChannelsP] = size(blockyImage);

	% Display the processed image.
	% It is smaller, but the display routine imshow() replicates
	% the image so that it looks bigger than it really is.
	subplot(2, 2, 2);
	imshow(blockyImage, []);
	caption = sprintf('Image Processed in %d by %d Blocks\n%d by %d pixels\nCustom Box Filter', ...
	windowSize, windowSize, rowsP, columnsP);
	title(caption, 'FontSize', fontSize);

	% Now let's do it an alternate way where we use an anonymous function.
	% We'll take the standard deviation in the blocks.
	windowSize = 8;
	myFilterHandle2 = @(block_struct) ...
	std2(block_struct.data) * ones(size(block_struct.data));
	blockyImageSD = blockproc(grayImage, [windowSize windowSize], myFilterHandle2);
	[rowsSD, columnsSD, numberOfColorChannelsSD] = size(blockyImageSD);
	subplot(2, 2, 4);
	imshow(blockyImageSD, []);
	caption = sprintf('Image Processed in %d by %d Blocks\n%d by %d pixels\nAnonymous Standard Deviation Filter', ...
	windowSize, windowSize, rowsSD, columnsSD);
	title(caption, 'FontSize', fontSize);

	% Note: the image size of blockyImageSD is 256x256, NOT smaller.
	% That's because we're returning an 8x8 array instead of a scalar.

	uiwait(msgbox('Done with demo'));
	catch ME
		errorMessage = sprintf('Error in blockproc_demo():\n\nError Message:\n%s', ME.message);
		uiwait(warndlg(errorMessage));
	end
	return;

% Takes one 3x3 block of image data and multiplies it
% element by element by the kernel and
% returns a single value.
function singleValue = myFilter(blockStruct)
	try
		% Assign default value.
		% Will be used near sides of image (due to boundary effects),
		% or in the case of errors, etc.
		singleValue = 0;

		% Create a 2D filter.
		kernel = [0 0.2 0; 0.2 0.2 0.2; 0 0.2 0];
		% kernel = ones(blockStruct.blockSize); % Box filter.

		% Make sure filter size matches image block size.
		if any(blockStruct.blockSize ~= size(kernel))
			% If any of the dimensions don't match.
			% You'll get here near the edges,
			% if the image is not a multiple of the block size.
			% warndlg('block size does not match kernel size');
			return;
		end
		% Size matches if we get here, so we're okay.

		% Extract our block out of the structure.
		array3x3 = blockStruct.data;

		% Do the filtering. Multiply by kernel and sum.
		singleValue = sum(sum(double(array3x3) .* kernel));

	catch ME
		% Some kind of problem...
		errorMessage = sprintf('Error in myFilter():\n\nError Message:\n%s', ME.message);
		% uiwait(warndlg(errorMessage));
		fprintf(1, '%s\n', errorMessage);
	end
	return; 