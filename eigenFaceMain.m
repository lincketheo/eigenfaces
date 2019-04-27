function eigenFaceMain(numSV, file, folderPath)
   %A is 1808000 x 130
   A = loopThroughFile(folderPath);
   size(A)
   [U, Avg] = produceFaceBasis(A);
   clear A;
   size(U)
   origional = imread(file);
   if length(size(origional)) == 3
       origional = rgb2gray(origional);
   end
   
   [d1, d2] = size(origional);
   clear origional;
   recreatedImage = recreateFace(numSV, U, file, Avg);
   
   imageSVDShow(U, Avg, numSV, recreatedImage, d1, d2)
end



%returns a matrix with all the n x m image matrices (must be the same size)
%as (m * n) x 1 vectors in as cols
function [faceMatrix] = loopThroughFile(folderPath)
    %loops through a given directory to collect all images and but into
    %one large matrix where cols are the images as vectors
    
    %@param folderPath the folder to loop through
    %@return faceMatrix a matrix with all cols vertical vectors of
    %m * n x 1 dimension where each image is m x n
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

function [U, Avg] = produceFaceBasis(faceMatrix)
    Avg = mean(faceMatrix, 2);
    faceMatrix = double(faceMatrix) - double(Avg);
    [U, ~, ~] = svd(double(faceMatrix), 'econ');
end

function [image] = recreateFace(numberEigenFaces, U, faceFile, Avg)
    image = imread(faceFile);
    if length(size(image)) == 3
        image = rgb2gray(image);
    end
    image = double(reshape(image.', 1, [])).'; 
    
    image = U(:,1:numberEigenFaces) * (U(:,1:numberEigenFaces).' * (image - Avg)) + Avg;
end

function accuracy = getAccuracy(image, constructedImage)
    accuracy = ((abs(norm(image) - norm(constructedImage))) / norm(image));
end


function imageSVDShow(U, avg, numFaces, image, d1, d2)
    image = U(:,1:numFaces) * (U(:,1:numFaces).' * (image - avg)) + avg;
    imshow(uint8(reshape(image, d1, d2)));
end


