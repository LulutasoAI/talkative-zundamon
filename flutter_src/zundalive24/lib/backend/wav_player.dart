
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
class WavPlayer {
  AudioPlayer _audioPlayer = AudioPlayer();
  String last_file = "";
  Future<void> playWav(String filePath,) async {
    String cwd = Directory.current.path;
    print('Current Working Directory: $cwd');
    
    filePath = adjustPath(filePath);
    print(filePath);
    if (last_file == filePath) {
      return;
    }else{
      last_file = filePath;
    }
    _audioPlayer.play(DeviceFileSource(filePath));
    
  }
  String adjustPath(String path){
    return r"..\..\python_src\" + path;
  }
}
