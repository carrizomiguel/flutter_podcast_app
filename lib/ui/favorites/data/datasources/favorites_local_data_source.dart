import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/storage/cached_constants.dart';
import 'package:podcast_app/core/storage/storage.dart';
import 'package:podcast_app/ui/shared/models/podcasts.dart';

abstract class FavoritesLocalDataSource {
  Future<List<PodcastModel>> getLastFavorites(); 
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  FavoritesLocalDataSourceImpl({required this.storage});

  final Storage storage;

  @override
  Future<List<PodcastModel>> getLastFavorites() async {
    try {
      if (await storage.hasKey(Cached.favorites)) {
        final value = await storage.read(Cached.favorites);
        return Future.value(podcastsFromJson(value));
      } else {
        throw EmptyException();
      }
    } catch (_) {
      throw CacheException();
    }
  }
}