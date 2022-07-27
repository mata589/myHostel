import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vox_vibe/Playlistrequest.dart/model/liking.dart';
import 'package:vox_vibe/Playlistrequest.dart/providers/song_content.dart';
import 'package:vox_vibe/Playlistrequest.dart/providers/song_provider.dart';
import 'package:vox_vibe/Playlistrequest.dart/services/firestore_service.dart';
import 'package:vox_vibe/account/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vox_vibe/homePage.dart';
import 'package:vox_vibe/videos.dart';
import 'package:vox_vibe/welcome%20screen.dart';
import 'package:vox_vibe/Playlistrequest.dart/likedsongs.dart';
import 'browse.dart';
import 'music.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
void main()
async 
 {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreServices();
    final _liked = liked();
    return  MultiProvider(
      providers: [
         ChangeNotifierProvider(create:(context)=>songProvider(),),
        StreamProvider<List<like>>(create: (BuildContext context) => firestoreService.getLiked(), initialData: [], ),
          ChangeNotifierProvider(create:(context)=>SongContent(),),
      ],
      
      child: MaterialApp(
        title: 'Music Player',
        debugShowCheckedModeBanner: false,
        home:
        MainPage(),
        //SignInScreen(),
        // HomePage(),
      ),
    );
  }
}




class BottomNavBarFb5 extends StatelessWidget {
  const BottomNavBarFb5({Key? key}) : super(key: key);

  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryColor,
      child: SizedBox(
        height: 53,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25.0,
            right: 25.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBottomBar(
                  text: "Home",
                  icon: Icons.home,
                  selected: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }),
              IconBottomBar(
                  text: "music",
                  icon: Icons.music_note,
                  selected: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MusicPage()));
                  }),
              IconBottomBar(
                  text: "videos",
                  icon: Icons.video_library,
                  selected: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VideoPage()));
                  }),
              IconBottomBar(
                  text: "browse",
                  icon: Icons.browser_updated_outlined,
                  selected: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => browse()));
                  }),
              // IconBottomBar(
              //     text: "post",
              //     icon: Icons.post_add,
              //     selected: false,
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => PeoplePage()));
              //     })
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon:
              Icon(icon, size: 25, color: selected ? accentColor : Colors.grey),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 12,
              height: .1,
              color: selected ? accentColor : Colors.grey),
        )
      ],
    );
  }
}
