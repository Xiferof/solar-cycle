#@author Anirudh Bisht
#@brief This script send the files from dev machine to Pi
## Add files you want on the pi to the dependency mentioned below
## Keep dependencies clean , line sperated
##If you want to avoid typing your password everytime add your public key to pi authorized keys(~/.ssh/authorized_keys)
DEPENDENCYFILE=deps.txt

cat $DEPENDENCYFILE | xargs -Iz scp z pi@raspberrypi.local:~/solar-cycle/src/pi/
