# Medical-Imaging

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
