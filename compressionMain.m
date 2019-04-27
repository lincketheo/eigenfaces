
function compressionMain(numberKeepTerms, imageFile)
    %compresses given image and stores it in memory as well as displays
    %the origional and compressed image side by side
        %@param numberKeepTerms number of singular values to keep
        %@param imageFile path to file
    
    %origional image matrix
    Origional = imread(imageFile);
    %if file is rgb, make it grey
    if length(size(Origional)) == 3
       Origional = rgb2gray(Origional);
    end
    
    %compress the image
    [U, d, V] = compressImage(numberKeepTerms, imageFile);
    
    
    
    %The following compresses images
    %   this is a proof of concept
    %   storing the images as bin files
    %   which are not optimized for images
    
    %save so we can write and read later on
    [u1, u2] = size(U);
    [d_1, d_2] = size(d);
    [v1, v2] = size(V);
    
    %write the origional matrix to memory
    writeMatrixToMemory(Origional, 'Orig', 'uint8');
    
    %write the compressed values 
    writeMatrixToMemory(U, 'U', 'double');
    writeMatrixToMemory(d, 'd', 'double');
    writeMatrixToMemory(V, 'V', 'double');

    %read the compressed values
    U1 = readMatrixFromMemory(u1, u2, 'U', 'double');
    d1 = readMatrixFromMemory(d_1, d_2, 'd', 'double');
    V1 = readMatrixFromMemory(v1, v2, 'V', 'double');

    %compress the image
    Compressed = showSVD(U1, d1, V1);
    %figure
    %plot(x, d)
    %title('Singular Values of Input Image vs Diagonal Index');
    %xlabel('Diagonal Index');
    %ylabel('Singular Value of Input Image');
    %show the images
    imshow([Origional, uint8(Compressed)]);
end

%from the given U D V, decompress image - obviously pretty straight forward
%throws an error if dim don't work
function [imageMain] = showSVD(U, d, V)
    %takes a U d V that was found using compressImage ( or any svd
    %that works with dimensions) and returns an imageMatrix
        %@params U d V, unitary matrices U V, diagonal values D
        %(as a vector d)
        
        %@return an image matrix to be used to display the compressed
        %image
        
        imageMain = U * diag(d) * V.';
end

%compress a given image using SVD transformation using the given
%numberKeepTerms
function [U, d ,V] = compressImage(numberKeepTerms, imageFile)
    %compresses an image using svd transformation
        %@param numberKeepTerms, number of singular vector / singular value
        %pairs to keep
        %@param imageFile file to read - no real specifications except
        
        %@return U an (n * m) x numberKeepTerms matrix of left singular
        %eigenvectors
        %@return D a numberKeepTerms x 1 vector of diagonal singular values
        %@return V an (n * m) x numberKeepTerms matrix of right singular
        %values (transposed)
    
    imageMain = imread(imageFile);
    
    %check if image is rgb or gray
    if length(size(imageMain)) == 3
        imageMain = rgb2gray(imageMain);
    end
    
    %double for svd transformation
    imageMain = double(imageMain);
    
    [d1, d2] = size(imageMain);      %size of imageMatrix to be calculated later on
    [U, D, V] = svd(imageMain);      %main computation
    
    d = diag(D); %only care about diagonal values (only vals stored in memory

    %S - first s cols of A
    U = U(:,(1:numberKeepTerms));
    d = d(1:numberKeepTerms);
    V = V(:,(1:numberKeepTerms));

    %done with computation - prints the amount of space we stored
    s1 = size(U);   
    s2 = size(V);
    storageSize = s1(1) * s1(2) + s2(1) * s2(2) + numberKeepTerms; %number of values stored as the array

    fprintf("initial data stored in black and white = %i mat elements\n", d1 * d2);
    fprintf("final data stored in black and white svd = %i elements\n", storageSize);
    fprintf("ratio of data storage: final / initial = %f %%\n", storageSize / (d1 * d2));
end


function [count] = writeMatrixToMemory(matrix, fileName, type)
    fid = fopen(fileName, 'w');
    count = fwrite(fid, matrix, type);
end

function [matrix] = readMatrixFromMemory(d1, d2, fileName, type)
    fid = fopen(fileName, 'rb');
    matrix = fread(fid, d1 * d2, type);
    matrix = reshape(matrix, d1, d2);
end