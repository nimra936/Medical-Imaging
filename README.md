# Medical-Imaging
This repository contains a MATLAB-based algorithm for detecting lung tumors from CT scan images. The pipeline includes:

Preprocessing: Noise reduction using a median filter

Segmentation: Lung extraction using thresholding/morphological operations

Edge Detection: Canny/Sobel for tumor boundary enhancement

Tumor Localization: Region-based analysis to identify malignant areas

Approach:
✔ Noise Reduction: Median filtering for improved image quality
✔ Lung Segmentation: Isolates lung region from surrounding tissue
✔ Tumor Detection: Identifies suspicious masses using edge/contour analysis
✔ GUI Visualization: Overlays detected tumors on original scans

Installation & Setup

MATLAB Requirements:
MATLAB R2020b or later
Image Processing Toolbox

Add to MATLAB Path:
Open MATLAB and navigate to the project folder

Run:
addpath(genpath(pwd));  

Load a CT scan:
img = imread('data/input/scan.png');  

Run the detection pipeline:
[tumor_mask, detected_img] = detect_lung_tumor(img);  

View results:
Gui visualization

File Structure
Copy
├── data/  
│   ├── input/          # Raw CT scans (DICOM, PNG, JPG)  
│   └── results/        # Processed outputs  
├── src/  
│   ├── preprocess.m    # Median filtering  
│   ├── segment.m       # Lung segmentation  
│   ├── detect.m        # Tumor localization  
│   └── visualize.m     # Result visualization  
├── detect_lung_tumor.m # Main script  
└── README.md  
