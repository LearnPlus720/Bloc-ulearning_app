import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/apis/course_api.dart';
import '../../common/entities/user.dart';
import '../../global.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_events.dart';

class HomeController{
  late BuildContext context;
  // HomeController({required this.context});
  UserItem? get userProfile => Global.storageService.getUserProfile();
  static final HomeController _singleton= HomeController._external();

  HomeController._external();
  //this is a factory constructor
  //makes sure you have the the original only one instance
  factory HomeController({required BuildContext context}){
    _singleton.context  = context;
    return _singleton;
  }
  // static final HomeController _singleton= HomeController._external();
  Future<void> init() async {
    // make sure that user already logged in
    if(Global.storageService.getUserToken().isNotEmpty) {
      print("... home controller init method");
      var result = await CourseAPI.courseList();
      print("the result ${result.data![0].name}");
      if (result.code == 200) {
        print(result.data![0].name);
        if(context.mounted){
          context.read<HomePageBloc>().add(HomePageCourseItem(result.data!));
          return ;
        }
        // print("perfecrt");
        // print(result.data![0].name);
      } else {
        print(result.code);
        return ;
      }
    }else{
      print("User has already logged out ");
    }
    return ;
  }
}