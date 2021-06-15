import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'detail_page1.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogFeedPage extends StatefulWidget {
  @override
  _BlogFeedPageState createState() => _BlogFeedPageState();
}

class _BlogFeedPageState extends State<BlogFeedPage> {
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.reference().child("Blogs");
  }

  //Date Widget
  Widget getDate() => Container(
        alignment: Alignment.topLeft,
        child: Text(
          DateFormat('EEEE, d MMM').format(DateTime.now()),
          style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w700),
        ),
      );

  //Profile Picture Widget
  Widget getImage() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "No Ones Care",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),

          /*Container(
        child: CircleAvatar(
          child: InkWell(
            onTap: (){},
          ),
          maxRadius: 25,
          backgroundColor: Colors.deepOrange,
          backgroundImage: NetworkImage("https://avatars2.githubusercontent.com/u/29674485?s=460&v=4"),
        ),
      )*/
        ],
      );

  //List Item
  Widget getListItem(coverImage, title, author, time, authorImage) => Container(
        margin: EdgeInsets.only(right: 30),
        height: 350,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          image: DecorationImage(image: NetworkImage(coverImage), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 28,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 10),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
                            image: DecorationImage(
                                image: NetworkImage(authorImage), fit: BoxFit.cover)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      author,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          time,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      );

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  //Popular Widget
  Widget popularWidget(title, subtitle, time, like, image) => Container(
        //padding: EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            _launchURL(subtitle);
          },
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 4, bottom: 4),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
                      image: DecorationImage(image: NetworkImage(image)))),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle,
                      style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.access_time,
                              size: 18,
                            ),
                            onPressed: null),
                        Text(
                          time,
                          style: TextStyle(fontSize: 14),
                        ),
                        Padding(padding: EdgeInsets.only(left: 12)),
                        Icon(
                          Icons.thumb_up,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                        Padding(padding: EdgeInsets.only(left: 12)),
                        Text(
                          like,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 4,
          ),
          //Date Widget
          getDate(),

          SizedBox(
            height: 2,
          ),

          getImage(),

          SizedBox(
            height: 20,
          ),

          Container(
            width: double.infinity,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    hoverColor: Colors.white70,
                    splashColor: Colors.white,
                    enableFeedback: true,
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => DetailPage()));
                    },
                    child: getListItem(
                        "https://images.unsplash.com/photo-1498758536662-35b82cd15e29?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                        "Why The Freelance Life May Get Easier",
                        "Ted Milano",
                        "25 sec ago",
                        "https://images.unsplash.com/photo-1506919258185-6078bba55d2a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                  ),
                  InkWell(
                    hoverColor: Colors.white70,
                    enableFeedback: true,
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => DetailPage1()));
                    },
                    child: getListItem(
                        "https://images.unsplash.com/photo-1551298698-66b830a4f11c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                        "What Interior Designer should Care About",
                        "Daina Cruz",
                        "1 minute ago",
                        "https://images.unsplash.com/photo-1517365830460-955ce3ccd263?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                  )
                ],
              ),
            ),
          ),

          SizedBox(
            height: 30,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Popular",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ],
          ),

          SizedBox(
            height: 30,
          ),
          FutureBuilder<DataSnapshot>(
              builder: (context, projectSnap) {
                switch (projectSnap.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    List blogList = [];
                    projectSnap.data.value.forEach((key, value) {
                      blogList.add(value);
                    });
                    return Container(
                      height: (130 * projectSnap.data.value.length * 100) / 100,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: blogList.length,
                        itemBuilder: (context, index) {
                          return popularWidget(
                              blogList[index]["Info"]["title"],
                              blogList[index]["Info"]["link"],
                              "14 sec ago",
                              "786",
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIQD2lOj-t5HcuzLqYGOn-mrTHEgRiRILEphgYuXegZe-dQqlMiA");
                        },
                      ),
                    );
                  default:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }

                // if (projectSnap.connectionState == ConnectionState.none &&
                //     projectSnap.hasData == null) {
                //   print('project snapshot data is: ${projectSnap.data}');
                //   return Container();
                // }
                // projectSnap.data((key, value){
                //   print(value);

                // });
                // return ListView.builder(
                //   itemCount: projectSnap.data.length,
                //   itemBuilder: (context, index) {

                //     return popularWidget("DESIGN","Most Awaited - \nFigma Launches Plugin","14 sec ago","786","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIQD2lOj-t5HcuzLqYGOn-mrTHEgRiRILEphgYuXegZe-dQqlMiA");
                //   },
                // );
              },
              future: databaseReference.once())

          // InkWell(
          //   onTap: (){},
          //     child: popularWidget("DESIGN","Most Awaited - \nFigma Launches Plugin","14 sec ago","786","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIQD2lOj-t5HcuzLqYGOn-mrTHEgRiRILEphgYuXegZe-dQqlMiA")),

          // SizedBox(
          //   height: 30,
          // ),

          // InkWell(
          //   onTap: (){},
          //     child: popularWidget("TECH","Netflix Tests Using Activity Data","14 sec ago","120","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVteQvAa_awP21V_ClaLK89W1kdtSltiedJmRsjTcE-e9Pn9moDQ")),
        ],
      ),
    );
  }
}
