part of 'character_bloc.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

final class CharacterLoadingState extends CharacterState{

}
final class CharacterLoadedState extends CharacterState{
  final List<Character> character;

  CharacterLoadedState({required this.character});
}
final class CharacterErrorState extends CharacterState{
  final String error;

  CharacterErrorState({required this.error});
  
}