function []= imageSVDShow(s,v,d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imshow(uint8(s * diag(v) * d.'));
end

