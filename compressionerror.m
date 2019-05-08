
ratios = [];
norms = [];
for i=1:180
    [s, normVal] = compressionMain(i, './data/faces/9326871.1.jpg')
    ratios = [ratios, s];
    norms = [norms, normVal];
end

x = 1:180;

figure
plot(x, norms);
title('Accuracy of a Compression Through SVD');
xlabel('Number of Kept Singular Values');
ylabel('Frobenius Norm of Compressed - Origional Image');