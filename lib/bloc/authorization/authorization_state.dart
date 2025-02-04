part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationState {}

final class AuthorizationInitial extends AuthorizationState {}

final class AuthorizationErrorState extends AuthorizationState {
  final String error;

  AuthorizationErrorState({required this.error});
}

final class AuthorizationSuccessState extends AuthorizationState {}
