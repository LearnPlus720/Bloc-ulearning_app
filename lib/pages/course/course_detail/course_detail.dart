import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail_controller.dart';
import 'bloc/course_detail_blocs.dart';
import 'bloc/course_detail_events.dart';
import 'bloc/course_detail_states.dart';
import 'widgets/course_detail_widgets.dart';
class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {

  late CourseDetailController _courseDetailController;
  @override
  void initState(){
    super.initState();
    CourseItem firstData=CourseItem();
    context.read<CourseDetailBloc>().add( TriggerCourseDetail(firstData));
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 0), (){
      _courseDetailController = CourseDetailController(context: context);
      _courseDetailController.init();
    });

  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBloc, CourseDetailStates>(
        builder: (context, state)
    {
      // print("--- my item ${state.courseItem!.thumbnail.toString()}");
      if(state.courseItem==null){
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        )
      );
      }else {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar("Course Detail"),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Thumbnail(state.courseItem!.thumbnail.toString()),
                          SizedBox(height: 15.h,),
                          menuView(),
                          SizedBox(height: 15.h,),
                          //course description title
                          reusableText("Course Description"),
                          SizedBox(height: 15.h,),
                          descriptionText(
                              state.courseItem!.description.toString()),
                          SizedBox(height: 20.h,),
                          //course buy button
                          GestureDetector(
                            onTap: () {
                              _courseDetailController.goBuy(state.courseItem!.id);
                            },
                            child: goBuyButton("Go Buy"),
                          ),

                          SizedBox(height: 20.h,),
                          courseSummaryTitle(),
                          //course summary in list
                          courseSummaryView(context, state),
                          SizedBox(height: 20.h,),
                          //Lesson list title
                          reusableText("Lesson List"),
                          SizedBox(height: 20.h,),
                          //Course lesson list
                          courseLessonList(state)
                        ],
                      ),

                    ),


                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
