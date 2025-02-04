part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationEvent {}

final class Register extends AuthorizationEvent {
  final String email;
  final String password;

  Register({required this.email, required this.password});
}

final class Login extends AuthorizationEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

final class CheckUser extends AuthorizationEvent {}
