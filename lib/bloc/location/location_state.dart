part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}
final class LocationLoadingState extends LocationState{

}
final class LocationLoadedState extends LocationState{
  final List<ResultLocation> location;

  LocationLoadedState({required this.location});
}
final class LocationErrorState extends LocationState{
  final String error;

  LocationErrorState({required this.error});
  
}