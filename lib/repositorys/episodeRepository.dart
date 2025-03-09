import 'package:rickandmorty/helpers/api_requester.dart';
import 'package:rickandmorty/models/episodeModel.dart';

class EpisodeRepository {
  ApiRequester apiRequester = ApiRequester();

  Future<List<Episode>> getCharacterEpisodes(String numbers) async {
    final response =
        await apiRequester.getResponse("/episode/$numbers", null);
    return resultatFromJson(response.body);
  }
    Future<EpisodeModel> getEpisode(int page) async {
    final response =
        await apiRequester.getResponse("/episode", {"page": "$page"});
    return episodeModelFromJson(response.body);
  }

}