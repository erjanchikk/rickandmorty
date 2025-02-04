

import 'package:rickandmorty/helpers/api_requester.dart';
import 'package:rickandmorty/models/characterModel.dart';
import 'package:rickandmorty/models/episodeModel.dart';
import 'package:rickandmorty/models/locationModel.dart';

class Repository {
  ApiRequester apiRequester = ApiRequester();

  Future<CharacterModel> getCharacters(String page) async {
    final response =
        await apiRequester.getResponse("/character", {"page": page});
    return characterModelFromJson(response.body);
  }

    Future<CharacterModel> getCharacter(String id) async {
    final response =
        await apiRequester.getResponse("/character/$id", {});
    return characterModelFromJson(response.body);
  }

  Future<LocationModel> getLocation(String page) async {
    final response =
        await apiRequester.getResponse("/location", {"page": page});
    return locationModelFromJson(response.body);
  }

  Future<EpisodeModel> getEpisode(String page) async {
    final response =
        await apiRequester.getResponse("/episode", {"page": page});
    return episodeModelFromJson(response.body);
  }
}