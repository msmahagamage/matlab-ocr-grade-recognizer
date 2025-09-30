function [grades, stats] = recognizeGrades(binaryImage, gradeColumnBox, templates)
    % Crop to the grade column and find individual numbers
    gradeColumnImage = imcrop(binaryImage, gradeColumnBox);
    props = regionprops(gradeColumnImage, 'BoundingBox', 'Image', 'Centroid');
    
    % Remove the column header by ignoring the top-most component
    [~, headerIdx] = min(arrayfun(@(x) x.Centroid(2), props));
    props(headerIdx) = [];
    
    grades = zeros(length(props), 1);
    for i = 1:length(props)
        charImage = props(i).Image;
        grades(i) = ocr_single_char(charImage, templates);
    end
    
    % Calculate statistics
    stats.mean = mean(grades);
    stats.std = std(grades);
    stats.failedCount = sum(grades < 60);
end

function grade = ocr_single_char(charImage, templates)
    % Find the best matching template using normalized cross-correlation
    maxCorr = -inf;
    bestChar = '?';
    for i = 1:length(templates)
        template = templates(i).Image;
        % Resize template to match character size for robust matching
        resizedTemplate = imresize(template, size(charImage));
        
        corrValue = normxcorr2(resizedTemplate, charImage);
        if max(corrValue(:)) > maxCorr
            maxCorr = max(corrValue(:));
            bestChar = templates(i).Character;
        end
    end
    grade = str2double(bestChar);
end