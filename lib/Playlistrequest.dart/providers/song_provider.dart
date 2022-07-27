
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vox_vibe/Playlistrequest.dart/model/liking.dart';
import 'package:vox_vibe/Playlistrequest.dart/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class songProvider with ChangeNotifier{
  final firestoreService = FirestoreServices();
  
   late String _songId;//songname
 late String _songurl;//Url of the song
 late int _likes = 0;
//var uuid = const Uuid();
 String get songId => _songId;
String get songurl => _songurl;
int get likes => _likes;
changesongurl(urL){
  _songurl = urL;
 notifyListeners();
}
 changesongId(files){
   _songId =files.toString();
   //file = files.toString();
  notifyListeners();
 }
changeLikes(){
   _likes =_likes + 1 ;
   notifyListeners();
}

savelikes(){

  print("$_likes");
  var newlikedsong = like(songId:_songId
  ,songurl: _songurl
  ,likes:likes);
  firestoreService.savesong(newlikedsong);
}

}