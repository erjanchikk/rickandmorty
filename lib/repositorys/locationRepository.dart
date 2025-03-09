import 'package:rickandmorty/helpers/api_requester.dart';

import '../models/locationModel.dart';

class LocationRepository {
  ApiRequester apiRequester = ApiRequester();
  
    Future<LocationModel> getLocation(int page) async {
    final response =
        await apiRequester.getResponse("/location", {"page": "$page"});
    return locationModelFromJson(response.body);
  }

  Future<List<ResultLocation>> getCharacterLocation(String id) async {
    final response =
        await apiRequester.getResponse("/location/$id", null);
    return locationFromJson(response.body);
  }
}