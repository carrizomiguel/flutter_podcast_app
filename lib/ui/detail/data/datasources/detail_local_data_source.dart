import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/storage/cached_constants.dart';
import 'package:podcast_app/core/storage/storage.dart';
import 'package:podcast_app/ui/detail/models/podcast_detail.dart';

abstract class DetailLocalDataSource {
  Future<void> cacheLastPodcastDetail(PodcastDetailModel model);
  Future<PodcastDetailModel> getLastPodcastDetail(String idPodcast);
}

class DetailLocalDataSourceImpl implements DetailLocalDataSource {
  DetailLocalDataSourceImpl({required this.storage});

  final Storage storage;

  @override
  Future<void> cacheLastPodcastDetail(
    PodcastDetailModel model,
  ) async {
    return await storage.write(
      Cached.podcastDetail,
      podcastDetailToJson(model),
    );
  }

  @override
  Future<PodcastDetailModel> getLastPodcastDetail(
    String idPodcast,
  ) async {
    try {
      final value = await storage.read(Cached.podcastDetail);
      final model = podcastDetailFromJson(value);
      if (model.id == idPodcast) {
        return Future.value(model);
      } else {
        throw EmptyException();
      }
    } catch (_) {
      throw CacheException();
    }
  }
}
