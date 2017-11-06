%{
    /*******************************\
    |                               |
    |   figure to GIF tools         |
    |       IoT                     |
    |       Casper van Wezel        |
    |       2017-11-03              |
    |                               |
    \*******************************/
    Based on:
    https://nl.mathworks.com/matlabcentral/answers/94495-how-can-i-create-animated-gif-images-in-matlab
%}

function gif_frame_write(frameNumber, filename)
    % Capture the plot as an image 
    frame = getframe(gca);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);

    % Write to the GIF File 
    if frameNumber == 1
      imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
      imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end
