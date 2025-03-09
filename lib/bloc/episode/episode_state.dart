part of 'episode_bloc.dart';

@immutable
sealed class EpisodeState {}

final class EpisodeInitial extends EpisodeState {}

final class EpisodeLoadingState extends EpisodeState{

}
final class EpisodeLoadedState extends EpisodeState{
  final List<Episode> episode;

  EpisodeLoadedState({required this.episode});
}
final class EpisodeErrorState extends EpisodeState{
  final String error;

  EpisodeErrorState({required this.error});
  
}