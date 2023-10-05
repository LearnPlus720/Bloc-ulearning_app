import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';

import 'bloc/settings_blocs.dart';
import 'bloc/settings_states.dart';
import 'widgets/settings_widgets.dart';
import '../../application/bloc/app_blocs.dart';
import '../../application/bloc/app_events.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child:BlocBuilder<SettingsBloc, SettingStates>(
            builder: (context, state){
              return Container(
                        child:  Column(
                          children: [
                            settingsLogoutButton(
                                context: context,
                                LogoutFunc:(){
                                  // to make the application page to home again
                                  context.read<AppBloc>().add(const TriggerAppEvent(0));
                                  context.read<HomePageBloc>().add( const HomePageDots(0));
                                  Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
                                  Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
                                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SING_IN,(route)=> false);
                                }
                            )
                          ],
                        ),
              );
            }
            ),
        ),
    );
  }
}
