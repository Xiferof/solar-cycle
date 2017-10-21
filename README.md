# Solar-Cycle
IoT-2017 project
# Introduction
This project is for designing a algorithm, simulation and hardware model for system that monitor solar energy irradiance and correlate with cloud cover the power genreation to make smarter energy grids.

# Dependencies
To run the code on the pi the following steps need to be taken
Taken from here [link](http://skpang.co.uk/blog/archives/575)

TL;DR
- Enable i2c on pi

`sudo raspi-config`
- And in menus In Interfacing options enable i2c
- Ensure Python dev functionality is installed

`sudo apt-get install python-dev`
- Install Python smbus

`sudo apt-get install python-smbus`
- Install i2c Tools

`sudo apt-get install i2c-tools`

# Authors
- Anirudh Bisht
- Nikolas Skartsilas
- Casper van Wezel
