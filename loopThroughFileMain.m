
function [faceMatrix] = loopThroughFileMain(folderPath)
    %loops through a given directory to collect all images and but into
    %one large matrix where cols are the images as vectors
    
    %@param folderPath the folder to loop through
    %@return faceMatrix a matrix with all cols vertical vectors of
    %m * n x 1 dimension where each image is m x n-
    a = dir(fullfile(folderPath,'*.jpg'));
    fileNames = {a.name};
    faceMatrix = [];
    for k = 1:length(fileNames)
            filename = string(fileNames(k));
            filename = strcat(folderPath, filename);
            I = (imread(filename));
            I = rgb2gray(I);
            [a, b] = size(I);
            I = reshape(I, [a * b, 1]);
            %possibility of dim missmatch
            faceMatrix = [faceMatrix, I];
    end
end