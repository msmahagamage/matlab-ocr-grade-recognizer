function outputImage = renderGrades(originalImage, letterColumnBox, grades, templates)
    gradeLetters = assignGradeLetters(grades);
    letterTemplates = containers.Map({templates.Character}, {templates.Image});

    outputImage = originalImage;
    y_start = letterColumnBox(2) + letterColumnBox(4) + 5; % Start below the header
    x_center = letterColumnBox(1) + letterColumnBox(3)/2;
    
    for i = 1:length(gradeLetters)
        letter = gradeLetters(i);
        template = letterTemplates(letter);
        [h, w] = size(template);
        
        y_pos = round(y_start + (i-1) * 20.5); % Approximate row height
        x_pos = round(x_center - w/2);
        
        % Insert the letter template into the image
        outputImage(y_pos:y_pos+h-1, x_pos:x_pos+w-1) = uint8(template) * 255;
    end
end

function letters = assignGradeLetters(grades)
    letters = char(zeros(length(grades), 1));
    letters(grades >= 90) = 'A';
    letters(grades >= 80 & grades < 90) = 'B';
    letters(grades >= 70 & grades < 80) = 'C';
    letters(grades >= 60 & grades < 70) = 'D';
    letters(grades < 60) = 'F';
end