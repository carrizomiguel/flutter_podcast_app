import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/network/api.dart';
import 'package:podcast_app/ui/detail/models/podcast_detail.dart';
import 'package:http/http.dart' as http;

abstract class DetailRemoteDataSource {
  Future<PodcastDetailModel> getPodcastDetail(String idPodcast);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  String keyLabel = Api.keyLabel;
  String keyValue = Api.keyValue;
  String authority = Api.authority;

  @override
  Future<PodcastDetailModel> getPodcastDetail(String idPodcast) async {
    final response = await http.get(
      Uri.https(
        authority,
        Api.podcastByIdPath(idPodcast),
      ),
      headers: {
        'Content-type': 'application/json',
        keyLabel: keyValue,
      },
    );
    switch (response.statusCode) {
      case 200:
        return podcastDetailFromJson(response.body);
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
