
import 'package:rickandmorty/helpers/api_requester.dart';
import 'package:rickandmorty/models/characterModel.dart';


class Repository {
  ApiRequester apiRequester = ApiRequester();

  Future<CharacterModel> getCharacters(int page) async {
    final response =
        await apiRequester.getResponse("/character", {"page": "$page"});
    return characterModelFromJson(response.body);
  }



Future<List<Character>> getCharactersInLocation(String numbers) async {
    final response =
        await apiRequester.getResponse("/character/$numbers", null);
    return resultFromJson(response.body);
  }

}

