import 'package:flutter/material.dart';

import 'main.dart';

class browse extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('browse songs'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Container(),
        bottomNavigationBar: BottomNavBarFb5(),
      );
}
