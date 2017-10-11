#define NUM_OF_LEDS 3

#define LED_GREEN   15
#define LED_YELLOW  16
#define LED_RED     17

#define SENSOR_PIN  A0

int leds[NUM_OF_LEDS] = {LED_GREEN, LED_YELLOW, LED_RED};
int counter;

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
    // set_leds(1); // used to visualize sampling ADC delay
    analogRead(SENSOR_PIN);
    delay(10);
    value =  analogRead(SENSOR_PIN);
    // set_leds(0); // used to visualize sampling ADC delay
    return value;
}

void setup() {
    for (int i = 0; i < NUM_OF_LEDS; i++) {
        pinMode(leds[i], OUTPUT);
        digitalWrite(leds[i], LOW);
    }
    Serial.begin(9600);
}

void loop() {
    set_leds(counter++);
    Serial.println(get_sensor());
    delay(100);
}
