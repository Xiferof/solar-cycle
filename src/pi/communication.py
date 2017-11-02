##@author Anirudh Bisht
##@brief Communication class that currently does hardware communication abstraction on the Pi
##@date 18-Oct-2017
##@todo: TODO: Add read functions for I2CHandler

try:
    import RPi.GPIO
    import smbus
except:
    print("************************************")
    print("*************WARNING!!!*************")
    print("************************************")
    print("Either Hardware libraries missing or on Dev Machine... mocking Functions")
    print("*************END WARNING************")
    class smbus:
        class SMBus:
            def __init__(self,Address):
                pass
            def write_byte_data(self,address,offset,value):
                print("Wrote at address "+ str(address)+"and offset "+str(offset)+" Value "+str(value))
#@brief Handler class for all I2C Communication for mode communication
## Currently only byte level communication, should be expanded for messages
class I2CHandler:
    ##@brief initialises the bus on the pi
    ##@param I2CMasterAddress the I2C port on the pi. /dev/i2c-1
    def __init__(self,I2CMasterAddress = 1):
        self.bus = smbus.SMBus(I2CMasterAddress)
        self.slaves = []
    ##@brief add a slave to list of broadcast nodes, With position in grid
    #@return the id of the created slave
    def addSlave(self,address,Pos):
        self.slaves.append((address,Pos))
        return len(slaves)-1 #<= Id of Slave just created
    ##@brief write to all slaves aka broadcast message
    #@param value the byte value to broadcast
    def writeAll(self,value):
        for x in self.slaves:
            self.writeOne(x[0],value)
    ##@brief write to one slave at a given address
    #@param address the I2C address to write to
    #@param value the byte value to write
    def writeOne(self,address,value):
        self.bus.write_byte(address,value)
    def readOne(self,address):
        response = self.bus.read_byte(address)
        return response
    def readResponse(self,address):
        for x in range(2):
            res = self.readOne(address)
            if(not res == 0):
                print("Not Expcted value!!")
