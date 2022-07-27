// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vox_vibe/homePage.dart';
import 'package:vox_vibe/videos.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main.dart';
import 'musicPlayer.dart';
import 'now.dart';
import 'nowPlaying.dart';

//import 'package:flutter_audio_query/flutter_audio_query.dart';
//import 'package:audio_manager/audio_manager.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MusicPage extends StatefulWidget {
  MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  //final AudioPlayer _audioPlayer =AudioPlayer();
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  final _audioquery = new OnAudioQuery();
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isplaying = false;
  int _selectedIndex = 0;
  PageController pageController = PageController();
  List<Widget> pages = [
    HomePage(),
    MusicPage(),
    const VideoPage(),
    MusicPage()
  ];

  //Colored Chips
  Container myColoredChips(String chipName) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: RaisedButton(
          color: new Color(0xffeadffd),
          child: Text(
            chipName,
            style: TextStyle(
              color: new Color(0xff6200ee),
            ),
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
    ));
  }

  //Grey Chips
  Container myChips(String chipName) {
    return Container(
      child: RaisedButton(
          color: const Color(0xffededed),
          child: Text(
            chipName,
            style: TextStyle(
              color: new Color(0xff6200ee),
            ),
          ),
          onPressed: () async {
            //  String filepath = await FilePicker.getFilePath();
            //int status =await _audioPlayer.play(filepath, isLocal: true);
            //  if(status == 1){
            //    setState(() {
            //      isplaying = true;
            //    });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
    );
  }

  //Divider
  Container categoryDivider() {
    return Container(
      height: 1.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.10,
        backgroundColor: Colors.indigo,
        leading: const Icon(
          Icons.account_tree,
          color: Colors.white,
        ),
        title: const Text("VOX_VIBE"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.account_tree),
              onPressed: () {
                //
              }),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            color: Colors.indigo, // set your color
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        child: Text('Songs'),
                        onPressed: () {
                          print('Pressed');
                        }),
                    TextButton(
                        child: Text('Playlist'),
                        onPressed: () {
                          print('Pressed');
                        }),
                    TextButton(
                        child: Text('Albums'),
                        onPressed: () {
                          print('Pressed');
                        }),
                    TextButton(
                        child: Text('Artists'),
                        onPressed: () {
                          print('Pressed');
                        }),
                    // IconButton(icon: Icon(Icons.search), onPressed: () {})
                  ],
                ),
                // set an icon or image
                // set your search bar setting
              ],
            ),
          ),
          // flexibleSpace: SafeArea(
        ),
      ),
      body: Stack(children: [
        FutureBuilder<List<SongModel>>(
            future: _audioquery.querySongs(
                sortType: null,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true),
            builder: (context, item) {
              if (item.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (item.data!.isEmpty) {
                return Center(
                  child: Text("No songs found"),
                );
              }
              return ListView.builder(
                itemBuilder: ((context, index) => ListTile(
                      leading: const Icon(Icons.music_note),
                      title: Text(item.data![index].displayNameWOExt),
                      subtitle: Text("${item.data![index].artist}"),
                      trailing: Icon(Icons.more_horiz),
                      onTap: () {
                        //  print(item.data![index]);
                        Navigator.push(
                        
                            context,
                            MaterialPageRoute(
                                builder: (context) => nowe(
                                      songModel: item.data![index],
                                    )));
                        // setState(() {
                        //   PlayerHome(
                        //     songModel: item.data![index],
                        //   );
                        // });

                        //playSong(item.data![index].uri);
                      },
                    )),
                itemCount: item.data?.length,
              );
            }),
            
      ]),
      //bottomNavigationBar:
      bottomNavigationBar: BottomNavBarFb5(),
    );
  }

  void playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log('Error parsing song');
    }
  }
}
//  someName() async {
//    final OnAudioQuery _audioQuery = OnAudioQuery();
//   List<SongModel> something = await _audioQuery.querySongs();  
    
    
//   }
