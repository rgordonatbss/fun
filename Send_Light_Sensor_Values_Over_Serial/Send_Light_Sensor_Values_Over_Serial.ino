int lightval = 0;
const int LIGHT_SENSOR_PIN = 8;

void setup() {
  
  // Enable serial communication
  Serial.begin(9600);  
  
  // Tells Arduino to get the input pin
  pinMode(LIGHT_SENSOR_PIN, INPUT);

}

void loop() {
  
  // Read the light sensor value
  lightval = analogRead(LIGHT_SENSOR_PIN);
  
  // Output the light sensor value to the serial port
  Serial.write(lightval);
  
  // Slow things down so we can see the results on the serial monitor
  delay(50);
}
