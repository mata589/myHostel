import 'dart:ui';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
//import 'package:music_player_tutorial/database.dart';
//import 'package:music_player_tutorial/homePage.dart';
import 'package:vox_vibe/database.dart';
import 'package:vox_vibe/homePage.dart';

import 'musicPlayer.dart';

class MusicPlayer extends StatefulWidget {
  final Song song;
  MusicPlayer(this.song);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

bool isPlaying = false;
double currentSlider = 0;
String? currentTime = "00:00";
String? completeTime = '00:00';
late final SongModel songModel;

void setState(Null Function() param0) {}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    var songModel;
    return Stack(
      children: [
        Hero(
          tag: "image",
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.song.image), fit: BoxFit.cover)),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello, Pathway",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text("Vox Vibe", style: const TextStyle(fontSize: 10))
                ],
              ),
              const Padding(
                padding: const EdgeInsets.only(right: 8, left: 15),
                child:
                    const Icon(Icons.notifications_active_outlined, size: 30),
              )
            ],
          ),
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.2),
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: 1.5, color: Colors.white.withOpacity(0.2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.song.name,
                                // widget.songModel.displayNameWOExt,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.song.singer,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          widget.song.name,
                          //  widget.songModel.artist.toString(),
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 2),
                                trackShape: const RectangularSliderTrackShape(),
                                trackHeight: 6),
                            child: Slider(
                              value: currentSlider,
                              max: widget.song.duration.toDouble(),
                              min: 0,
                              inactiveColor: Colors.white70,
                              activeColor: Colors.red,
                              onChanged: (val) {
                                currentSlider = val;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  // Duration(seconds: currentSlider.toInt())
                                  //     .toString()
                                  //     .split('.')[0]
                                  //     .substring(2),
                                  // style: const TextStyle(color: Colors.white),

                                  "0.0"),
                              Text(
                                  // Duration(seconds: widget.song.duration.toInt())
                                  //     .toString()
                                  //     .split('.')[0]
                                  //     .substring(2),
                                  // style: const TextStyle(color: Colors.white),
                                  "0.0")
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(Icons.skip_previous_outlined,
                            //     color: Colors.white, size: 40),
                            IconButton(
                              icon: const Icon(Icons.skip_previous_outlined),
                              highlightColor: Colors.white,
                              iconSize: 40,
                              onPressed: () {},
                            ),

                            // Icon(Icons.pause, color: Colors.white, size: 50),
                            IconButton(
                              icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow),
                              highlightColor: Colors.white,
                              iconSize: 40,
                              onPressed: () {
                                if (isPlaying) {
                                  //_audioPlayer.pause();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                } else {
                                  //_audioPlayer.resume();
                                  isPlaying = true;
                                }
                              },
                            ),

                            // Icon(Icons.skip_next_outlined,
                            //     color: Colors.white, size: 40),
                            IconButton(
                              icon: const Icon(Icons.skip_next_outlined),
                              highlightColor: Colors.white,
                              iconSize: 40,
                              onPressed: () {},
                            ),
                            Text(
                              currentTime!,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),

                            Text(""),

                            Text(
                              currentTime!,
                              style: TextStyle(fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.replay_outlined,
                                  color: Colors.white, size: 40),
                              Icon(Icons.shuffle, color: Colors.white, size: 40)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
