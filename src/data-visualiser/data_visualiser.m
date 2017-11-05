%{
    /*******************************\
    |                               |
    |   Data Visualiser             |
    |       IoT                     |
    |       Casper van Wezel        |
    |       2017-11-03              |
    |                               |
    \*******************************/
%}

clc
clear all
close all

filenameMAT = '../dataset.mat';

PLOT_FRAMES = 01;
EXPORT_GIF = 01;
filenameGIF = [filenameMAT(1:end-4) '.gif'];

%% load the data and retreive parameters
load(filenameMAT);
simSteps = size(data,1);
dimX = 2;
dimY = 1;

% estimate the gridSize:
u = unique(housesCoords(:,1));
gridSizeX = max(u)/numel(u) + max(u);

u = unique(housesCoords(:,2));
gridSizeY = max(u)/numel(u) + max(u);

gridSize(dimX) = gridSizeX;
gridSize(dimY) = gridSizeY;

clear u gridSizeX gridSizeY;


%% plot the data
if (PLOT_FRAMES)
    if (EXPORT_GIF)
        addpath(genpath('../../scripts/gif-toolbox/'));
        gif_delete(filenameGIF);
    end
 
    for t = 1:simSteps
        figure;
        xlim([0 gridSize(dimX)]);
        ylim([0 gridSize(dimY)]);
        hold on;

        %% plot all houses
        x = housesCoords(:,dimX);
        y = housesCoords(:,dimY);
        scatter(x,y,'g');

        %% plot shaded houses
        shadedHouses = housesCoords(data(t,:)==1,:);
        plot(shadedHouses(:,dimX),shadedHouses(:,dimY),'r*')

        if (EXPORT_GIF)
            gif_frame_write(t, filenameGIF);
        end
    end
end
