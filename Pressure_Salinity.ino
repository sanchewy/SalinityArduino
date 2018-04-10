
int salinityPin = A0;
int pressurePin = A1;
int buttonPin = 2;
int ledPin = 13;

int numMeasurements = 10;

int pressureValue = 0;
int salinityValue = 0;
int buttonState = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT);
}

void loop()
{
  buttonState = digitalRead(buttonPin);
  if(buttonState == HIGH) {
    for(int i = 0; i <= numMeasurements - 1; i++) {
      salinityValue = analogRead(salinityPin)/4;
      pressureValue = analogRead(pressurePin)/4;
      Serial.print(salinityValue, DEC);
      Serial.print(",");
      Serial.print(pressureValue, DEC);
      Serial.print(";");
    }
    Serial.println(); //linefeed character
    delay(1000);
  }
}
