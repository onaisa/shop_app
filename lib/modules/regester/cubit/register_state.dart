part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoudingState extends RegisterState {}

class RegisterSucessState extends RegisterState {
  final UserModel userModel;

  RegisterSucessState(this.userModel);
}

class RegisterErorrState extends RegisterState {
  final String message;
  RegisterErorrState({required this.message});
}
