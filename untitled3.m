%b = double(rgb2gray(imread('./faces/9326871.1.jpg')));
%b = double(rgb2gray(imread('./faces/9326871.2.jpg')));

%b = double(rgb2gray(imread('face.jpeg')));
%b = double(rgb2gray(imread('face2.jpeg')));
%b = double(rgb2gray(imread('f4001.jpg')));
%b = double(rgb2gray(imread('herold.png')));

b = double(imread('./test/0/mnist_0_1.jpg'));

input = double(imread('lotsofaces.bmp'));
input = imresize(input, [size(input, 1) * 4, size(input, 2) * 4]);

height = 200;
width = 180;

[d1, d2] = size(U);
[d_1, d_2] = size(input);
limit = 11000;
Ubound = 100;

faces = [];

for i=1:100:(d_2 - width)
    
   for j=1:100:(d_1 - height)      %rows
      
      i
      j

      in = input([j: j+height - 1], [i: i+width - 1]);

      in = reshape(in, height * width, 1);
      Pb = (U(:,1:Ubound) * (U(:,1:Ubound).' * (in - avg)));
      error = norm(Pb - avg);
      if error < limit
          faces = [faces, in];
         %imshow(uint8(reshape(in, height, width))); 
         j = j + height; %leap forward so we're not doing the same thing
      end
      
      clear in;
      clear Pb;
   end
end



%b = imresize(b, [200, 180]);
%imshow(uint8(b));
%size(b)
%b = reshape(b, 200 * 180, 1);
%i = 100;
%Pb = (U(:,1:i) * (U(:,1:i).' * (b - avg)));

%imshow(uint8(reshape(Pb, 200, 180)));

%size(Pb)
%size(b)

%size(faces)
for i=1:size(faces, 2)
   imshow(uint8(reshape(faces(:,i), height, width))); 
end

%imshow(uint8(reshape(Pb, 200, 180)));

%error = norm(Pb - avg)