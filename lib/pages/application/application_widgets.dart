import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulearning_app/pages/home/home_page.dart';

import '../profile/profile.dart';

Widget buildPage(int index){
  List<Widget> _widget=[
    const HomePage() ,
    Center(child: Text("Search"),) ,
    Center(child: Text("Course"),) ,
    Center(child: Text("Chat"),) ,
    const ProfilePage() ,

  ];

  return _widget[index];
}