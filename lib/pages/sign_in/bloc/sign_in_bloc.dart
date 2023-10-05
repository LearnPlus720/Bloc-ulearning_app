import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_events.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState>{
  SignInBloc(): super(const SignInState()){
    // on<EmailEvent>((event,emit){
    //   emit(state.copyWith(email: event.email));
    // });

    on<EmailEvent>(_emailEvent);

    // on<PasswordEvent>((event,emit){
    //   emit(state.copyWith(password: event.password));
    // });

    on<PasswordEvent>(_passwordEvent);


  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit){
    // print("my Email is ${event.email}");
    emit(state.copyWith(email: event.email));
  }
  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit){
    // print("my PasswordEvent is ${event.password}");
    emit(state.copyWith(password: event.password));
  }
}