import 'package:blogsapp/screens/pages/VideoFeed/videoFeedpage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:cached_video_player/cached_video_player.dart';

class VideoFeed extends StatefulWidget {
  final String title;
  final String link;
  final autoplay;
  // VideoFeed(this.article, this.value, this.autoplay,this.key);

  VideoFeed({this.title, this.link, this.autoplay});

  @override
  _VideoFeed createState() => _VideoFeed();
}

class _VideoFeed extends State<VideoFeed> {
  final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();
  bool play = true;
  CachedVideoPlayerController controller;
  bool _showTitle = true;
  bool loading = true;
  bool changed;
  bool isLoading = false;

  // get path => null;
  //bool isLiked;
  // get isLiked => null;
  @override
  void initState() {
    controller = CachedVideoPlayerController.network(widget.link)
      ..initialize().then((value) {
        setState(() {
          loading = false;
          controller.play();
          changed = false;
          controller.setLooping(!widget.autoplay);
          controller.addListener(checkVideo);
        });
      });

    // controller = VideoPlayerController.network(
    //   widget.article.videoUrl,
    // )..initialize().then((value) {
    //     setState(() {
    //       loading = false;
    //       controller.play();
    //       controller.setLooping(true);
    //     });
    //   });
    super.initState();
  }

  checkVideo() {
    if (controller.value.position == Duration(seconds: 0, minutes: 0, hours: 0)) {
      changed = false;
      print('video Started');
    }

    if (controller.value.position == controller.value.duration && !changed && widget.autoplay) {
      pageController.nextPage(duration: Duration(milliseconds: 900), curve: Curves.easeIn);
      changed = true;
      // foryouController.previousPage(
      //     duration: Duration(milliseconds: 900), curve: Curves.easeIn);
      print('video Ended');
    }
  }

  @override
  void dispose() {
    controller.pause();
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        GestureDetector(
            onLongPress: () {
              controller.pause();
            },
            onLongPressEnd: (details) {
              controller.play();
            },
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity < 0) {
                controller.pause();
                setState(() {
                  play ? play = !play : null;
                });
              } else {
                pageController.page.round();
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
                controller.pause();
                setState(() {
                  play ? play = !play : null;
                });
              }
            },
            onDoubleTap: () {
              _globalKey.currentState.onTap();
            },
            onTap: () {
              if (!_showTitle) {
                setState(() {
                  _showTitle = !_showTitle;
                });
              } else {
                setState(() {
                  play = !play;
                });

                play ? controller.play() : controller.pause(); // volume
              }
            },
            child: Stack(
              children: [
                Container(
                    height: deviceSize.height,
                    width: deviceSize.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: (loading)
                        ? Center(child: CircularProgressIndicator())
                        : Center(child: CachedVideoPlayer(controller))),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.transparent,
                      (!_showTitle) ? Colors.black : Colors.black54
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  ),
                ),
                if (!play)
                  Positioned.fill(
                      child: Center(
                    child: Icon(Icons.play_arrow_rounded, size: 70, color: Colors.grey),
                  )),
                if (isLoading)
                  Positioned.fill(
                      child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Center(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  )),
              ],
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"),
                    radius: 20,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "No Ones Care",
                  ),
                ],
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: deviceSize.height * 0.7, right: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: deviceSize.height * 0.28,
                width: deviceSize.width * 0.8,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                              text:
                                  (_showTitle) ? "News Title" : "News Title and News Body expanded",
                              children: <TextSpan>[
                                TextSpan(
                                    text: (_showTitle) ? " ...more" : " ...less",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          _showTitle = !_showTitle;
                                        });
                                      })
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //color: Colors.black.withOpacity(0.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LikeButton(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            key: _globalKey,
                            onTap: null,
                            isLiked: true,
                            size: 30,
                            circleColor: CircleColor(start: Colors.red, end: Colors.red[300]),
                            bubblesColor: BubblesColor(
                                dotPrimaryColor: Colors.red, dotSecondaryColor: Colors.red[300]),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.red : Colors.grey,
                                size: 30,
                              );
                            },
                            likeCount: 69,
                            countBuilder: (int count, bool isLiked, String text) {
                              var color = isLiked ? Colors.red : Colors.grey;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  "Like",
                                  style: TextStyle(color: color),
                                );
                              } else
                                result = Text(
                                  text,
                                  style: TextStyle(color: color),
                                );
                              return result;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.black.withOpacity(0.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                          Text("Share")
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.black.withOpacity(0.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
