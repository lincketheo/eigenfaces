function [U, d, avg] = CreateEigenBasis(filePath)
    %Creates Constants for the eigen basis U d avg
    %   @param filePath - path to the dataset

    %   @return U orthogonal matrix whose collumns are the basis for filepath
    %   images
    %   @return d diagonal of sigma
    %   @return avg average of the images in data

    temp = loopThroughFile(filePath);
    temp = double(temp);
    avg = mean(temp, 2);

    [U, D, ~] = svd(temp - avg, 'econ');

    d = diag(D);
end



function [faceMatrix] = loopThroughFile(folderPath)
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
            I = rgb2gray(I);        %sometimes  errorif  you input an already gray image
            [a, b] = size(I);
            I = reshape(I, [a * b, 1]);
            %possibility of dim missmatch
            faceMatrix = [faceMatrix, I];
    end
end

