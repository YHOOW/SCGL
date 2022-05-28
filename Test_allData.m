%   SCGL version 1.0 --May/2022 
%
%   Written by Hongwei Yin (email: yin7823277@sina.com)
%   please cite this paper
%   "Incremental multi-view spectral clustering with 
%   sparse and connected graph learning" Neural Networks, 2021

clc; close all;clear
%% addpath
addpath(genpath('functions'))
load('handwritten');
groundtruth=Y;
K=numel(unique(groundtruth));  % cluster number
disp('************start*************');

%% Set parameters
lambda     = 0.8;
Neighbor   = 20; 

tic

[ACC,ARI,NMI]       = Test_SCGL(X,K,Neighbor,lambda,groundtruth);
temp_time = toc



