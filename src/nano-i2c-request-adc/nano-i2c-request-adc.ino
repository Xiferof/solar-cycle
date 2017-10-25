#include <Wire.h>

#define I2C_ADDRESS 8

#define NUM_OF_LEDS 3

#define LED_GREEN   15
#define LED_YELLOW  16
#define LED_RED     17

#define SENSOR_PIN  A0

// Turn on Serial:
// #define VERBOSE_SERIAL 1



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

// print the first NUM_OF_LEDS bits of value to the LEDs
void set_leds(int value) {
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

    char leds;
    int sensor_value;

    leds = Wire.read();
    sensor_value = get_sensor()

    Wire.write(sensor_value);

    set_leds(leds);
}

void setup() {
    for (int i = 0; i < NUM_OF_LEDS; i++) {
        pinMode(leds[i], OUTPUT);
        digitalWrite(leds[i], LOW);
    }
    Wire.begin(I2C_ADDRESS);
    Wire.onReceive(receiveEvent);
#if defined(VERBOSE_SERIAL)
    Serial.begin(9600);
#endif
}

void loop() {
#if defined(VERBOSE_SERIAL)
    Serial.println(get_sensor());
#endif
    delay(100);
}
