# MATLAB OCR for Grade Table Recognition

A MATLAB project that uses digital image analysis and template matching to automatically recognize numerical grades from an image of a student roster, assign letter grades, and calculate class statistics.

This project is a solution to the "Synthesis: Character Recognition" homework assignment for the ERE 622 - Digital Image Analysis course.



---

##  Overview

The goal of this project is to build an algorithm that can read an image containing a table of student grades. The system must be robust enough to handle variations in contrast and noise. The workflow involves several key stages of image processing:

1.  **Pre-processing:** The input image is cleaned and converted into a binary format.
2.  **Table Detection:** The algorithm automatically locates the columns of interest ("Final Grade" and "Grade Letter"), even if they are shifted.
3.  **Character Segmentation & OCR:** Individual numbers within the "Final Grade" column are isolated and identified using a template-matching technique.
4.  **Analysis & Rendering:** Letter grades are assigned based on the recognized scores, statistics are calculated, and the final results are rendered onto the output image.

---

##  Features

-   **Automatic Table Detection:** Intelligently locates table columns using morphological operations and region properties, making it robust to shifts in layout.
-   **Template-Matching OCR:** Uses normalized cross-correlation to recognize digits from 0-9 and letters A-F based on a provided key.
-   **Modular Codebase:** The logic is separated into a clean driver script and several single-purpose helper functions for clarity and reusability.
-   **Statistical Analysis:** Automatically calculates the mean, standard deviation, and the number of failing students from the recognized grades. 
-   **Visual Output:** Generates a new image with the corresponding letter grades drawn into the "Grade Letter" column for easy verification.

---

##  Requirements

-   MATLAB (R2020a or newer recommended)
-   Image Processing Toolbox (for `regionprops`, `imcrop`, `normxcorr2`, etc.)

---

##  How to Use

1.  Place the main script (`runGradeOCR.m`) and all the helper functions (`prepareOCRTemplates.m`, `findTableColumns.m`, etc.) in the same directory.
2.  Ensure the required image files (`test_ocr.tif`, `train_ocr.tif`, `key.tif`) are also in that directory or in the MATLAB path.
3.  Open the main driver script, **`runGradeOCR.m`**.
4.  Modify the **Configuration** section at the top of the script to select your target image.

    ```matlab
    % --- 1. CONFIGURATION ---
    imagePath = 'test_ocr.tif';  % <-- Target image: 'test_ocr.tif' or 'train_ocr.tif'
    templatePath = 'key.tif';    % Image containing character templates
    binarizationThreshold = 120; % Adjust as needed for different image contrasts
    ```

5.  Run the script. The final image will be displayed and saved, and the statistics will be printed to the command window.

---

##  Function Reference

-   **`runGradeOCR.m`**: The main script that orchestrates the entire workflow.
-   **`prepareOCRTemplates.m`**: Loads the `key.tif` image and extracts individual character templates for matching.
-   **`findTableColumns.m`**: Analyzes the image to automatically find the bounding boxes of the grade and letter columns.
-   **`recognizeGrades.m`**: Takes the grade column, segments each number, and performs OCR to return the numeric grades and statistics.
-   **`renderGrades.m`**: Takes the original image, the recognized grades, and the templates to produce the final output image with letter grades drawn in.

---
