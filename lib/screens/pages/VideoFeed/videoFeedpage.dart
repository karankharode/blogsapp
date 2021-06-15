import 'package:blogsapp/screens/pages/VideoFeed/videoScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

PageController pageController;

class VideoFeedPage extends StatefulWidget {
  @override
  _VideoFeedPageState createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends State<VideoFeedPage> {
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.reference().child("Videos");
    pageController = PageController(initialPage: 0, viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: databaseReference.once(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List blogList = [];
                snapshot.data.value.forEach((key, value) {
                  blogList.add(value);
                });
                return PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {},
                    scrollDirection: Axis.vertical,
                    itemCount: blogList.length,
                    itemBuilder: (context, index) {
                      return VideoFeed(
                        title: "link goes here",
                        link:
                            "https://firebasestorage.googleapis.com/v0/b/news-app-bowe.appspot.com/o/news_video%2FVID_2021-04-18%2007-30-58.mp4?alt=media&token=fe90bcab-5460-45f6-afed-d4f68c016bd7",
                        autoplay: true,
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    ]);
  }
}
