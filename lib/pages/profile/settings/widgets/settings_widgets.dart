import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/routes/names.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/constant.dart';
import '../../../../global.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Container(
      margin: EdgeInsets.only(
        bottom: 5.h,
      ),
      child: Text(
        "Settings",
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize:14.sp,
        ),
      ),
    ),
  );
}


Widget settingsLogoutButton({ required BuildContext context, void Function()? LogoutFunc}) {
  return  GestureDetector(
    onTap: (){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Confirm logout"),
          content:const Text("Confirm logout"),
          actions: [
            TextButton(
                onPressed: ()=>Navigator.of(context).pop(), child: const Text("Cancel")
            ),
            TextButton(
                onPressed: LogoutFunc,
                child: const Text("Confirm")
            )
          ],
        );
      });
    },
    child: Container(
      height: 100.h,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/icons/Logout.png")
          )
      ),
    ),
  );
}