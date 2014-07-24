import ddf.minim.*;

Minim minim;
AudioInput in;
ArrayList <Samples> recordings = new ArrayList<Samples>();
int recordFile, recordString, counter;
boolean recordStatus = false;
boolean startRecord = true;

void setup() {
  size(500, 200);
  
  frameRate(30);

  minim = new Minim(this);
  in = minim.getLineIn();

  textFont(createFont("Arial", 12));
}

void draw() {
  
  background(0); 
  stroke(255);

  // ---> VIZ (from the Minim example)
  for (int i = 0; i < in.bufferSize () - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  
  // ---> SAMPLE
  if (recordStatus) {
    text("Recording...", 5, 15);
    if (startRecord) {
      recordings.get(recordFile).startRecording();
      counter = millis() + 8000;
      startRecord = !startRecord;
    }
    else if (millis() > counter) {
      recordings.get(recordFile).saveRecording();
      recordFile++;
      recordStatus = !recordStatus;
    }
  }
  else if (!recordStatus) {
    text("Not recording...", 5, 15);
  }
  
  // ---> PLAY SAMPLES
  // millis() wasn't acurate
  if (frameCount % 240 == 0 && recordings.size() > 0) {
    for (int i = 1; i < recordings.size (); i++) {
      recordings.get(i).playSound();
    }
  }
  
}

void keyReleased() {
  // Press tp record but will auto-stop
  if ( key == 'r' ) {
    recordings.add(new Samples(recordString + recordFile, in));
    recordStatus = !recordStatus;
    startRecord = !startRecord;
  }
  
  // Stop & clean
  if (key == 's') {
    for (int i = 0; i < recordings.size (); i++) {
      recordings.get(i).stopClean();
      recordString += 10;
    }
  }
}
