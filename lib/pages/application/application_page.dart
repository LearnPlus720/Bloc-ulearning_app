import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
import 'package:ulearning_app/pages/application/bloc/app_states.dart';
import '../../common/values/colors.dart';
import 'application_widgets.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state)
    {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: buildPage(state.index),
            bottomNavigationBar: Container(
              width: 375.w,
              height: 58.h,
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.only(

                  topLeft: Radius.circular(20.h),
                  topRight: Radius.circular(20.h),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (value) {
                  context.read<AppBloc>().add(TriggerAppEvent(value));
                  // print(value);
                  //
                  // setState(() {
                  //   _index = value;
                  // });
                },
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,

                unselectedItemColor: AppColors.primaryFourthElementText,
                items: [
                  BottomNavigationBarItemWidget(
                      labelText: "home", iconName: "home"),
                  BottomNavigationBarItemWidget(
                      labelText: "search", iconName: "search2"),
                  BottomNavigationBarItemWidget(
                      labelText: "course", iconName: "play-circle1"),
                  BottomNavigationBarItemWidget(
                      labelText: "chat", iconName: "message-circle"),
                  BottomNavigationBarItemWidget(
                      labelText: "profile", iconName: "person2"),


                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}


BottomNavigationBarItem BottomNavigationBarItemWidget({required String labelText, required String iconName}){
    return BottomNavigationBarItem(
    label: labelText,
    icon: SizedBox(
      width: 15.w,
      height: 15.h,
      child: Image.asset("assets/icons/$iconName.png"),
    ),

    activeIcon: SizedBox(
      width: 15.w,
      height: 15.h,
      child: Image.asset("assets/icons/$iconName.png" , color: AppColors.primaryElement,)
    ),

    );
}