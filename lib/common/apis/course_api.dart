import 'package:ulearning_app/common/entities/base.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/utils/http_util.dart';

class CourseAPI{

  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post(
        'api/courseList'
    );
    // print(response.toString());
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseDetailResponseEntity> courseDetail({CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
        'api/courseDetail',
        queryParameters: params?.toJson()
    );
    print(response.toString());
    return CourseDetailResponseEntity.fromJson(response);
  }

  //for course payment
  static Future<BaseResponseEntity> coursePay({CourseRequestEntity? params}) async {
    var response=  await HttpUtil().post(
      'api/checkout',
      queryParameters: params?.toJson(),

    );

    return BaseResponseEntity.fromJson(response);
  }

}