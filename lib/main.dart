import 'package:flutter/material.dart';
import './ui/post_comments_screen.dart';
import './ui/post_details_screen.dart';
import './ui/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        PostDetails.routeName: (ctx) => PostDetails(),
        PostComments.routeName: (ctx) => PostComments(),
      },
    );
  }
}
