function [faceMatrix] = loopThroughFile(folderPath)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
a = dir(fullfile(folderPath,'*.jpg'));
fileNames = {a.name};

faceMatrix = [];
for k = 1:length(fileNames)
        filename = string(fileNames(k));
        filename = strcat(folderPath, filename);
        I = rgb2gray(imread(filename));
        [a, b] = size(I);
        I = reshape(I, [a * b, 1]);
        faceMatrix = [faceMatrix, I];
end
end

