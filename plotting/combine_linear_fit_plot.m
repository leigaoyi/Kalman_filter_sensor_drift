% Assuming you have saved your individual figures as 'figureA.png' and 'figureB.png'

% Load the images
imgA = imread('figureA.png');
imgB = imread('figureB.png');

% Create a new figure
figure;

% Plot the first image (figure A)
subplot(2, 1, 1);
imshow(imgA);
title('Figure A');

% Plot the second image (figure B) and draw a box to highlight the region
subplot(2, 1, 2);
imshow(imgA); % Display figure A
hold on;
h = imshow(imgB);
title('Figure B');

% Define the coordinates of the box
box_x = [x1, x2, x2, x1, x1]; % Replace x1 and x2 with appropriate coordinates
box_y = [y1, y1, y2, y2, y1]; % Replace y1 and y2 with appropriate coordinates

% Draw the box on figure A to highlight the region of figure B
plot(box_x, box_y, 'r', 'LineWidth', 2); % You can change the color and line width

hold off;

% Adjust subplot layout
subplot(2, 1, 1);
axis tight;
subplot(2, 1, 2);
axis tight;

% Adjust figure size and position if needed
set(gcf, 'Position', [100, 100, 800, 800]); % Adjust as desired

% Add any additional annotations or labels if needed

% Save the combined figure
print('combined_figure.png', '-dpng', '-r300'); % Specify the desired image format and resolution
