import processing.serial.*;

Serial myPort;
Table table = new Table();
int linefeed = 10;   // Linefeed in ASCII
String sensors[];       // array to read the 4 values
String timestamp = "data/results";
// actual reading with the last one

void setup() {
  size(200, 200);
  // List all the available serial ports in the output pane.
  // You will need to choose the port that the Wiring board is
  // connected to from this list. The first port in the list is
  // port #0 and the third port in the list is port #2.
  table.addColumn("id");
  table.addColumn("Pressure");
  table.addColumn("Salinity");
  saveTable(table, "results.csv");
  
  println(Serial.list());

  myPort = new Serial(this, Serial.list()[1], 9600);
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil(linefeed);
}

void draw() {

    // now do something with the values read sensors[0] .. sensors[3]
    
}

void serialEvent(Serial myPort) {

  // read the serial buffer:
  String myString = myPort.readStringUntil(linefeed);

  // if you got any bytes other than the linefeed:
  if (myString != null) {

    myString = trim(myString);

    // split the string at the semicolons
    // and convert the sections into integers:
    sensors = (split(myString, ';'));

    int sumPressure = 0;
    int sumSalinity = 0;

    for (int sensorNum = 0; sensorNum < sensors.length-1; sensorNum++) {
      int temp[];
      temp = int(split(sensors[sensorNum], ','));
      sumPressure += temp[1]*4;
      sumSalinity += temp[0]*4;
    }
    
    sumSalinity = sumSalinity/(sensors.length-1);
    sumPressure = sumPressure/(sensors.length-1);
    
    println("Salinity: " + sumSalinity + " Pressure: " + sumPressure);
    
    TableRow newRow = table.addRow();
    newRow.setInt("id", table.getRowCount()-1);
    newRow.setInt("Salinity", sumSalinity);
    newRow.setInt("Pressure", sumPressure);
    saveTable(table, "results.csv");

    // add a linefeed after all the sensor values are printed:
    println("\n");

  }
}