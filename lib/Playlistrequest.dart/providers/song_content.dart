import 'package:flutter/foundation.dart';

class SongContent extends ChangeNotifier{
  //  String downloadURL = " ";
  //  String songName = " ";
var file = "<<<<  am here >>>>>>>";
  void updateSong(files){
    file = files.toString();
    //downloadURL = songUrl;
    //songName = songtitle;

    notifyListeners();
  }

  // String getDownloadSongUrl(){
  //   //return downloadURL;
  // }

  // String getDownloadSongName(){
  //   return songName;
  // }

}