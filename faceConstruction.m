
% tweaking the coordinates of a face using svd
% This script builds a U d avg for the face transformation and applies the 
%       transformation on a given image

%only do this once, this is a large computation
%[U, d, avg] = CreateEigenBasis('./data/faces/'); 



scaling = [   0.1365
   -0.5366
   -0.9113
 -204.0316
   -0.0843
    2.3674
   -2.5614
    0.3491
    0.9110
    0.9150
    3.5976
    6.6516
   -1.3332
   -1.2074
   -0.5926
    6.9722
   -0.4040
   -1.0880
   -1.1998
   -1.5044
   -9.5399
   -0.3330
    0.5872
    1.9078
   -0.4029
    2.7986
    0.3275
    3.2380
    0.7409
    0.8245
    2.8161
    2.6137
    0.0777
    3.8884
   -1.0562
   -5.2316
   -3.0203
    0.3322
   -0.0231
   -0.0654
    0.2143
    0.2150
   -0.5709
    2.8714
   -0.1588
    3.0795
   -2.5837
   -0.4567
   -1.0971
   -0.9126
];
size(scaling)


%some image reshaping - we want a single vector with average loss
%face we are targetting
a = rgb2gray(imread('./data/faces/9338527.4.jpg'));

%starting position
p = imread('./data/faces/cgboyc.1.jpg');
p = double(rgb2gray(p));
p = reshape(p, 200 * 180, 1);
p = p - avg;                 %need to already have calculated avg


%transpose coordinates
coordinates = U.' * p;       %need to already have calculated U

%coordinates = coordinates.'; %coordinates of the matrix
Orig = coordinates;



%change the coordinates of a face
coordinates([1:50]) = coordinates([1:50]) .* scaling;      %EXAMPLE


%shows origional and final image
imshow([uint8(reshape(U * coordinates + avg, 200, 180)), uint8(reshape(U * Orig + avg, 200, 180)), aexit
    ]);
x = 1:size(coordinates);

%plots coordinates of matrix with respect to eigenface number
figure
plot(x, coordinates);
xlabel('Eigenface Number');
ylabel('Coordinate cooresponding to the given eigenface');
title('Coordinate of each eigen face in the Construction of a reasonable face');