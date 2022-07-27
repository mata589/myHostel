import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vox_vibe/Playlistrequest.dart/providers/song_content.dart';
import 'package:vox_vibe/Playlistrequest.dart/providers/song_provider.dart';
import 'package:vox_vibe/homePage.dart';
import 'package:vox_vibe/now.dart';

class liked extends StatefulWidget {
  const liked({Key? key}) : super(key: key);

  @override
  State<liked> createState() => _likedState();
}

class _likedState extends State<liked> {
  bool isLiked = false;
   var file ;
   late final songprovider = Provider.of<songProvider>(context,listen: false);
  late final songcontent = Provider.of<SongContent>(context,listen: false);
late Future<ListResult> futureFiles;
  void initState(){
    super.initState();
   futureFiles=  FirebaseStorage.instance.ref('test').listAll();
  }
  
  @override

  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
        title: const Text('tap to request song'),
       ),

       body: FutureBuilder<ListResult>(
        future:futureFiles,
        builder:(context, snapshot){
                if (snapshot.hasData){
                  final files = snapshot.data!.items;
                 
                 return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context,index){
                    file = files[index];
                    
                    //print("app generated => ${files[index]}");
                    return ListTile(
                      title: Text(file.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite,
                        color: Colors.red,), 
                        onPressed: () async { 
                          String songUrl = await files[index]. getDownloadURL();
                          print(songUrl);
                         // print("you tapped => ${files[index]}");
                               songprovider.changeLikes();
                               songprovider.changesongId(files[index].name);
                               songprovider.changesongurl(songUrl);
                   songcontent.updateSong(files[index].name);
                               showDialog(context: context,
      builder: (context) =>  AlertDialog(
        content:Text('You have liked '+ snapshot.data!.items[index].name+'  and it is going to be played next'),
        actions: [
         TextButton(
          onPressed: (){
            songprovider.savelikes();
            //  Navigator.push(
                        
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => nowe(
            //                           songModel: files[index].fullPath.,
            //                         )));
    //         Navigator.push(  
    // context,  
    // MaterialPageRoute(builder: (context) =>const HomePage())
    
    // );
          },
           child: Text('okay'),
           
           ),
           TextButton(
          onPressed: ()=> Navigator.pop(context),
           child: Text('like another song'),
           
           )

        ],
        
        )
      
      );
                               // downloadFile(file);

                         },
                        ),

                    );
                  }
                  
                  );

                }else if(snapshot.hasError){
                  return const Center(child: Text('error'),);
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }

        }
         ),

    );
  }
  
  Future<void> downloadFile(Reference ref) async {
    final url = await ref.getDownloadURL();

  // final dir = await getApplicationDocumentsDirectory();
  // final file = File('${dir.path}/${ref.name}');

  //   await ref.writeToFile(file);

final tempDir = await getTemporaryDirectory();
final Path = '${tempDir.path}/${ref.name}';
await Dio().download(url,Path);

    SnackBar(content: Text('Downloaded ${ref.name}'),);

  }
  
  void handleLikePost() {}
}