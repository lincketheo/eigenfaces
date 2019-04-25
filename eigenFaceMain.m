function eigenFaceMain(numFaces, file, folderPath)
   %A is 1808000 x 130
   A = loopThroughFile(folderPath);
   Avg = mean(A, 2);
      
   %size(A)
   %B is 1808000 x 1
   B = reshape(double(imread(file)), 784, 1);
   [U, ~, ~] = svd(double(A), 'econ');
   
   B = U(:,1:numFaces) * (U(:,1:numFaces).' * (B - Avg)) + Avg;
   
   %B = U * U.' * (B - Avg) + Avg;

   imshow(uint8(reshape(B, 28, 28)));
end


%returns a matrix with all the n x m image matrices (must be the same size)
%as (m * n) x 1 vectors in as cols
function [faceMatrix] = loopThroughFile(folderPath)
    a = dir(fullfile(folderPath,'*.jpg'));
    fileNames = {a.name};
    faceMatrix = [];
    
    %loops through all files ad them to the matrix
    for k = 1:length(fileNames)
            filename = string(fileNames(k));
            filename = strcat(folderPath, filename);
            I = (imread(filename));
            [a, b] = size(I);
            I = reshape(I, [a * b, 1]);
            %possibility of dim missmatch
            faceMatrix = [faceMatrix, I];
    end
end



function imageSVDShow(s,v,d)
    imshow(uint8(s * diag(v) * d.'));
end


