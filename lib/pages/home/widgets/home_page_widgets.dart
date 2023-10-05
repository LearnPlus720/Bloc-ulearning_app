import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_states.dart';

import '../../../common/values/constant.dart';
import '../bloc/home_page_blocs.dart';
import '../bloc/home_page_events.dart';

AppBar buildAppBar({String? avatar }){
    return AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 7.w,right: 7.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Container(
                      width: 15.w,
                      height: 12.h,
                      child: Image.asset("assets/icons/menu.png"),
                    ),
                    GestureDetector(
                        child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    // image: AssetImage(avatar),
                                  image: NetworkImage("${AppConstants.SERVER_API_URL}$avatar"),
                                ),
                            ),
                        ),
                    ),
                ],
            ),
        ),
    );
}

Widget searchView(){
    return Row(
      children: [
          Container(
            width: 280.w,
            height: 40.h,
              // color: Colors.red,
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.circular(15.h),
              border: Border.all(color: AppColors.primaryFourthElementText),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 17.w),
                  width: 16.w,
                  height: 16.h,
                  child: Image.asset("assets/icons/search.png"),
                ),
                Container(
                  width: 240.w,
                  height: 40.w,
                  child: TextField(
                    onChanged: (value)=>{},
                    keyboardType: TextInputType.multiline,
                    decoration:  const InputDecoration(
                      hintText: "search your course",
                      hintStyle: TextStyle(
                        color: AppColors.primaryThirdElementText,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      border:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          )
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          )
                      ),

                    ),
                    style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp
                    ),
                    autocorrect: true,
                    obscureText: false,
                  ),
                ),
              ],
            ),
          ),
        GestureDetector(
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(13.w)),
              border: Border.all(color: AppColors.primaryElement ),
            ),
            child: Image.asset("assets/icons/options.png"),
          ),
        ),
      ],
    );
}


Widget slidersView(BuildContext context,HomePageStates state){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 20.h),
        width: 325.w,
        height: 160.h,
        child: PageView(
          onPageChanged: (value){
            print(value.toString());
            context.read<HomePageBloc>().add(HomePageDots(value));
          },
          children: [
            _slidersContainer(path: "assets/icons/art.png"),
            _slidersContainer(path: "assets/icons/Image(1).png"),
            _slidersContainer(path: "assets/icons/Image(2).png")
          ],
        ),
      ),
      Container(
        child: DotsIndicator(
          dotsCount: 3,
          position: state.index,
          decorator: DotsDecorator(
              color: AppColors.primaryThirdElementText,
              activeColor: AppColors.primaryElement,
              size: const Size.square(5.0),
              activeSize: const Size(17.0, 5.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        ),
      )
    ],
  );
}

// sliders widget
Widget _slidersContainer({required String path}){
  return Container(
    width: 325.w,
    height: 160.h,
    decoration:  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.h)),
        image:  DecorationImage(
          image: AssetImage("$path"),
        )
    ),
  );
}


//menu view for showing items

Widget menuView() {
  return Column(
          children: [
            Container(
              width: 325.w,
              margin: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Text(
                    "Choose your course",
                    style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp
                    ),
                  ),
                  GestureDetector(
                    child:  Text(
                      "See all",
                      style: TextStyle(
                          color: AppColors.primaryThirdElementText,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Row(
                children: [
                  _reusableMenuText(title: "All",active: true),
                  _reusableMenuText(title: "Popular"),
                  _reusableMenuText(title: "Newest"),
                ],
              ),
            ),
          ],
  );
}

Widget _reusableMenuText( {required String title,bool active=false}){
  return Container(

    margin: EdgeInsets.only(right: 20.w),
    padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 5.h,bottom: 5.h),
    decoration: BoxDecoration(
        color: active ?  AppColors.primaryElement : Colors.white,
        borderRadius: BorderRadius.circular(7.w),
        border: Border.all(color: active ? AppColors.primaryElement : Colors.transparent)
    ),
    child: Text(
      title,
      style: TextStyle(
          color: active ? AppColors.primaryElementText : AppColors.primaryThirdElementText,
          fontWeight: FontWeight.normal,
          fontSize: 11.sp
      ),
    ),

  );
}


// for course grid view ui
Widget courseGrid(CourseItem item){
    return Container(
            padding: EdgeInsets.all(12.w),
            // color: Colors.red,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                image:  DecorationImage(
                    fit: BoxFit.fill,
                    // image: AssetImage("assets/icons/art.png")
                  image: NetworkImage(AppConstants.SERVER_UPLOADS+item.thumbnail!)
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name??"",
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  softWrap: false,
                  style: TextStyle(
                      color: AppColors.primaryElementText,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp
                  ),
                ),
                SizedBox(height: 5.h,),
                Text(
                  item.description??"",
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  softWrap: false,
                  style: TextStyle(
                      color: AppColors.primaryFourthElementText,
                      fontWeight: FontWeight.normal,
                      fontSize: 8.sp
                  ),
                ),
              ],
            ),
          );
}