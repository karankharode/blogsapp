import 'package:blogsapp/bloc/homepage_bloc/bloc/homepage_bloc.dart';
import 'package:blogsapp/constants/colors.dart';
import 'package:blogsapp/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat', accentColor: accentColor),
      home: BlocProvider(
        create: (context) => HomepageBloc(),
        child: MyBlog(),
      ),
    );
  }
}
