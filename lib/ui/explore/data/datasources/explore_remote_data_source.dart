import 'dart:convert';

import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/network/api.dart';
import 'package:podcast_app/ui/explore/models/best_podcasts_model.dart';
import 'package:podcast_app/ui/explore/models/genres_model.dart';
import 'package:http/http.dart' as http;

abstract class ExploreRemoteDataSource {
  Future<List<GenresModel>> getGenres();
  Future<BestPodcastsModel> getBestPodcastsByGenre(int idGenre);
}

class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSource {
  String keyLabel = Api.keyLabel;
  String keyValue = Api.keyValue;
  String authority = Api.authority;
  String genresPath = Api.genresPath;
  String bestPodcastsPath = Api.bestPodcastsPath;

  @override
  Future<BestPodcastsModel> getBestPodcastsByGenre(
    int idGenre,
  ) async {
    final response = await http.get(
      Uri.https(
        authority,
        bestPodcastsPath,
        {'genre_id': idGenre.toString()},
      ),
      headers: {
        'Content-type': 'application/json',
        keyLabel: keyValue,
      },
    );
    switch (response.statusCode) {
      case 200:
        return bestPodcastsFromJson(response.body);
      case 401:
        throw WrongApiKeyException();
      case 429:
        throw FreePlanExceededException();
      case 500:
      default:
        throw ServerException();
    }
  }

  @override
  Future<List<GenresModel>> getGenres() async {
    final response = await http.get(
      Uri.https(authority, genresPath),
      headers: {
        'Content-type': 'application/json',
        keyLabel: keyValue,
      },
    );
    switch (response.statusCode) {
      case 200:
        Map decoded = json.decode(response.body);
        return List<GenresModel>.from(
          decoded['genres'].map((x) => GenresModel.fromJson(x))
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
