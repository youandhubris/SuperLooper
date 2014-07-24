class Samples {
  
  AudioRecorder recorder;
  AudioPlayer player;
  String strg;

  Samples(int i, AudioInput in) {
    strg = str(i);
    recorder = minim.createRecorder(in, "Sample_" + strg + ".wav");
  } 
  
  void startRecording(){
    recorder.beginRecord();
    println("Is recording...");
  }
  
  void saveRecording() {
    recorder.endRecord();
    recorder.save();
    println("Stopped recording and saved.");
    player = minim.loadFile("Sample_" + strg + ".wav");
  }
  
  void playSound() {
    if (recorder.isRecording() == false && player.isPlaying() == false) {
     player.play();
     player.loop();
      }
  }
  
  void stopClean() {
    player.close();
  }
}
