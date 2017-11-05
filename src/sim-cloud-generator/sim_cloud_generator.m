%{
    /*******************************\
    |                               |
    |   Sim Cloud Generator         |
    |       IoT                     |
    |       Casper van Wezel        |
    |       2017-11-03              |
    |                               |
    \*******************************/
%}

clc
clear all
close all

PLOT_FRAMES = 01;
EXPORT_MAT = 0;
filenameMAT = '../dataset.mat';
EXPORT_GIF = 01;
filenameGIF = '../simulation.gif';

run('../sim-variables/sim_variables.m');

%% Cloud:
cloudSizeX = 40;
cloudSizeY = 40;
cloudSpeedX = 18; %units/simStep
cloudSpeedY = 18;
cloudOriginX = -40;
cloudOriginY = 0;

grid = zeros([simSteps,gridSize]);
grid(:,1,1) = 0.0001; %#BEUNS just to make the no-clouds draw blue as well

for t = 1:simSteps
    cloud = [cloudOriginX+(t-1)*cloudSpeedX,cloudOriginY+(t-1)*cloudSpeedY,cloudSizeX,cloudSizeY];
    gridCurr = reshape(grid(t,:,:),gridSize);
    grid(t,:,:) = set_rect_vect(gridCurr, cloud);
end
    clear('cloud'); % delete temporary variable

%% Sample our cloud now:
data = zeros([simSteps, size(housesCoords,1)]);
for t = 1:simSteps
    %convert the housesCoords into linear coords to acces the data
    %TODO[c] is this hassle really necessary?
    idx = sub2ind(gridSize,housesCoords(:,1),housesCoords(:,2));
    data(t,:) = grid(t,idx);
end

if (EXPORT_MAT)
    % save the data, just as it would be available from real-life
    save(filenameMAT,'data','housesCoords');
end

%% generate nice plots of the simulations
if (PLOT_FRAMES)
    if (EXPORT_GIF)
        addpath(genpath('../../scripts/gif-toolbox/'));
        gif_delete(filenameGIF);
    end
    for t = 1:simSteps
        gridCurr = reshape(grid(t,:,:),gridSize);
        h = figure;
        hold on;
        plot_cloud(gridCurr);
        shadedHouses = housesCoords(data(t,:)==1,:);
        plot(shadedHouses(:,dimX),shadedHouses(:,dimY),'r*')

        if (EXPORT_GIF)
            gif_frame_write(t, filenameGIF);
        end
    end
end

%% External Functions
function plot_cloud(grid)
    global housesCoords;
    global dimX;
    global dimY;

    contourf(grid);
    x = housesCoords(:,dimX);
    y = housesCoords(:,dimY);
    scatter(x,y,'g');
end

function grid_return = set_rect_vect(grid,cloud)
    xStart = cloud(1);
    yStart = cloud(2);
    width  = cloud(3);
    heigth = cloud(4);
    grid_return = set_rect(grid,xStart,yStart,width,heigth);
end

function grid_return = set_rect(grid,xStart,yStart,width,heigth)
    global gridSize;
    global dimX;
    global dimY;
    grid_return = grid;
    for y = yStart:yStart+heigth
        if (y > 0 && y < gridSize(dimY))
            for x = xStart:xStart+width
                if (x > 0 && x < gridSize(dimX))
                    grid_return(y,x) = grid(y,x) + 1;
                end
            end
        end
    end
end
