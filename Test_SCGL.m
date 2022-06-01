function [ACC,ARI,NMI]= Test_SCGL(X,k,Neighbor,lambda,label)
v    = length(X); % view number      
[n,~]= size(X{1});% sample number

%% Initialize the similarity matrices for each view
for i = 1:v
    for  j = 1:n
         X{i}(j,:) = ( X{i}(j,:) - mean( X{i}(j,:) ) ) / std( X{i}(j,:) ) ;
    end
    CW{i}= constructW_PKN(X{i}', Neighbor);  
end

%% Set the first consensus similarity matrix
W_ast=CW{1};
mu_1=0.5; mu_2=0.5; index=1;
%% Obtain the consensus similarity matrix Incrementally
for j = 2:v
    
%% update consensus similarity matrix W_ast    
    Ft   =spectral_clustering(W_ast,k);  % old spectral embedding
    Ft_1 =spectral_clustering(CW{j},k);   % new spectral embedding
    [W_ast,mu_1,mu_2]= solve_W(Ft,Ft_1,lambda,mu_1,mu_2);
%% obtain the clustering result one by one    
    F       = spectral_clustering((W_ast+W_ast')/2,k);
    if ~isreal(F) 
    disp(['output error']);
    end
    idy          = kmeans(F, k, 'emptyaction', 'singleton', 'replicates', 1, 'display', 'off');
    ARI(index)       = rand_index(idy, label);
    NMI(index)       = computeNMI(idy, label);
    ACC(index)       = Accuracy(idy, label);
    index=index+1;
end
end
