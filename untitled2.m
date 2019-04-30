p = imread('./faces/cgboyc.1.jpg');
p = double(rgb2gray(p));
p = reshape(p, 200 * 180, 1);
p = p - avg;
coordinates = U.' * p;

coordinates = coordinates.';
i = 5;
j = 8;
z = 4;
h = 9;


%coordinates(z) = coordinates(z) * -5;
q = rgb2gray(imread('./faces/9338527.5.jpg'));
imshow([uint8(reshape(U * coordinates.' + avg, 200, 180)), uint8(reshape(U * temp.' + avg, 200, 180)), q]);

figure
plot(x, coordinates);
xlabel('Eigenface Number');
ylabel('Coordinate cooresponding to the given eigenface');
title('Coordinate of each eigen face in the Construction of a reasonable face');