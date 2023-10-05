import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/main.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_events.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_states.dart';

import '../../common/values/colors.dart';
import '../../common/values/constant.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Scaffold(
            body: BlocBuilder<WelcomeBloc,WelcomeState>(
              builder: (context,state){
                return Container(
                  margin: EdgeInsets.only(top: 30.h),
                  width: 375.w,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      PageView(
                        controller: pageController,
                        onPageChanged: (index){
                          state.page = index;
                          BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                          // print("index value is $index");
                        },
                        children: [
                          _page(
                            index: 1,
                            context: context,
                            title: "First see Learning",
                            subTitle: "Forget about a for of paper all knowledge in on learning",
                            imagePath : "assets/images/reading.png",
                            buttonName : "Next",
                          ),
                          _page(
                            index: 2,
                            context: context,
                            title: "Connect With Everyone",
                            subTitle: "Always keep in touch with your tutor & friend. Let's get connected",
                            imagePath : "assets/images/boy.png",
                            buttonName : "Next",
                          ),
                          _page(
                            index: 3,
                            context: context,
                            title: "Always Fascinated Learning",
                            subTitle: "Anywhere, anytime. The time is at our discretion so study whenever you want",
                            imagePath : "assets/images/man.png",
                            buttonName : "get started",
                          ),

                        ],
                      ),
                      Positioned(
                          bottom: 40.h,
                          child: DotsIndicator(
                            position: state.page,
                            dotsCount: 3,
                            mainAxisAlignment: MainAxisAlignment.center,
                            decorator: DotsDecorator(
                              color: AppColors.primaryThirdElementText,
                              activeColor: AppColors.primaryElement,
                              size: const Size.square(8.0),
                              activeSize: const Size(20.0,8.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                );
              },
            )
      ),
    );
  }

  Widget _page({ required int index,required BuildContext context , required String buttonName , required String title , required String subTitle, required String imagePath}){

    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 24.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w,right: 30.w),
          child: Text(
            subTitle,
            style: TextStyle(
              color: AppColors.primarySecondaryElementText,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
              if(index<3){
                    //animation
                pageController.animateToPage(
                  index,
                  duration :const Duration(milliseconds: 500),
                  curve: Curves.decelerate
                );
              }else{

                  // set shared preference that next time will not be the first time
                  // print("the value before is ${Global.storageService.getDeviceFirstOpen()}");
                  Global.storageService.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
                  // print("the value is ${Global.storageService.getDeviceFirstOpen()}");
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignIn()));

                  // Navigate using route
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SING_IN, (route) => false);

              }
          },
          child: Container(
            margin: EdgeInsets.only(top: 50.h,left: 25.w,right: 25.w),
            width: 325.w,
            height: 50.h,

            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),

              )],
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),

              ),
            ),

          ),
        ),
      ],
    );
  }
}
