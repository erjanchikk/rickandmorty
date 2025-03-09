import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/models/episodeModel.dart';


import '../../repositorys/EpisodeRepository.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  EpisodeBloc() : super(EpisodeInitial()) {
    EpisodeRepository repository = EpisodeRepository();
    on<GetCharacterEpisodes>((event, emit) async {
      emit(EpisodeLoadingState());

      try {
         List<Episode> episode = await repository.getCharacterEpisodes(event.numbers);
        
        emit(EpisodeLoadedState(episode: episode));
      } catch (e) {
        emit(EpisodeErrorState(error: e.toString()));
      }
    });
    on<GetEpisodes>((event, emit) async {
      emit(EpisodeLoadingState());

      try {
        EpisodeModel episode = await repository.getEpisode(event.page);
        
        emit(EpisodeLoadedState(episode: episode.results??[]));
      } catch (e) {
        emit(EpisodeErrorState(error: e.toString()));

      }
    });
  }
}
