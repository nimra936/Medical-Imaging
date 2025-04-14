function varargout = lung_cancer_detection(varargin)
% LUNG_CANCER_DETECTION MATLAB code for lung_cancer_detection.fig
%      LUNG_CANCER_DETECTION, by itself, creates a new LUNG_CANCER_DETECTION or raises the existing
%      singleton*.
%
%      H = LUNG_CANCER_DETECTION returns the handle to a new LUNG_CANCER_DETECTION or the handle to
%      the existing singleton*.
%
%      LUNG_CANCER_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LUNG_CANCER_DETECTION.M with the given input arguments.
%
%      LUNG_CANCER_DETECTION('Property','Value',...) creates a new LUNG_CANCER_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lung_cancer_detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lung_cancer_detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lung_cancer_detection

% Last Modified by GUIDE v2.5 22-Jul-2022 04:17:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lung_cancer_detection_OpeningFcn, ...
                   'gui_OutputFcn',  @lung_cancer_detection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before lung_cancer_detection is made visible.
function lung_cancer_detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lung_cancer_detection (see VARARGIN)

% Choose default command line output for lung_cancer_detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lung_cancer_detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lung_cancer_detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browseimage.
function browseimage_Callback(hObject, eventdata, handles)
% hObject    handle to browseimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img1 img2

[path,nofile]=imgetfile();

if nofile
    msgbox(sprintf('Image not found !!!'),'Error','Warning');
    return
end

img1=imread(path);
img1=im2double(img1);
img2=img1;

axes(handles.axes1);
imshow(img1)

title('Lungs CT Image')


% --- Executes on button press in medianfiltering.
function medianfiltering_Callback(hObject, eventdata, handles)
% hObject    handle to medianfiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img1
axes(handles.axes2)
if size(img1,3)==3
    img1=rgb2gray(img1);
end
K=medfilt2(img1);
axes(handles.axes2);
imshow(K);
title('Med Filter');


% --- Executes on button press in edgedetection.
function edgedetection_Callback(hObject, eventdata, handles)
% hObject    handle to edgedetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img1
axes(handles.axes3);

if size(img1,3)==3
    img1=rgb2gray(img1);
end
K=medfilt2(img1);
C=double(K);

for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        %Sobel mask for x-direction
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
        
        %The gradient of the image
        %B(i,j)=abs(Gx)+abs(Gy);
        B(i,j)=sqrt(Gx.^2+Gy.^2);
    end
end
axes(handles.axes3)
imshow(B);
title('Edge Detection');


% --- Executes on button press in segmentation.
function segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img1
axes(handles.axes4)
if size(img1,3)==3
    img1=rgb2gray(img1);
    img1=medfilt2(img1);
end

imData=reshape(img1,[],1);
imData=double(imData);
[IDX nn]=kmeans(imData,4);
imIDX=reshape(IDX,size(img1));

bw=(imIDX==1);
se=ones(5);
bw=imopen(bw,se);
bw=bwareaopen(bw,400);
axes(handles.axes4)
imshow(bw);
title('Segmentation');


% --- Executes on button press in cancerdetection.
function cancerdetection_Callback(hObject, eventdata, handles)
% hObject    handle to cancerdetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img1
axes(handles.axes5);
K=medfilt2(img1);
bw=im2bw(K, 0.7);
label=bwlabel(bw);

stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
cancer_label=find(area==max_area);
cancer=ismember(label,cancer_label);

se=strel('square',5);
cancer=imopen(cancer,se);

Bound=bwboundaries(cancer,'noholes');

imshow(K)
hold on

for i=1:length(Bound)
    plot(Bound{i}(:,2),Bound {i}(:,1),'y','linewidth',1.75)
end
title('Cancer Detected!');

hold off
axes(handles.axes5)
