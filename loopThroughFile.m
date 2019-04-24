function [faceMatrix] = loopThroughFile(folderPath)
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


function [S,D,V] = imagecompress(numberKeepTerms, imageFile)
    %Imagecompress compresses an image using svd transformation
    imageMat = double(rgb2gray(imread(imageFile)));
    [d1, d2] = size(imageMat);


    [A, B, C] = svd(imageMat);

    [A, B, C] = gather(A, B, C);
    B = diag(B);

    s = numberKeepTerms;
    %S - first s cols of A
    S = A(:,(1:s));

    %V - first s cols of C
    V = C(:,(1:s));
    %D - first s diagonals of B
    D = B(1:s);
    s1 = size(S);
    s2 = size(V);
    storageSize = s1(1) * s1(2) + s2(1) * s2(2) + s;
    %NOTE we would be storing S V and D
    %Obviously redundant - we've just put the image back to place
    Out = S * diag(D) * V.';
    imshow([uint8(imageMat), uint8(Out)]);

    fprintf("initial data stored in black and white = %i mat elements\n", d1 * d2);
    fprintf("final data stored in black and white svd = %i elements\n", storageSize);
    fprintf("ratio of data storage: final / initial = %f %%\n", storageSize / (d1 * d2));

end

function imageSVDShow(s,v,d)
    imshow(uint8(s * diag(v) * d.'));
end
