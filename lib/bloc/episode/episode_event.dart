part of 'episode_bloc.dart';

@immutable
sealed class EpisodeEvent {}
final class GetEpisodes extends EpisodeEvent{
  final int page;

  GetEpisodes({required this.page});
}
final class GetCharacterEpisodes extends EpisodeEvent{
  final String numbers;

  GetCharacterEpisodes({required this.numbers});
}