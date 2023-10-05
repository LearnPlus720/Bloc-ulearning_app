import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_events.dart';
import 'package:ulearning_app/pages/register/bloc/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  RegisterBloc(): super(const RegisterState()){
    on<UserNameEvent>(_userNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
  }

  void _userNameEvent(UserNameEvent event, Emitter<RegisterState> emit){
    // print("my userName is ${event.userName}");
    emit(state.copywith(userName: event.userName));
  }
  void _emailEvent(EmailEvent event, Emitter<RegisterState> emit){
    // print("my Email is ${event.email}");
    emit(state.copywith(email: event.email));
  }
  void _passwordEvent(PasswordEvent event, Emitter<RegisterState> emit){
    // print("my PasswordEvent is ${event.password}");
    emit(state.copywith(password: event.password));
  }
  void _rePasswordEvent(RePasswordEvent event, Emitter<RegisterState> emit){
    // print("my RePassword is ${event.rePassword}");
    emit(state.copywith(rePassword: event.rePassword));
  }

}