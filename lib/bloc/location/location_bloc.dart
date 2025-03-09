import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/models/locationModel.dart';
import 'package:rickandmorty/repositorys/locationRepository.dart';



part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    LocationRepository repository = LocationRepository();
    on<GetLocations>((event, emit) async {
      emit(LocationLoadingState());

      try {
        LocationModel location = await repository.getLocation(event.page);
        
        emit(LocationLoadedState(location: location.results??[]));
      } catch (e) {
        emit(LocationErrorState(error: e.toString()));

      }
    });
    on<GetCharacterLocation>((event, emit) async {
      emit(LocationLoadingState());

      try {
        List<ResultLocation> location = await repository.getCharacterLocation(event.id);
        
        emit(LocationLoadedState(location: location));
      } catch (e) {
        emit(LocationErrorState(error: e.toString()));

      }
    });
  }
}
