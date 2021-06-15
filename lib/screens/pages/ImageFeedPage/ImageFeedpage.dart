import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ImageFeedPage extends StatefulWidget {
  @override
  _ImageFeedPageState createState() => _ImageFeedPageState();
}

class _ImageFeedPageState extends State<ImageFeedPage> {
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.reference().child("Images");
  }

  Widget _buildImageTile(coverImage, title, author, time, authorImage) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(right: 30),
          height: 350,
          width: double.infinity,
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
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 40),
      child: Column(children: [
        SizedBox(
          height: 4,
        ),
        Text(
          "No Ones Care",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 2,
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
                    height: (400 * projectSnap.data.value.length * 100) / 100,
                    child: ListView.builder(
                      itemCount: blogList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildImageTile(
                            "https://images.unsplash.com/photo-1498758536662-35b82cd15e29?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                            blogList[index]["Info"]["title"],
                            "Author Name",
                            "14 sec ago",
                            "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg");
                      },
                    ),
                  );
                  default:
                    return Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
            future: databaseReference.once()),
      ]),
    );
  }
}
