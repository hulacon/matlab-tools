function TwoVolScatter(vol1,vol2,trimZeros)
% TwoVolScatter(vol1,vol2,trimZeros)
% 
% Reads in information from two .nii volumes (specified by optional strings 
% vol1 and vol2), and then generates a scatterplot (values in each volume 
% for each voxel). Note that volumes must have same dimensions (# of vox)
% 
% set trimZeros to false to leave in 0 values
% 
% jbh 7/19/11
% jbh 3/24/15 tweaked substantially to use marghist

if ~exist('vol1','var')
    [a,b] = uigetfile('*.nii;*.nii.gz','Select first nifti file:');
    vol1 = fullfile(b,a);
end
[~, v1n] = fileparts(vol1);

if ~exist('vol2','var')
    [a,b] = uigetfile('*.nii;*.nii.gz','Select second nifti file:');
    vol2 = fullfile(b,a);
end
[~, v2n] = fileparts(vol2);


if ~exist('trimZeros','var')
    trimZeros = true;
end

% load in vols
% V1 = spm_vol_nifti(vol1);
% Y1 = spm_read_vols(V1);
V1=load_untouch_nii(vol1);
Y1=V1.img;

% V2 = spm_vol_nifti(vol2);
% Y2 = spm_read_vols(V2);
V2=load_untouch_nii(vol2);
Y2=V2.img;


X = Y1(:);
Y = Y2(:);
if trimZeros
    X(X==0)=nan;
    Y(Y==0)=nan;
end


% PLOT

v1nStr = strrep(v1n,'_',' ');
v2nStr = strrep(v2n,'_',' ');

% % marghist
marghist(horzcat(X,Y),'XYLabels',{v1nStr,v2nStr},'Colormap',[.2 .2 .2]);
% marghist(horzcat(X,Y),'FocalPoints',{[.5 .5]},'XYLabels',{v1nStr,v2nStr},'Colormap',[.2 .2 .2]);
hold on

% % Standard
% scatter(Y1(:),Y2(:),2,'k','filled');
% hold on
% % plot 1:1 line
% xMin = min(Y1(:)); 
% yMin = min(Y2(:)); 
% xMax = max(Y1(:)); 
% yMax = max(Y2(:)); 
% glMin = min([xMin; yMin]);
% glMax = min([xMax; yMax]);
% plot([glMin; glMax],[glMin; glMax],'r--')

% labels
%  xlabel(v1nStr);
%  ylabel(v2nStr);