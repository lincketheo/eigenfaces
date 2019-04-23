%[S V D] = svd(double(rgb2gray(imread('face.jpeg'))));
Initial = S * V * D.';

[m, n] = size(Initial);
p1 = m * n

A = 0;

s = 10;
for c=1:1:s
    A = A + S(:,c)*V(c,c)*D(:,c).';
end
[m1, n1] = size(S); 
[m2, n2] = size(D);
p2 = m2 * s + m1 * s + s

imshow([uint8(A), uint8(Initial)]);

p2 / p1