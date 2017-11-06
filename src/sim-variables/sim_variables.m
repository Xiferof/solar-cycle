%{
    /*******************************\
    |                               |
    |   Sim Cloud Variables         |
    |       IoT                     |
    |       Casper van Wezel        |
    |       2017-11-03              |
    |                               |
    \*******************************/
%}

%% Simulation
global simSteps;
simSteps = 9;

%% Grid
global gridSize;
global dimLabels;
global dimX;
global dimY;

gridSize = [100,100]; %sizeY, sizeX
dimLabels = ['y';'x'];
dimX = 2;
dimY = 1;

%% Houses:
global housesCoords;

housesNumX = 3;
housesNumY = 3;
housesSpacingX = gridSize(dimX) / (housesNumX+1);
housesCoordsX = round([1:housesNumX] * housesSpacingX);

housesSpacingY = gridSize(dimY) / (housesNumY+1);
housesCoordsY = round([1:housesNumY] * housesSpacingY);

housesCoords = perms_vect(housesCoordsX,housesCoordsY);

%% Clean up our mess:
%#TODO[c]: if the globals are fixed nicely, this should not be needed.
clear housesNumX;
clear housesNumY;
clear housesSpacingX housesCoordsX
clearvars housesSpacingY housesCoordsY

%% perms_vect permutations of 2 vectors
function result = perms_vect(a,b)
    aLength = size(a,2);
    bLength = size(b,2);
    result = zeros(aLength*bLength,2);
    for aa = 1:aLength
        for bb = 1:bLength
            result((aa-1)*bLength+bb,1) = a(aa);
            result((aa-1)*bLength+bb,2) = b(bb);
        end
    end
end
