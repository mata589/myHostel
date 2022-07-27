import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
//import 'package:vox_vibe/musicPlayer.dart';

class nowPlaying extends StatefulWidget {
  const nowPlaying({Key? key, required this.songModel}) : super(key: key);
  final SongModel songModel;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _MyWidgetState extends State<nowPlaying> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isplaying = false;
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    child: Icon(
                      Icons.music_note,
                      size: 80,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    // "song name",
                    // widget.song.name,
                    widget.songModel.displayNameWOExt,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    // "artist name",
                    // widget.song.name,
                    widget.songModel.artist.toString() == "<unknown>"
                        ? "Unkown Artist"
                        : widget.songModel.artist.toString(),
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text("0.0"),
                      Expanded(
                        child: Slider(value: 0.0, onChanged: (value) {}),
                      ),
                      Text("0.0"),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous_outlined),
                        highlightColor: Colors.white,
                        iconSize: 40,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(_isplaying ? Icons.pause : Icons.play_arrow),
                        highlightColor: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          setState(() {
                            if (_isplaying) {
                              _audioPlayer.pause();
                            } else {
                              _audioPlayer.play();
                            }
                            _isplaying = !_isplaying;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next_outlined),
                        highlightColor: Colors.white,
                        iconSize: 40,
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
