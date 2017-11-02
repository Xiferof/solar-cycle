#include <Wire.h>

#define I2C_ADDRESS 10

#define NUM_OF_LEDS 3

#define LED_GREEN   15
#define LED_YELLOW  16
#define LED_RED     17

#define SENSOR_PIN  A0

// Turn on Serial:
  #define VERBOSE_SERIAL 1



enum ledStatus_t
{
    blank = 0x00,
    ok = 0x01,
    warning = 0x02,
    ok_warning = 0x03,
    error = 0x04,
    error_ok = 0x05,
    error_warning = 0x06,
    all = 0x07,
};

int leds[NUM_OF_LEDS] = {LED_GREEN, LED_YELLOW, LED_RED};
ledStatus_t globalLEDValue = 0x00;
int8_t sensor_value;
// print the first NUM_OF_LEDS bits of value to the LEDs
void set_leds(ledStatus_t value) {
  static ledStatus_t oldValue = blank;
  if(value == oldValue)
  {
    return;
  }
  else
  {
    oldValue = value;
  }
    for (int i = 0; i < NUM_OF_LEDS; i++) {
        digitalWrite(leds[i], value & (0x1 << i));
    }
}
// Because the LDR is a high impedance sensor,
// first switch the MUX of the ADC, then wait
// a bit so the ADC value can change, then sample.
int get_sensor() {
    int value;
    analogRead(SENSOR_PIN);
    delay(10);
    value =  analogRead(SENSOR_PIN);
    return value;
}

void receiveEvent(int howMany) {
    while(Wire.available())
    {
      globalLEDValue = Wire.read();
    }
    set_leds(globalLEDValue);

}

void sendEvent()
{
   Wire.write(sensor_value);
}

void setup() {
    for (int i = 0; i < NUM_OF_LEDS; i++) {
        pinMode(leds[i], OUTPUT);
        digitalWrite(leds[i], LOW);
    }
    Wire.begin(I2C_ADDRESS);
    Wire.onReceive(receiveEvent);
    Wire.onRequest(sendEvent);
#if defined(VERBOSE_SERIAL)
    Serial.begin(9600);
#endif
}
void loop() {
#if defined(VERBOSE_SERIAL)
    Serial.println(globalLEDValue);
#endif
    delay(100);
    sensor_value = ((get_sensor() >> 2) &0xFF);
}
