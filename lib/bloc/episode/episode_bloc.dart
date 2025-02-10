import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/models/episodeModel.dart';
import 'package:rickandmorty/repository/reposiry.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  EpisodeBloc() : super(EpisodeInitial()) {
    Repository repository = Repository();
    on<GetCharacterEpisodes>((event, emit) async {
      emit(EpisodeLoadingState());

      try {
        
         List<Resultat> episode = await repository.getCharacterEpisodes(event.numbers);
        
        emit(EpisodeLoadedState(episode: episode));
      } catch (e) {
        emit(EpisodeErrorState(error: e.toString()));
      }
    });
  }
}
