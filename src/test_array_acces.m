%{
    /*******************************\
    |                               |
    |   Sim Test Array Acces        |
    |       IoT                     |
    |       Casper van Wezel        |
    |       2017-11-03              |
    |                               |
    \*******************************/
%}

clc
clear all
close all

a = 0:99;
a = reshape(a,[10,10]);

coordx = [3;4];
coordy = coordx;
coord = [coordx,coordy]
size(coord)
size(a)
a(coord(:,1),coord(:,2))
a(coord)

idx = sub2ind(size(a),coord(:,1),coord(:,2))
a(idx)
return
for i = 1:size(coord,1)
    disp(a(coord(i,1),coord(i,2)))
end
