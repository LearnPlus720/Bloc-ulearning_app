import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:ulearning_app/pages/course/lesson/lesson_detail.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_blocs.dart';
import 'package:ulearning_app/pages/course/paywebview/paywebview.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/home_page.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/register/register.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';

import 'package:ulearning_app/pages/application/application_page.dart';
import 'package:ulearning_app/pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:ulearning_app/pages/profile/settings/settings_page.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';

import 'names.dart';


class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
          route: AppRoutes.INITIAL,
          page: const Welcome(),
          bloc: BlocProvider(create: (_) => WelcomeBloc(),)
      ),
      PageEntity(
          route: AppRoutes.SING_IN,
          page: const SignIn(),
          bloc: BlocProvider(create: (_) => SignInBloc(),)
      ),
      PageEntity(
          route: AppRoutes.REGISTER,
          page: const Register(),
          bloc: BlocProvider(create: (_) => RegisterBloc(),)
      ),
      PageEntity(
          route: AppRoutes.APPLICATION,
          page: const ApplicationPage(),
          bloc: BlocProvider(create: (_)=>AppBloc(),)
      ),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(create: (_)=>HomePageBloc(),)
      ),
      PageEntity(
          route: AppRoutes.SETTINGS,
          page: const SettingsPage(),
          bloc: BlocProvider(create: (_)=>SettingsBloc(),)
      ),
      PageEntity(
          route: AppRoutes.COURSE_DETAIL,
          page: const CourseDetail(),
          bloc: BlocProvider(create: (_)=>CourseDetailBloc(),)
      ),
      PageEntity(
          route: AppRoutes.LESSON_DETAIL,
          page: const LessonDetail(),
          bloc: BlocProvider(create: (_)=>LessonBloc(),)
      ),
      PageEntity(
          route: AppRoutes.PAY_WEB_VIEW,
          page: const PayWebView(),
          bloc: BlocProvider(create: (_)=>PayWebViewBloc(),)
      ),
    ];
  }
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()){
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if(settings.name!=null){
      //check for route name macthing when navigator gets triggered.
      var result = routes().where((element) => element.route==settings.name);
      if(result.isNotEmpty){
        // print("valid route name ${settings.name}");
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        // print("the value of deviceFirstOpen is $deviceFirstOpen");

        if(result.first.route == AppRoutes.INITIAL && deviceFirstOpen ){
          // we started the app and already opened before

          bool isLoggedin = Global.storageService.getIsLoggedIn();
          if(isLoggedin){
            // if the user already signed In Go to Application page directly
            return MaterialPageRoute(builder: (_)=>const ApplicationPage(), settings: settings);
          }
          // if the user already opened before but not signed in Go to SignIn page directly
          return MaterialPageRoute(builder: (_)=>const SignIn(), settings:settings);

        }

        // if the user not opened before  Go to welcome page
        return MaterialPageRoute(builder: (_)=>result.first.page, settings: settings);

      }
    }
    //if(settings.name==null) return to sign in page
    print("invalid route name ${settings.name}");
    return MaterialPageRoute(builder: (_)=>const SignIn(), settings: settings);


  }

  }





//unify BlocProvider and routes and pages
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route,  required this.page,  this.bloc});
}