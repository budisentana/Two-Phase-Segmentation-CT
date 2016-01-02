%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CDSC: segmentation package
%
%   This is the main function to run the segmentation demo.
%   The input is low-dose (25% projections) CT reconstructed 
%   image using EM+TV method and the final output is the 
%   segmentation mask. This code is only for demo  purpose.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author: Noirin Duggan (noirinduggan@gmail.com, Egil Bae
%   (ebae@math.ucla.edu) and Shiwen Shen (shiwenshen@ucla.edu)
%   Date: 09/28/2014
%   Copy rignt: medical imaging informatics group, UCLA


clc;
clear;
close all;
wkdir = pwd;



    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%imgae read
info = analyze75info('PAT1_CT_RECON_FBP.hdr');  % Replace with path of Analyze 7.5 image file 
xyzSpacing=[0.7;0.7;1.25];
volume_image=analyze75read('PAT1_CT_RECON_FBP'); 
volume_image = flipdim(volume_image,1);
volume_image=double(volume_image);
viewBinaryMask(volume_image);    

%%%%%%%%%%%%%%%%%%%%%%%
%get two phase segmentation result
% lp = 1e-12; % increase this value for less fine detail (maximum tested value = 2)
lp = 1e-13; % increase this value for less fine detail (maximum tested value = 2)
errb = [1e-1,5e-4];  
% ulab = [0.3, 0.6];
% ulab = [0.03, 0.25];
ulab = [0.1, 0.4];
%data clamp
upperBand=80;
lowwerBand=0;
volume_image(volume_image > upperBand) = upperBand;      
volume_image(volume_image < lowwerBand) = lowwerBand;
% scale data
volume_image = (volume_image-min(volume_image(:)))./(max(volume_image(:))-min(volume_image(:)));
[intialSegResult, timet] = CMF3D_Cutcv(volume_image, lp, errb, ulab);
viewBinaryMask(intialSegResult);



    