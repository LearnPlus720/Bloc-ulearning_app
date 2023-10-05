import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/register/register_controller.dart';

import '../../common/values/colors.dart';
import '../common_widgets.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_events.dart';
import 'bloc/register_states.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<RegisterBloc,RegisterState>(
        builder: (context,state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(titleText: "Sign Up"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Center(child: reusableText(
                      "Enter your details below and free sign up")),
                  Container(
                    margin: EdgeInsets.only(top: 60.h),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText("User name"),

                        buildTextField(
                            hintText: "Enter your user name",
                            textType: "name",
                            iconName: "user",
                            onChanged: (value) {
                              context.read<RegisterBloc>().add(UserNameEvent(value));
                            }

                        ),
                        reusableText("Email"),

                        buildTextField(
                            hintText: "Enter your email address",
                            textType: "email",
                            iconName: "user",
                            onChanged: (value) {
                              context.read<RegisterBloc>().add(EmailEvent(value));
                            }
                        ),
                        reusableText("Password"),

                        buildTextField(
                            hintText: "Enter your Password",
                            textType: "password",
                            iconName: "lock",
                            onChanged: (value) {
                              context.read<RegisterBloc>().add(PasswordEvent(value));
                            }
                        ),
                        reusableText("Re-enter password"),

                        buildTextField(
                            hintText: "Re-enter your password to confirm",
                            textType: "password",
                            iconName: "lock",
                            onChanged: (value) {
                              context.read<RegisterBloc>().add(RePasswordEvent(value));
                            }
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: reusableText(
                        "By creating an account you have to agree with our them & condition."),
                  ),
                  reusableButton(
                      ButtonTitle: "Sign Up",
                      topMargin: 30,
                      bgColor: AppColors.primaryElement,
                      titleColor: AppColors.primaryBackground,
                      borderColor: Colors.transparent,
                      onTap: () {
                        // Log In button clicked
                        RegisterController(context: context).handleEmailRegister();
                      }
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
