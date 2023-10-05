import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_events.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_states.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingStates>{
  SettingsBloc():super(const SettingStates()){
    on<TriggerSettings>(_triggerSettings);
  }
  _triggerSettings(SettingsEvents event, Emitter<SettingStates> emit){
    emit(const SettingStates());
  }
}