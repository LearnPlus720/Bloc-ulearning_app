import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';


import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_states.dart';
import 'widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // late HomeController _homeController;
  late UserItem userProfile;
  @override
  void initState(){
    super.initState();
    // _homeController = HomeController(context: context);
    // _homeController.init();

  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    userProfile = HomeController(context: context).userProfile!;
  }

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(
            avatar: userProfile!.avatar.toString()),
        body: RefreshIndicator(
          onRefresh: (){
              return HomeController(context: context).init();
          },
          child: BlocBuilder<HomePageBloc, HomePageStates>(
              builder: (context, state) {
                if(state.courseItem.isEmpty){
                  HomeController(context: context).init();
                }else{
                  print("course length ${state.courseItem.length}");

                }


                return Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
                  child: CustomScrollView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: Text(
                            "Hello,",
                            style: TextStyle(
                                color: AppColors.primaryThirdElementText,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(top: 5.h),
                          child: Text(
                            userProfile!.name!,
                            style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                      ),
                      SliverPadding(padding: EdgeInsets.only(top: 20.h),),
                      SliverToBoxAdapter(child: searchView()),
                      SliverToBoxAdapter(child: slidersView(context, state)),
                      SliverToBoxAdapter(child: menuView()),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            vertical: 18.h, horizontal: 0.w),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 1.6

                          ),
                          delegate: SliverChildBuilderDelegate(
                              childCount: state.courseItem.length,
                                  (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.COURSE_DETAIL,
                                      arguments: {
                                        "id":state.courseItem.elementAt(index).id
                                      }
                                    );
                                  },
                                  child: courseGrid(state.courseItem[index]),
                                );
                              }
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              }
          ),
        ),
      );

  }
}
