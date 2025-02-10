import 'dart:ui';

import 'package:rickandmorty/models/characterModel.dart';

Color checkStatus(Status status) {
  switch (status) {
    case Status.ALIVE:
      return Color(0xff43D049);
    case Status.DEAD:
      return Color(0xffEB5757);
    default:
      return Color(0xff6E798C);
  }
}

String extractEpisodeNumbersAsString(List<String> episodeUrls) {
  List<int> numbers = episodeUrls.map((url) => int.parse(url.split('/').last)).toList();


  if (numbers.length == 1) {
    numbers.add(numbers.first);
  }

  return numbers.join(','); 
}