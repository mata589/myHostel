class like{
late final String songId;
late final String songurl;
late final int likes;

like({required this.songId
,required this.songurl
,required this.likes});
Map<String,dynamic> toMap(){
return {
  'songId': songId,
  'songurl':songurl,
  'likes':likes
};

}


like.fromFirestore(Map<String, dynamic> FirebaseFirestore)
: songId = FirebaseFirestore['songId'],
  likes = FirebaseFirestore['likes'],
  songurl = FirebaseFirestore['songurl'];
}