function templates = prepareOCRTemplates(templatePath)
    keyImage = imread(templatePath);
    keyImageBW = keyImage < 128; % Binarize
    
    % Use regionprops to automatically find all characters
    props = regionprops(keyImageBW, 'BoundingBox', 'Image');
    
    % Hardcoded character map based on 'key.tif' layout
    charMap = '1234567890ABCDEF'; 
    
    templates = struct('Character', [], 'Image', []);
    for i = 1:length(props)
        templates(i).Character = charMap(i);
        templates(i).Image = props(i).Image;
    end
end