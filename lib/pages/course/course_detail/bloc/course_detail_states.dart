import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/entities/lesson.dart';

class CourseDetailStates {
  const CourseDetailStates({
    this.courseItem,
    this.lessonItem = const <LessonItem>[],
  });

  final CourseItem? courseItem;
  final List<LessonItem> lessonItem;

  CourseDetailStates copyWith(
      {CourseItem? courseItem, List<LessonItem>? lessonItem}) {
    return CourseDetailStates(
        courseItem: courseItem ?? this.courseItem,
        lessonItem: lessonItem ?? this.lessonItem);
  }
}
