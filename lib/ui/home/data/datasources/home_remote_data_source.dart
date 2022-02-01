import 'dart:convert';

import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/network/api.dart';
import 'package:podcast_app/ui/home/models/selected_postcasts_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  Future<List<SelectedPodcastsModel>> getSelectedPodcasts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  String keyLabel = Api.keyLabel;
  String keyValue = Api.keyValue;
  String authority = Api.authority;
  String curatedPodcastsPath = Api.curatedPodcastsPath;

  @override
  Future<List<SelectedPodcastsModel>> getSelectedPodcasts() async {
    final response = await http.get(
      Uri.https(authority, curatedPodcastsPath),
      headers: {
        'Content-type': 'application/json',
        keyLabel: keyValue,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map decoded = json.decode(response.body);
        return List<SelectedPodcastsModel>.from(
          decoded["curated_lists"]
              .map((x) => SelectedPodcastsModel.fromJson(x)),
        );
      case 401:
        throw WrongApiKeyException();
      case 429:
        throw FreePlanExceededException();
      case 500:
      default:
        throw ServerException();
    }
  }
}
