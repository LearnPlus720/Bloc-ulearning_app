import 'package:ulearning_app/common/entities/course.dart';

class HomePageStates{
  final int index;
  final List<CourseItem> courseItem;

  const HomePageStates({
    this.courseItem = const  <CourseItem>[],
    this.index = 0
  });

  HomePageStates copyWith({int? index, List<CourseItem>? courseItem}){
    return HomePageStates(
        courseItem:courseItem??this.courseItem,
        index: index??this.index
    );
  }

}