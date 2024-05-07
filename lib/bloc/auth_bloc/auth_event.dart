part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  RegisterEvent({required this.email, required this.password});
}

class GotoRegisterationScreenEvent extends AuthEvent {}

class GotoLoginScreenEvent extends AuthEvent {}

class GoogleLoginEvent extends AuthEvent {}

class AppleLoginEvent extends AuthEvent {}

class ShowPasswordEvent extends AuthEvent {
  final bool isShow;
  ShowPasswordEvent({required this.isShow});
  @override
  List<Object?> get props => [isShow];
}

class LoggingInEvent extends AuthEvent {
  final String email;
  final String password;
  LoggingInEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirm;
  SignupEvent(
      {required this.email, required this.password, required this.confirm});
  @override
  List<Object?> get props => [email, password, confirm];
}

class IsLoggedInEvent extends AuthEvent {
  IsLoggedInEvent();
}
