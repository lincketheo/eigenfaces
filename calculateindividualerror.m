
%tests the error function - compares origional image to eigen basis image
%[U, d, avg] = CreateEigenBasis('./data/faces/'); 


%some example faces and non faces to test the error on
%b = double(rgb2gray(imread('./faces/9326871.1.jpg')));
%b = double(rgb2gray(imread('./faces/9326871.2.jpg')));
%b = double(rgb2gray(imread('face.jpeg')));
%b = double(rgb2gray(imread('face2.jpeg')));
%b = double(rgb2gray(imread('f4001.jpg')));
%b = double(rgb2gray(imread('herold.png')));
%b = double(imread('./test/0/mnist_0_1.jpg'));


height = 200;
width = 180;

b = imresize(b, [height, width]);
b = reshape(b, 200 * 180, 1);
i = 100;

%projected b
Pb = (U(:,1:i) * (U(:,1:i).' * (b - avg)));

error = norm(Pb - avg);