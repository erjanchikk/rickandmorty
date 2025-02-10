part of 'episode_bloc.dart';

@immutable
sealed class EpisodeEvent {}

final class GetCharacterEpisodes extends EpisodeEvent{
  final String numbers;

  GetCharacterEpisodes({required this.numbers});
}