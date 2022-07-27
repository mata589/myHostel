import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vox_vibe/Playlistrequest.dart/likedsongs.dart';
//import 'package:vox_vibe/database.dart';
import 'package:vox_vibe/Playlistrequest.dart/model/liking.dart';

class FirestoreServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final songref = FirebaseFirestore.instance.collection('likedSongs');
   Future<void> savesong(like song) {
   //return _db.collection('likedsongs').doc(song.songId).set(song.toMap());
    return _db.collection('likedSongs').
    add({'song':song.songId,'likes':song.likes,'songurl':song.songurl});
   }

 //Stream<List>
  // getLiked (){
  // return songref.getDocuments();
  
  // then((QuerySnapshot snapshot) {
  // snapshot.docs.forEach((DocumentSnapshot doc) {
  //   print(doc.data);
  //  });
  // });

 

Stream<List<like>> getLiked() {
    return _db.collection('likedSongs').snapshots().map((snapshot) =>
        snapshot.docs.map((docs) => like.fromFirestore(docs.data())).toList());
  }
  // Stream<List<like>> getLiked() {
  //   return _db.collection('likedSongs').snapshots().map((snapshot) =>
  //       snapshot.docs.map((docs) => like.fromFirestore(docs.data())).toList());
  // }
}
// Firestore.instance.collection("you_Collection_Path").add({
//   "key":value //your data which will be added to the collection and collection will be created after this
// }).then((_){
//   print("collection created");
// }).catchError((_){
//   print("an error occured");
// });