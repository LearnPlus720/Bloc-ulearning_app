import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_states.dart';
import 'package:ulearning_app/pages/sign_in/sign_in_controller.dart';
// import 'package:ulearning_app/pages/sign_in/widgets/sign_in_widgets.dart';
import '../../common/routes/routes.dart';
import '../common_widgets.dart';
import '../../common/values/colors.dart';
import 'bloc/sign_in_events.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SignInBloc,SignInState>(
        builder: (context,state){
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: buildAppBar(titleText: "Log in"),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildThirdPartyLogin(context),
                      Center(child: reusableText("or just login using username and password")),
                      Container(
                        margin: EdgeInsets.only(top: 36.h),
                        padding:EdgeInsets.only(left: 25.w,right: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText("Email"),
                            SizedBox(height: 5.h,),
                            buildTextField(
                                hintText: "Enter your Email Address",
                                textType: "email",
                                iconName: "user",
                                onChanged:(value) {
                                  context.read<SignInBloc>().add(EmailEvent(value));
                                }

                            ),
                            reusableText("Password"),
                            SizedBox(height: 5.h,),
                            buildTextField(
                                hintText: "Enter your Password",
                                textType: "password",
                                iconName: "lock",
                                onChanged:(value) {
                                  context.read<SignInBloc>().add(PasswordEvent(value));
                                }
                            ),
                          ],
                        ),
                      ),
                      forgetPassword(),
                      SizedBox(height: 70.h,),
                      reusableButton(
                          ButtonTitle: "Log In" ,
                          topMargin: 30,
                          bgColor: AppColors.primaryElement,
                          titleColor: AppColors.primaryBackground,
                          borderColor: Colors.transparent,
                          onTap: (){
                            // Log In button clicked
                            SignInController(context: context).handleSignIn("email");
                          }
                      ),
                      reusableButton(
                          ButtonTitle: "Register",
                          topMargin: 10,
                          bgColor:AppColors.primaryBackground,
                          titleColor: AppColors.primaryText,
                          borderColor: AppColors.primaryFourthElementText,
                          onTap: (){
                            Navigator.of(context).pushNamed(AppRoutes.REGISTER);

                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

