function [normU] = spectral_clustering(W,k)
D = diag(1./sqrt(sum(W, 2)+eps));
W = D * W * D+eps;
[U, ~, ~] = mySVD(W,k);
normU = normr(U);
end
