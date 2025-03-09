import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/models/characterModel.dart';
import 'package:rickandmorty/repositorys/characterRepository.dart';


part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterInitial()) {
    Repository repository = Repository();
    on<GetCharacters>((event, emit) async {
      emit(CharacterLoadingState());

      try {
        CharacterModel character = await repository.getCharacters(event.page);
        
        emit(CharacterLoadedState(character: character.results??[]));
      } catch (e) {
        emit(CharacterErrorState(error: e.toString()));
        print(e);
      }
    });
    on<GetCharactersInLocation>((event, emit) async {
      emit(CharacterLoadingState());

      try {
        List<Character> character = await repository.getCharactersInLocation(event.numbers);
        
        emit(CharacterLoadedState(character: character));
      } catch (e) {
        emit(CharacterErrorState(error: e.toString()));
      }
    });
    
  }
}
