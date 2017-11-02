import communication
from time import sleep

bus = communication.I2CHandler()
i=0
# slavesInSystem = [3,4,5,6,7,8,9,10,11]
slavesInSystem = [10]
message = 0x02
while True:
    message = input("LED?")
    message = int(message)
    print(message)
    for address in slavesInSystem:
        try:
            bus.writeOne(address,message)
        except Exception as inst:
            # print("errror writing "+str(address))
            print(inst)
            # pass
        try:
            print("Sensor "+ str(bus.readOne(address)))
        except Exception as inst:
            # print("Error Reading "+str(address))
            print(inst)
            # pass
        sleep(0.4)
