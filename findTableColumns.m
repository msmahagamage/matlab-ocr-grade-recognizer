function [gradeBox, letterBox, allBoxes] = findTableColumns(binaryImage)
    % Use morphological operations and regionprops to find text blocks
    vertLines = imclose(binaryImage, strel('line', 50, 90));
    horzLines = imclose(binaryImage, strel('line', 50, 0));
    tableMask = vertLines | horzLines;
    
    props = regionprops(tableMask, 'BoundingBox');
    
    % Assume the largest bounding box is the full table
    [~, idx] = max([props.Area]);
    tableBox = props(idx).BoundingBox;

    % Heuristic: Find columns within the table's vertical extent
    stats = regionprops(vertLines, 'BoundingBox');
    allBoxes = vertcat(stats.BoundingBox);
    
    % Assume Final Grade is the second to last, and Grade Letter is the last
    [~, sortOrder] = sort(allBoxes(:,1)); % Sort by x-position
    allBoxes = allBoxes(sortOrder,:);
    
    gradeBox = allBoxes(end-1, :);
    letterBox = allBoxes(end, :);
end