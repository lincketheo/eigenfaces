%scans an image containing faces in it and finds all the faces
%[U, d, avg] = CreateEigenBasis('./data/faces/'); 


%image to scan
input = double(imread('./data/lotsofaces.jpg'));
%make it larger so that faces are relatively the same size as eigenfaces
input = imresize(input, [size(input, 1) * 4, size(input, 2) * 4]);

height = 200;   %height of eigen face basis - no easy way of finding this from the size of each vector
width = 180;    %width of the eigen face basis face (an individual face that is)

%for indicing
[d1, d2] = size(U);
[d_1, d_2] = size(input);

%maximum error
limit = 11000;
%amount of U to keep
Ubound = 100;

%stores all the faces it finds in faces array
faces = [];

for i=1:100:(d_2 - width)          %cols
   for j=1:100:(d_1 - height)      %rows
      i %sanity check
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


%show all the faces it found
for i=1:size(faces, 2)
   imshow(uint8(reshape(faces(:,i), height, width))); 
end
