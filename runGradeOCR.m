% =========================================================================
% runGradeOCR.m
% 
% This script runs a complete OCR workflow on an image of student grades.
% It automatically finds the table, recognizes the numbers, assigns
% letter grades, and calculates statistics.
% =========================================================================
clear; clc; close all;

% --- 1. CONFIGURATION ---
imagePath = 'test_ocr.tif';  % <-- Target image: 'test_ocr.tif' or 'train_ocr.tif'
templatePath = 'key.tif';    % Image containing character templates
binarizationThreshold = 120; % Threshold to convert image to black and white

% --- 2. PREPARE TEMPLATES ---
fprintf('Loading and preparing character templates...\n');
templates = prepareOCRTemplates(templatePath);

% --- 3. LOAD AND PRE-PROCESS IMAGE ---
fprintf('Loading and pre-processing the grades image...\n');
originalImage = imread(imagePath);
binaryImage = originalImage < binarizationThreshold; % Binarize the image

% --- 4. FIND GRADE AND LETTER COLUMNS ---
fprintf('Automatically locating table columns...\n');
[gradeColumnBox, letterColumnBox, allBoxes] = findTableColumns(binaryImage);
if isempty(gradeColumnBox)
    error('Could not automatically identify the "Final Grade" column.');
end

% --- 5. RECOGNIZE GRADES AND ASSIGN LETTERS ---
fprintf('Performing OCR on the grade column...\n');
[grades, stats] = recognizeGrades(binaryImage, gradeColumnBox, templates);

% --- 6. VISUALIZE AND REPORT RESULTS ---
fprintf('Generating output image and statistics...\n');
outputImage = renderGrades(originalImage, letterColumnBox, grades, templates);

% Display results
figure('Name', 'OCR Results');
imshow(outputImage);
title('Final Output with Grades');
imwrite(outputImage, 'final_grades_output.png');

fprintf('\n--- Grade Analysis ---\n');
fprintf('Mean Grade:      %.2f\n', stats.mean);
fprintf('Std. Deviation:  %.2f\n', stats.std);
fprintf('Students Failed: %d\n', stats.failedCount);