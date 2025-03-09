part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}
final class GetLocations extends LocationEvent{
  final int page;

  GetLocations({required this.page});
}

final class GetCharacterLocation extends LocationEvent{
  final String id;

  GetCharacterLocation({required this.id});
}