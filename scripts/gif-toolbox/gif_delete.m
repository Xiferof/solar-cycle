%{
    /*******************************\
    |                               |
    |   figure to GIF tools         |
    |       IoT                     |
    |       Casper van Wezel        |
    |       2017-11-03              |
    |                               |
    \*******************************/
%}

function gif_delete(filename)
    if (exist(filename) == 2)
        delete(filename);
    end
end
