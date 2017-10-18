import communication
from time import sleep

bus = communication.I2CHandler()
address = 0x08
i=0
while True:
    bus.writeOne(address,i)
    i+=1
    sleep(2)
