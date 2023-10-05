import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/lesson.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';

import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:video_player/video_player.dart';
import 'bloc/lesson_blocs.dart';
import 'bloc/lesson_events.dart';
import 'bloc/lesson_states.dart';
import 'lesson_controller.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {

  late LessonController _lessonController;
  int videoIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _lessonController = LessonController(context: context);
    context.read<LessonBloc>().add(const TriggerUrlItem(null));
    context.read<LessonBloc>().add(const TriggerVideoIndex(0));
    _lessonController.init();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _lessonController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonStates>(builder: (context, state)
    {
      return SafeArea(
        child: Container(
          color: Colors.white,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(titleText: "Lesson Detail"),
            body: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 25.w
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            // video preview
                            state.lessonVideoItem.isEmpty?Container():Container(
                              width: 325.w,
                              height: 200.h,
                              decoration:  BoxDecoration(
                                image:  DecorationImage(
                                  // image: AssetImage("assets/icons/video.png"),
                                  image: NetworkImage(state.lessonVideoItem[state.videoIndex].thumbnail!),
                                  fit: BoxFit.fitWidth
                                ),
                                  borderRadius: BorderRadius.circular(0.h),

                              ),
                              child: FutureBuilder(
                                future: state.initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  print('----video snapshot is ${snapshot.connectionState}----');
                                  //check if the connection is made to the certain video on the server
                                    if (snapshot.connectionState ==ConnectionState.done) {
                                      return _lessonController.videoPlayerController == null
                                          ? Container()
                                          :AspectRatio(
                                            aspectRatio: _lessonController.videoPlayerController!.value.aspectRatio,
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                VideoPlayer(_lessonController.videoPlayerController!),
                                                VideoProgressIndicator(
                                                    _lessonController.videoPlayerController!,
                                                    allowScrubbing: true,
                                                    colors: const VideoProgressColors(playedColor: AppColors.primaryElement) ,
                                                )
                                              ],
                                            ),

                                      );
                                    }else{
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                },
                              ),
                            ),
                            //video buttons
                            Container(
                              margin: EdgeInsets.only(top: 15.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //left button
                                    GestureDetector(
                                      onTap: () {
                                        var videoIndex = context.read<LessonBloc>().state.videoIndex;
                                        videoIndex = videoIndex-1;
                                        if(videoIndex<0){
                                          videoIndex=0;
                                          context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
                                          toastInfo(msg: "This is the first video you are watching");
                                          return;
                                        }else{
                                          var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                                          _lessonController.playVideo(videoItem.url!);
                                          print("videoIndex $videoIndex");
                                          print(videoItem.url);
                                        }
                                        context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
                                      },
                                      child: Container(
                                        width: 24.w,
                                        height: 24.w,
                                        margin: EdgeInsets.only(right: 15.w),
                                        child: Image.asset(
                                            "assets/icons/rewind-left.png"),
                                      ),
                                    ),
                                    //play and pause button
                                    GestureDetector(
                                        onTap: () {
                                          //if it's already playing
                                          if (state.isPlay) {
                                            _lessonController.videoPlayerController?.pause();
                                            context.read<LessonBloc>().add(const TriggerPlay(false));
                                          } else {
                                            //if it's not playing, then play
                                            _lessonController.videoPlayerController?.play();
                                            context.read<LessonBloc>().add(const TriggerPlay(true));
                                          }
                                        },
                                        child: state.isPlay
                                            ? Container(
                                          width: 24.w,
                                          height: 24.w,
                                          child: Image.asset(
                                              "assets/icons/pause.png"),
                                        )
                                            : Container(
                                          width: 24.w,
                                          height: 24.w,
                                          child: Image.asset(
                                              "assets/icons/play-circle.png"),
                                        )),
                                    //right videos
                                    //right videos
                                    GestureDetector(
                                      onTap: () {
                                        var videoIndex = context.read<LessonBloc>().state.videoIndex;
                                        videoIndex = videoIndex+1;
                                        if(videoIndex>=state.lessonVideoItem.length){
                                          //otherwise you will get overflow
                                          videoIndex=videoIndex-1;
                                          toastInfo(msg: "No videos in the play list");
                                          context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
                                          return;
                                        }else{
                                          var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                                          _lessonController.playVideo(videoItem.url!);
                                          print("videoIndex $videoIndex");
                                          print(videoItem.url);
                                        }
                                        context.read<LessonBloc>().add(TriggerVideoIndex(videoIndex));
                                      },
                                      child: Container(
                                        width: 24.w,
                                        height: 24.w,
                                        margin: EdgeInsets.only(left: 15.w),
                                        child: Image.asset(
                                            "assets/icons/rewind-right.png"),
                                      ),
                                    ),



                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                        padding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 25.w
                        ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context,index){
                              return _buildLessonItems(
                                  context : context,
                                  index : index,
                                  item: state.lessonVideoItem[index],
                                  lessonController: _lessonController
                              );

                            },
                          childCount: state.lessonVideoItem.length
                        ),
                      ),
                    ),
                  ],
            ),
          ),
        ),
      );
    });
  }
}

Widget _buildLessonItems({required BuildContext context, int? index=0, LessonVideoItem? item, LessonController? lessonController}) {
  return Container(
      width: 325.w,
      height: 80.h,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    child: InkWell(
      onTap: (){
        // videoIndex = index;
        context.read<LessonBloc>().add(TriggerVideoIndex(index!));
        lessonController?.playVideo(item.url!);
        print(item.url);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.h,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.w),
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage("${item!.thumbnail}")
                      )
                  ),
                ),
                Container(
                  width: 210.h,
                  height: 60.h,
                  alignment: Alignment.centerLeft,

                  margin: EdgeInsets.only(left: 6.sp),
                  child: reusableText(
                      "${item!.name}"
                  ),
                )
              ],
            ),
            Row(

              children: [
                GestureDetector(
                  onTap: (){
                    context.read<LessonBloc>().add(TriggerVideoIndex(index!));
                    lessonController?.playVideo(item.url!);
                  },
                  child: Image.asset(
                      width:24.w,
                      height:24.w,
                      "assets/icons/play-circle.png"
                  ),
                )
              ],
            )

        ],
      ),
    ),


  );
}