import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vox_vibe/Playlistrequest.dart/choose.dart';
import 'package:vox_vibe/Playlistrequest.dart/likedsongs.dart';
import 'package:vox_vibe/Playlistrequest.dart/storage.dart';
import 'package:vox_vibe/Playlistrequest.dart/upload.dart';
import 'package:vox_vibe/Playlistrequest.dart/vote.dart';

class Filelist extends StatefulWidget {
  final List<PlatformFile> files;
  //final ValueChanged<PlatformFile> onOpenedFile;
  const Filelist({Key? key, required this.files}) : super(key: key);

  @override
  State<Filelist> createState() => _FilelistState();
}

class _FilelistState extends State<Filelist> {
  var pick = upload.instance;
  var store = FirebaseStorage.instance;
  final Storage storage = Storage();
 FilePickerResult? result;
 late PlatformFile file;
selectFiles() async {
  result = (await FilePicker.platform.pickFiles(
        withReadStream: true, allowMultiple: true, type: FileType.audio))!;
              if(result == null){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('no song has been selected')));
                
              }
              
     file = result!.files.first ;
     final path = result!.files.single.path!;
    final fileName = result!.files.single.name;
    //file.add(result?.files);
    
  setState(() {});

    storage.uploadfile(path,fileName);
    loadselectedfiles(result!.files);
    setState(() {
      
    });

}
loadselectedfiles(List<PlatformFile> files){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
Filelist(files: files)
));

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('selected songs'),
      ),
      body:ListView.builder(
        itemCount: widget.files.length,
        itemBuilder: (context,index){
            final files = widget.files[index];
          return buildListFile(files);
        }),

       bottomNavigationBar: Container(
      height: 56,
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height: 80,
            color: Colors.red,
            child:  ElevatedButton(
  
  onPressed: () {
    selectFiles();
    },
  child: const Text('ADD SONGS'),
)
          ),
          
          Expanded(
           
            child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              child: ElevatedButton(
  
  onPressed: () {
     showDialog(context: context,
      builder: (context) =>  AlertDialog(
        content:Text('song Uploaded for other users to vote'),
        actions: [
         TextButton(
          onPressed: (){
            selectFiles();
          },
           child: Text('add song'),
           
           ),
           TextButton(
          onPressed: (){

     Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) =>voted()));

          },
           child: Text('cancel'),
           
           )

        ],
        
        )
      
      );
    },
  child: const Text('POST SONGS'),
)
            ),
          ),
        ],
      ),
    ),


    );
  }

  Widget buildListFile( file){
    return InkWell(
      onTap: (){
//widget.onOpenedFile(file);

      },
      child: ListTile(
        title: Text(file.name
        ),
       // subtitle: Text('${file.size}'),
        trailing: Text('${file.extension}'),
      ),
    );
  }
}