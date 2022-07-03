import 'dart:convert';

import 'package:assisgnment_yellow/models/vid_model.dart';
import 'package:assisgnment_yellow/widget/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:numeral/numeral.dart';
import 'package:timeago/timeago.dart' as timeago;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = [
    "All",
    "Music",
    "Gaming",
    "Bollywood Music",
    "Live",
    "Comedy",
    "Coke Studio"
  ];
  String selectedCategory = "All";
  List vids = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    extractData();
  }

  Future<List<vid_model>> extractData() async {
    final json_data = await rootBundle.loadString("assets/dataset.json");
    final vidData = await json.decode(json_data) as List<dynamic>;

    return vidData.map((e) => vid_model.fromJson(e)).toList();
    // setState(() {
    //   vids = vidData[0];
    // });
    // //print(vidData['id']);
    // print(vidData[1]['title'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: navBar(),
        // body:  ListView.builder(
        //   controller: controller,
        //   itemBuilder: (context, i) {
        //     return Video(
        //       video: vidData[i],
        //     );
        //   }),

        body: FutureBuilder(
          future: extractData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text('${data.error}'));
            } else if (data.hasData) {
              var items = data.data as List<vid_model>;
              return ListView.builder(itemBuilder: (context, i) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: NetworkImage(items[i].coverPicture.toString()),
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      items[i].title.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Expanded(
                  //     child: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Column(children: [
                  //     Text(
                  //       items[i].title.toString(),
                  //       //style: Theme.of(context).textTheme.bodyText1,
                  //       //maxLines: 2,
                  //       //overflow: TextOverflow.ellipsis,
                  //     ),
                  //     // const SizedBox(
                  //     //   height: 5,
                  //     // ),
                  //     // Text(
                  //     //   "${items[i].title} • ${Numeral(int.parse(items[i].title.toString())).value()} ",
                  //     //   style: Theme.of(context).textTheme.caption,
                  //     //   maxLines: 1,
                  //     //   overflow: TextOverflow.ellipsis,
                  //     // ),
                  //   ]),
                  // ))
                ]);
              });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  AppBar navBar() {
    return AppBar(
      title: Image.asset(
        "images/logo.jpg",
        fit: BoxFit.contain,
        height: 45,
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.cast_rounded)),
        IconButton(
            onPressed: () {}, icon: Icon(Icons.notifications_none_rounded)),
        IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
        IconButton(onPressed: () {}, icon: Icon(Icons.account_circle_rounded)),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.explore_rounded,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Explore',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.grey[200])),
              SizedBox(
                  height: 30.0,
                  child: VerticalDivider(
                    thickness: 2,
                    color: Colors.grey,
                  )),
              Wrap(
                  spacing: 5,
                  children: categories
                      .map((category) => FilterChip(
                          showCheckmark: false,
                          label: Text(
                            category,
                            style: TextStyle(
                                color: selectedCategory == category
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          backgroundColor: Colors.grey.shade200,
                          selectedColor: Colors.grey.shade600,
                          selected: selectedCategory == category,
                          onSelected: (bool value) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }))
                      .toList())
            ],
          ),
        ),
      ),
    );
  }
}
