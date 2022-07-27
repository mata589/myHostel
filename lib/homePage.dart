import 'dart:developer';
import 'dart:ffi';

//import 'package:audioplayers/audioplayers.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:vox_vibe/Playlistrequest.dart/choose.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:vox_vibe/music.dart';
//import 'package:audio_manager/audio_manager.dart';

import 'package:vox_vibe/musicPlayer.dart';
import 'package:vox_vibe/database.dart';
import 'package:vox_vibe/now.dart';
import 'package:vox_vibe/videos.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: const Icon(Icons.search),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Hello, vox vibe",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "music",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8, left: 15),
            child: Icon(
              Icons.notifications_active_outlined,
              size: 30,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
             Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) =>choose()),  
  );  

            },
            child: const Text('PlayList Request'),
          ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "most popular",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 20),
                //   child: Text(
                //     "popular",
                //     style: TextStyle(
                //         fontSize: 50,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white),
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                  child: Text(
                    "960 playlists",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: TrackWidget(refresh),
                ),
                CircleTrackWidget(
                  song: newRelease,
                  title: "new releases",
                  subtitle: "3456 songs",
                  notifyParent: refresh,
                ),
                CircleTrackWidget(
                  song: mostPopular,
                  title: "your playlist",
                  subtitle: "346 songs",
                  notifyParent: refresh,
                ),
                const SizedBox(
                  height: 130,
                )
              ],
            ),
          ),
        ],
      ),

      //bottomNavigationBar:
      bottomNavigationBar: BottomNavBarFb5(),
    );
  }

  refresh() {
    setState(() {});
  }
}

Song currentSong = Song(
    name: "title",
    singer: "singer",
    image: "assets/song1.jpg",
    duration: 100,
    color: Colors.black);
double currentSlider = 0;

class PlayerHome extends StatefulWidget {
  final SongModel songModel;

  const PlayerHome({Key? key, required this.songModel}) : super(key: key);
  //final Song song;
  //PlayerHome();

  @override
  _PlayerHomeState createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isplaying = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.songModel.uri!),
      ));
      _audioPlayer.play();
      _isplaying = true;
    } on Exception {
      log("Cannot Parse Song");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //         pageBuilder: (context, _, __) => nowe(songModel: item.data![index],)));
      },
      child: Container(
        height: 55,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(topRight: Radius.circular(0))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Hero(
                    tag: "image",
                    child: CircleAvatar(
                      // backgroundImage: Image.asset('assets/images/img_4.jpg'),
                      radius: 19,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "song name",
                        // widget.song.name,
                        widget.songModel.displayNameWOExt,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 7,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        // "artist name",
                        //widget.song.name,
                        widget.songModel.artist.toString() == "<unknown>"
                            ? "Unkown Artist"
                            : widget.songModel.artist.toString(),
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 7,
                          // fontWeight: FontWeight.bold
                        ),
                      ),

                      // Text(widget.song.name,
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold)),
                      // Text(widget.song.singer,
                      //     style: TextStyle(
                      //       color: Colors.white54,
                      //     ))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.pause, color: Colors.white, size: 30),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.skip_next_outlined, color: Colors.white, size: 30),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
          // FloatingActionButton(
          //     child: Icon(Icons.audiotrack),
          //     onPressed: () async {
          //       int status = await _audioPlayer.play(filepath, isLocal: true);

          //       if (status == 1) {
          //         setState(() {
          //           isPlaying = true;
          //         });
          //       }
          //     })

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       Duration(seconds: currentSlider.toInt())
          //           .toString()
          //           .split('.')[0]
          //           .substring(2),
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width - 120,
          //       child: SliderTheme(
          //         data: SliderTheme.of(context).copyWith(
          //           thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
          //           trackShape: RectangularSliderTrackShape(),
          //           trackHeight: 4,
          //         ),
          //         child: Slider(
          //           value: currentSlider,
          //           max: widget.song.duration.toDouble(),
          //           min: 0,
          //           inactiveColor: Colors.grey[500],
          //           activeColor: Colors.white,
          //           onChanged: (val) {
          //             setState(() {
          //               currentSlider = val;
          //             });
          //           },
          //         ),
          //       ),
          //     ),
          //     Text(
          //       Duration(seconds: widget.song.duration)
          //           .toString()
          //           .split('.')[0]
          //           .substring(2),
          //       style: TextStyle(color: Colors.white),
          //     )
          //   ],
          // )
        ]),
      ),
    );
  }
}

class TrackWidget extends StatelessWidget {
  final Function() notifyParent;
  TrackWidget(this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mostPopular.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            currentSong = mostPopular[index];
            currentSlider = 0;
            notifyParent();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: mostPopular[index].color,
                      blurRadius: 1,
                      spreadRadius: 0.3)
                ],
                image: DecorationImage(
                    image: AssetImage(mostPopular[index].image),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mostPopular[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(mostPopular[index].singer,
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircleTrackWidget extends StatelessWidget {
  final String title;
  final List<Song> song;
  final String subtitle;
  final Function() notifyParent;

  CircleTrackWidget(
      {required this.title,
      required this.song,
      required this.subtitle,
      required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              subtitle,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          // Container(
          //   height: 120,
          //   child: ListView.builder(
          //     itemCount: song.length,
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     itemBuilder: (BuildContext context, int index) {
          //       return GestureDetector(
          //         onTap: () {
          //           currentSong = song[index];
          //           currentSlider = 0;
          //           notifyParent();
          //         },
          //         child: Container(
          //           margin: EdgeInsets.symmetric(horizontal: 10),
          //           child: Column(
          //             children: [
          //               CircleAvatar(
          //                 backgroundImage: AssetImage(song[index].image),
          //                 radius: 40,
          //               ),
          //               SizedBox(
          //                 height: 5,
          //               ),
          //               Text(
          //                 song[index].name,
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //               Text(
          //                 song[index].singer,
          //                 style: TextStyle(color: Colors.white54),
          //               )
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
