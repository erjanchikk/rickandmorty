part of 'character_bloc.dart';

@immutable
sealed class CharacterEvent {}

final class GetCharacters extends CharacterEvent{
  final String page;

  GetCharacters({required this.page});
}

final class GetCharacter extends CharacterEvent{
  final String id;

  GetCharacter({required this.id});
}