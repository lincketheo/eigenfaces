
% tweaking the coordinates of a face using svd
% This script builds a U d avg for the face transformation and applies the 
%       transformation on a given image

%only do this once, this is a large computation
%[U, d, avg] = CreateEigenBasis('./data/faces/'); 

%some image reshaping - we want a single vector with average loss
p = imread('./data/faces/cgboyc.1.jpg');
p = double(rgb2gray(p));
p = reshape(p, 200 * 180, 1);
p = p - avg;                 %need to already have calculated avg


%transpose coordinates
coordinates = U.' * p;       %need to already have calculated U

%coordinates = coordinates.'; %coordinates of the matrix
Orig = coordinates;

%change the coordinates of a face
%coordinates(z) = coordinates(z) * -5;      %EXAMPLE


%shows origional and final image
imshow([uint8(reshape(U * coordinates + avg, 200, 180)), uint8(reshape(U * Orig + avg, 200, 180))]);
x = 1:size(coordinates);

%plots coordinates of matrix with respect to eigenface number
figure
plot(x, coordinates);
xlabel('Eigenface Number');
ylabel('Coordinate cooresponding to the given eigenface');
title('Coordinate of each eigen face in the Construction of a reasonable face');