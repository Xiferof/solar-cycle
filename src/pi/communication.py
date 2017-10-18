
try:
    import RPi.GPIO
    import smbus
except:
    print("************************************")
    print("*************WARNING!!!*************")
    print("************************************")
    print("Either Hardware libraries missing or on Dev Machine... Creating mocking Functions")
    print("*************END WARNING************")
    class smbus:
        class SMBus:
            def __init__(self,Address):
                pass
            def write_byte_data(self,address,offset,value):
                print("Wrote at address "+ str(address)+"and offset "+str(offset)+" Value "+str(value))

class I2CHandler:
    def __init__(self,I2CMasterAddress = 1):
        self.bus = smbus.SMBus(I2CMasterAddress)
        self.slaves = []
    def addSlave(self,address,Pos):
        self.slaves.append((address,Pos))
        return len(slaves)-1 #<= Id of Slave just created
    def writeAll(self,value):
        for x in self.slaves:
            self.writeOne(x[0],value)
    def writeOne(self,address,value):
        self.bus.write_byte_data(address,0,value)
