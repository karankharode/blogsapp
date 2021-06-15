blocbuimport 'package:blogsapp/bloc/homepage_bloc/bloc/homepage_bloc.dart';
import 'package:blogsapp/screens/pages/BlogsFeedPage/BlogFeedPage.dart';
import 'package:blogsapp/screens/pages/ImageFeedPage/ImageFeedpage.dart';
import 'package:blogsapp/screens/pages/VideoFeed/videoFeedpage.dart';
import 'package:blogsapp/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlog extends StatelessWidget {
  final List navBarPagesList = [
    BlogFeedPage(),
    ImageFeedPage(),
    VideoFeedPage(),
    Center(
      child: Text("Profile Page"),
    ),
  ];

  changeIndex(context, index) {
    BlocProvider.of<HomepageBloc>(context)..add(ChangePageIndex(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
          height: 45,
          child: BlocBuilder<HomepageBloc, HomepageState>(
            builder: (context, state) {
              if (state is HomepageLoaded) {
                return buildBottomNavBar(state.index, changeIndex, context);
              } else {
                return buildBottomNavBar(0, changeIndex, context);
              }
            },
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            if (state is HomepageInitial) {
              return navBarPagesList[0];
            } else if (state is HomepageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomepageLoaded) {
              return navBarPagesList[state.index];
            } else if (state is HomePageError) {
              return Center(
                child: Text(
                    "There was some problem with \nLoading the Blogs !\nPlease Restart the App ! "),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )),
    );
  }
}
