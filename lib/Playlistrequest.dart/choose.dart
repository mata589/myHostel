import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vox_vibe/Playlistrequest.dart/likedsongs.dart';
import 'package:vox_vibe/Playlistrequest.dart/upload.dart';
import 'package:vox_vibe/Playlistrequest.dart/vote.dart';

class choose extends StatefulWidget {
  const choose({Key? key}) : super(key: key);

  @override
  State<choose> createState() => _chooseState();
}

class _chooseState extends State<choose> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: (){
 Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) =>upload()));

            },
            child: const Text('CURRENT PLAYER'),
          ),
          const SizedBox(height: 30),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) =>const liked()));
            },
            child: const Text('REQUEST SONGS'),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                     Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) =>liked()));

                    
                  },
                  child: const Text('Open liked songs'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    
  }
}