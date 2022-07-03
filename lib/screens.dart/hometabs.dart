import 'package:assisgnment_yellow/screens.dart/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Builder(
          builder: (context) => Scaffold(
            bottomNavigationBar: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.transparent,
              labelStyle: TextStyle(fontSize: 10),
              labelPadding: EdgeInsets.all(0),
              tabs: [
                Tab(height: 60, icon: Icon(Icons.home), text: "Home"),
                Tab(
                    height: 60,
                    icon: Icon(Icons.play_arrow_outlined),
                    text: "Shorts"),
                Tab(
                    height: 60,
                    icon: Icon(Icons.subscriptions_outlined),
                    text: "Subscriptions"),
                Tab(
                    height: 60,
                    icon: Icon(Icons.video_library_outlined),
                    text: "Library")
              ],
            ),
            body: TabBarView(
              children: [
                Home(),
                Center(
                  child: Text('Shorts'),
                ),
                Center(
                  child: Text('Subscription'),
                ),
                Center(
                  child: Text('Library'),
                )
              ],
            ),
          ),
        ));
  }
}
