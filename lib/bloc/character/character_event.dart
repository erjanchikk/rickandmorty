part of 'character_bloc.dart';

@immutable
sealed class CharacterEvent {}

final class GetCharacters extends CharacterEvent{
  final int page;

  GetCharacters({required this.page});
}

