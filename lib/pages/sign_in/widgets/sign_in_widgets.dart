import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

AppBar buildAppBar(){
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.primarySecondaryBackground,
        height: 1.0,
      ),
    ),
    title: Text(
      "Log in",
      style: TextStyle(
        color: AppColors.primaryText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}


// we need context to access bloc
Widget buildThirdPartyLogin(BuildContext context){
  return Container(
    margin: EdgeInsets.only(
      top: 40.h,
      bottom: 40.h,
    ),
    padding: EdgeInsets.only(left: 25.w,right: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _reusableIcons(iconName: "google"),
        _reusableIcons(iconName: "apple"),
        _reusableIcons(iconName: "facebook"),


      ],
    ),
  );
}

Widget _reusableIcons({required String iconName}){
  return GestureDetector(
    onTap: ()=>{

    },
    child: SizedBox(
      width: 40.w,
      height: 40.h,
      child: Image.asset("assets/icons/$iconName.png"),
    ),
  );
}

Widget reusableText(String text){
  return Container(
    margin: EdgeInsets.only(
      bottom: 5.h,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.primaryThirdElementText,
        fontWeight: FontWeight.normal,
        fontSize:14.sp,
      ),
    ),
  );
}


Widget buildTextField({String? hintText,String? textType,String? iconName, void Function(String value)? onChanged }){

  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText)
    ),
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 13.w),
          child: Image.asset("assets/icons/$iconName.png"),
        ),
        Container(
          width: 270.w,
          height: 50.w,
          child: TextField(
            onChanged: (value)=>onChanged!(value),
            keyboardType: TextInputType.multiline,
            decoration:  InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.primaryThirdElementText,
              ),
              border:const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent
                  )
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent
                  )
              ),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent
                  )
              ),
              focusedBorder: const OutlineInputBorder(
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
            autocorrect: false,
            obscureText: textType=="password" ? true : false,
          ),
        ),
      ],
    ),
  );
}



Widget forgetPassword(){
  return Container(
    width: 260.w,
    height: 44.h,
    margin: EdgeInsets.only(left: 25.w,),
    child: GestureDetector(
      onTap: (){},
      child: Text(
        "Forget Password",
        style: TextStyle(
          color: AppColors.primaryText,
          decoration: TextDecoration.underline,
          fontSize: 12.sp,
          decorationColor: AppColors.primaryText
        ),
      ),
    ),

  );
}

Widget reusableButton({required String ButtonTitle,required int topMargin,required Color bgColor,required Color titleColor,required Color borderColor  ,void Function()? onTap                  }){
    return GestureDetector(
      onTap: ()=>onTap!(),
      child: Container(
        width: 325.w,
        height: 50.h,
        margin: EdgeInsets.only(left: 25.w,right: 25.w,top: topMargin.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          border: Border.all(
            color: borderColor
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
              color: Colors.grey.withOpacity(0.1),
            ),
          ]

        ),
        child: Center(
          child: Text(
              ButtonTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: titleColor,
            ),
          ),
        ),
      ),
    );
}