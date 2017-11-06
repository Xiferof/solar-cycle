Some MATLAB functions which can be used to save plots to a .gif file.

Author: Casper van Wezel
Date: 2017-11-03

Based on:
see source code

Usage:
```
%% GIF: code header
EXPORT_GIF = 01;
filenameGIF = '../dataset.gif';


%% GIF: init
if (EXPORT_GIF)
    addpath(genpath('../../scripts/gif-toolbox/'));
    gif_delete(filenameGIF);
end

%% GIF: execute per frame (so in the for-loop)
if (EXPORT_GIF)
    gif_frame_write(t, filenameGIF);
end
```
